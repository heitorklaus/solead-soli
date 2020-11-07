import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:framework/ui/form/buttons/primary_button.dart';
import 'package:framework/ui/form/inputs/input_type.dart';
import 'package:framework/ui/form/inputs/outlined_text_edit.dart';
import 'package:login/app/shared/repositories/entities/powerPlantsOnline.dart';
import 'package:login/app/shared/styles/main_colors.dart';
import 'package:login/app/shared/styles/main_style.dart';
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
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

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
      body: arguments['mode'] == 'edit' ? _buildEdit(context, arguments['id']) : _buildList(context, Axis.vertical),
    );
  }

  // simulate a http request
  Future<Null> _onRefresh() {
    controller.getAll();
  }

  Widget _buildEdit(BuildContext context, id) {
    controller.fillEditText(id);
    return Observer(builder: (BuildContext context) {
      final PowerPlantsOnline list = controller.lista2.value;

      if (list == null) {
        return Center(child: Container(child: CircularProgressIndicator()));
      } else {
        return Container(
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                color: Colors.white,
                child: Wrap(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.verified_user, color: Colors.blue),
                        SizedBox(width: 10),
                        Text(
                          'Dados do cliente',
                          style: ubuntu16BlueBold500,
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 18),
                      child: OutlinedTextEdit(
                        //controller: controller.editClienteController,
                        prefixIcon: Icon(Icons.account_circle),
                        onChanged: (value) => {},
                        controller: controller.editClienteController,
                        label: "Nome do cliente",
                        inputType: InputType.EXTRA_SMALL,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.content_paste),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 18),
                      child: OutlinedTextEdit(
                        prefixIcon: Icon(Icons.chat),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => {},
                        controller: controller.editCPFController,
                        label: "CPF do cliente",
                        inputType: InputType.EXTRA_SMALL,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.content_paste),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 18),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedTextEdit(
                              prefixIcon: Icon(Icons.assistant_photo),
                              keyboardType: TextInputType.number,
                              onChanged: (value) => {},
                              label: "CEP",
                              controller: controller.editCEPController,
                              inputType: InputType.EXTRA_SMALL,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.content_paste),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: OutlinedTextEdit(
                              prefixIcon: Icon(Icons.dialpad),
                              keyboardType: TextInputType.text,
                              onChanged: (value) => {},
                              label: "Bairro",
                              controller: controller.editBairroController,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.content_paste),
                              ),
                              inputType: InputType.EXTRA_SMALL,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 18),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: OutlinedTextEdit(
                              prefixIcon: Icon(Icons.dvr),
                              keyboardType: TextInputType.text,
                              onChanged: (value) => {},
                              label: "Endereço",
                              controller: controller.editEnderecoController,
                              inputType: InputType.EXTRA_SMALL,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.content_paste),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: OutlinedTextEdit(
                              prefixIcon: Icon(Icons.texture),
                              keyboardType: TextInputType.text,
                              onChanged: (value) => {},
                              label: "Número",
                              controller: controller.editNumeroController,
                              inputType: InputType.EXTRA_SMALL,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.view_module, color: Colors.blue),
                            SizedBox(width: 10),
                            Text(
                              'Dados da Usina',
                              style: ubuntu16BlueBold500,
                            ),
                            Spacer(),
                            IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.arrow_drop_down_circle, color: MainColors.cielo),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(),
                    Visibility(
                      visible: true,
                      child: Wrap(
                        children: [
                          Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: OutlinedTextEdit(
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) => {},
                                    label: "Inversor",
                                    controller: controller.editInversorController,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.content_paste),
                                    ),
                                    inputType: InputType.EXTRA_SMALL,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: OutlinedTextEdit(
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) => {},
                                    label: "Garantia",
                                    controller: controller.editGarantiaController,
                                    inputType: InputType.EXTRA_SMALL,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: OutlinedTextEdit(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => {},
                                    label: "Potência",
                                    controller: controller.editPotenciaController,
                                    inputType: InputType.EXTRA_SMALL,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: OutlinedTextEdit(
                                    prefixIcon: Icon(Icons.view_comfy),
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) => {},
                                    label: "Módulos",
                                    controller: controller.editModulosController,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.content_paste),
                                    ),
                                    inputType: InputType.EXTRA_SMALL,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: OutlinedTextEdit(
                                    prefixIcon: Icon(Icons.format_list_numbered),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => {},
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.content_paste),
                                    ),
                                    label: "Quant.",
                                    controller: controller.editQuantidadeController,
                                    inputType: InputType.EXTRA_SMALL,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: OutlinedTextEdit(
                                    prefixIcon: Icon(Icons.usb),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => {},
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.content_paste),
                                    ),
                                    label: "Geração kWp",
                                    controller: controller.editGeracaoController,
                                    inputType: InputType.EXTRA_SMALL,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: OutlinedTextEdit(
                                    prefixIcon: Icon(Icons.aspect_ratio),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => {},
                                    label: "Área",
                                    controller: controller.editAreaController,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.content_paste),
                                    ),
                                    inputType: InputType.EXTRA_SMALL,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: OutlinedTextEdit(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => {},
                                    label: "Código",
                                    controller: controller.editCodigoController,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.content_paste),
                                    ),
                                    inputType: InputType.EXTRA_SMALL,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: OutlinedTextEdit(
                                    prefixIcon: Icon(Icons.monetization_on),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) => {},
                                    controller: controller.editValorController,
                                    label: "R\$ Valor",
                                    inputType: InputType.EXTRA_SMALL,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: OutlinedTextEdit(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 20,
                                    minLines: 10,
                                    suffixIcon: IconButton(icon: Icon(Icons.content_paste), onPressed: () {}),
                                    onChanged: (value) => {},
                                    label: "Dados da usina",
                                    controller: controller.editDadosController,
                                    inputType: InputType.EXTRA_SMALL,
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 22, bottom: 30),
                child: Row(
                  children: [
                    Observer(builder: (BuildContext context) {
                      if (controller.disableAdd == false) {
                        return Expanded(child: Center(child: CircularProgressIndicator()));
                      } else {
                        return Expanded(
                          child: PrimaryButton(
                              child: Text(
                                'Atualizar',
                                style: buttonLargeWhite,
                              ),
                              //onPressed:controller.loginWithGoogle,

                              onPressed: () {
                                controller.updatePlant(id);
                              }).getLarge(),
                        );
                      }
                    })
                  ],
                ),
              )
            ],
          )),
        );
      }
    });
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return Observer(builder: (BuildContext context) {
      List list = controller.lista.value;

      if (list == null) {
        return Center(child: Container(child: CircularProgressIndicator()));
      }
      if (list.isEmpty) {
        return Center(child: Container(child: CircularProgressIndicator()));
      }
      if (list.isNotEmpty) {
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: Container(
            child: ListView.separated(
              itemCount: list.length,
              itemBuilder: (_, index) {
                var item = list[index];

                return _getSlidableWithDelegates(context, index, Axis.horizontal, item.cliente, list);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
        );
      }
    });
  }

  Widget _getSlidableWithDelegates(BuildContext context, int index, Axis direction, String value, list) {
    final PowerPlantsOnline item = list[index];
    var xa = index;
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
      child: VerticalListItem(list[index], value, xa, list),
      actionDelegate: SlideActionBuilderDelegate(
          actionCount: 2,
          builder: (context, index, animation, renderingMode) {
            if (index == 0) {
              return IconSlideAction(
                caption: 'Negociar',
                color: renderingMode == SlidableRenderingMode.slide ? Colors.blue.withOpacity(animation.value) : (renderingMode == SlidableRenderingMode.dismiss ? Colors.blue : Colors.green),
                icon: Icons.assistant,
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
                caption: 'Editar',
                color: renderingMode == SlidableRenderingMode.slide ? Colors.grey.shade200.withOpacity(animation.value) : Colors.grey.shade200,
                icon: Icons.mode_edit,
                // onTap: () => print(list[xa]),

                onTap: () {
                  Modular.to.pushNamed('/plants', arguments: {'mode': 'edit', 'id': list[xa].id});
                },
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
    return SlidableStrechActionPane();
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class VerticalListItem extends StatelessWidget {
  VerticalListItem(this.item, this.cliente, this.counter, this.list);
  final item;
  final String cliente;
  final counter;
  List<PowerPlantsOnline> list;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Slidable.of(context)?.renderingMode == SlidableRenderingMode.none ? Slidable.of(context)?.open() : Slidable.of(context)?.close(),
      child: Container(
        color: (counter % 2 == 0) ? Colors.white70 : Colors.white30,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('${list.length - counter}'),
            foregroundColor: Colors.white,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(list[counter].cliente), Text(list[counter].data_cadastroUnused.split("T")[0].split("-")[2] + "/" + list[counter].data_cadastroUnused.split("T")[0].split("-")[1] + "/" + list[counter].data_cadastroUnused.split("T")[0].split("-")[0])],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Potência: ' + list[counter].potencia + ' kWp'),
              Text(list[counter].valor),
            ],
          ),
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
