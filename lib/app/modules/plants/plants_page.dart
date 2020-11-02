import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:login/app/shared/repositories/entities/plants_list.dart';
import 'package:login/app/shared/repositories/entities/powerPlantsOnline.dart';
import 'plants_controller.dart';

class PlantsPage extends StatefulWidget {
  final String title;
  const PlantsPage({Key key, this.title = "Plants"}) : super(key: key);

  @override
  _PlantsPageState createState() => _PlantsPageState();
}

class _PlantsPageState extends ModularState<PlantsPage, PlantsController> {
  //use 'controller' variable to access controller

  final controller = Modular.get<PlantsController>();

  SlidableController slidableController;

  @protected
  void initState() {
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    super.initState();
  }

  Animation<double> _rotationAnimation;
  Color _fabColor = Colors.blue;

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      _fabColor = isOpen ? Colors.green : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              controller.getAll();
            },
          ),
        ],
        title: Text(widget.title),
      ),
      // body: Observer(builder: (BuildContext context) {
      //   List<PowerPlantsOnline> list = controller.lista.value;

      //   if (list == null) {
      //     return Center(child: Container(child: CircularProgressIndicator()));
      //   } else {
      //     return Container(
      //       child: ListView.builder(
      //           itemCount: list.length,
      //           itemBuilder: (_, index) {
      //             var item = list[index];
      //             return ListTile(title: Text(item.cliente));
      //           }),
      //     );
      //   }
      // }),

      body: Center(
        child: OrientationBuilder(
          builder: (context, orientation) => _buildList(context, orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal),
        ),
      ),
    );
  }

  // simulate a http request
  Future<Null> _onRefresh() {
    controller.getAll();
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return Observer(builder: (BuildContext context) {
      List list = controller.lista.value;

      if (list == null) {
        return Center(child: Container(child: CircularProgressIndicator()));
      } else {
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: Container(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, index) {
                  var item = list[index];

                  return _getSlidableWithDelegates(context, index, Axis.horizontal, item.cliente, list);
                }),
          ),
        );
      }
    });
  }

  Widget _getSlidableWithDelegates(BuildContext context, int index, Axis direction, String value, list) {
    final PowerPlantsOnline item = list[index];

    return Slidable.builder(
      key: Key(list[index].toString()),
      controller: slidableController,
      direction: direction,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        closeOnCanceled: true,
        onWillDismiss: (index != 10)
            ? null
            : (actionType) {
                return showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Delete'),
                      content: Text('Item will be deleted'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        FlatButton(
                          child: Text('Ok'),
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                      ],
                    );
                  },
                );
              },
        onDismissed: (actionType) {
          _showSnackBar(context, actionType == SlideActionType.primary ? 'Dismiss Archive' : 'Dimiss Delete');
          setState(() {
            //  items.removeAt(index);
            list.removeAt(index);
          });
        },
      ),
      actionPane: _getActionPane(index),
      actionExtentRatio: 0.25,
      child: VerticalListItem(list[index], value, index),
      actionDelegate: SlideActionBuilderDelegate(
          actionCount: 2,
          builder: (context, index, animation, renderingMode) {
            if (index == 0) {
              return IconSlideAction(
                caption: 'Archive',
                color: renderingMode == SlidableRenderingMode.slide ? Colors.blue.withOpacity(animation.value) : (renderingMode == SlidableRenderingMode.dismiss ? Colors.blue : Colors.green),
                icon: Icons.archive,
                onTap: () async {
                  var state = Slidable.of(context);
                  var dismiss = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete'),
                        content: Text('Item will be deleted'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      );
                    },
                  );

                  if (dismiss) {
                    state.dismiss();
                  }
                },
              );
            } else {
              return IconSlideAction(
                caption: 'Share',
                color: renderingMode == SlidableRenderingMode.slide ? Colors.indigo.withOpacity(animation.value) : Colors.indigo,
                icon: Icons.share,
                onTap: () => _showSnackBar(context, 'Share'),
              );
            }
          }),
      secondaryActionDelegate: SlideActionBuilderDelegate(
          actionCount: 2,
          builder: (context, index, animation, renderingMode) {
            if (index == 0) {
              return IconSlideAction(
                caption: 'More',
                color: renderingMode == SlidableRenderingMode.slide ? Colors.grey.shade200.withOpacity(animation.value) : Colors.grey.shade200,
                icon: Icons.more_horiz,
                onTap: () => _showSnackBar(context, 'More'),
                closeOnTap: false,
              );
            } else {
              return IconSlideAction(
                caption: 'Delete',
                color: renderingMode == SlidableRenderingMode.slide ? Colors.red.withOpacity(animation.value) : Colors.red,
                icon: Icons.delete,
                onTap: () => _showSnackBar(context, 'Delete'),
              );
            }
          }),
    );
  }

  static Widget _getActionPane(int index) {
    switch (index % 4) {
      case 0:
        return SlidableBehindActionPane();
      case 1:
        return SlidableStrechActionPane();
      case 2:
        return SlidableScrollActionPane();
      case 3:
        return SlidableDrawerActionPane();
      default:
        return null;
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class VerticalListItem extends StatelessWidget {
  VerticalListItem(this.item, this.cliente, this.counter);
  final item;
  final String cliente;
  final counter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Slidable.of(context)?.renderingMode == SlidableRenderingMode.none ? Slidable.of(context)?.open() : Slidable.of(context)?.close(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('$counter'),
            foregroundColor: Colors.white,
          ),
          title: Text('$cliente'),
          subtitle: Text('$cliente'),
        ),
      ),
    );
  }
}

class _HomeItem {
  const _HomeItem(
    this.index,
    this.title,
    this.subtitle,
    this.color,
  );

  final int index;
  final String title;
  final String subtitle;
  final Color color;
}
