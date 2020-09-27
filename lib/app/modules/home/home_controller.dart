import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/shared/auth/auth_controller.dart';
import 'package:login/app/shared/auth/repositories/auth_repository_interface.dart';
import 'package:login/app/shared/repositories/entities/tax.dart';
import 'package:login/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:login/app/shared/utils/prefs.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  final ILocalStorage storage = Modular.get();

  final IAuthRepository _authRepository = Modular.get();

  _HomeBase() {
    init();
  }

  @action
  init() async {
    print('[LOAD BANK TAX]');
    getTaxList();
    await _authRepository.getTax();
  }

  getTaxList() async {
    var todoMapList = await _authRepository.getTax();

    // For loop to create a 'todo List' from a 'Map List'
    // for (int i = 0; i < count; i++) {
    //   todoList.add(Tax.fromJson(todoMapList[i]));
    // }

    var sicredi3x = Tax.fromJson(todoMapList[0]).tax3x;
    var sicredi6x = Tax.fromJson(todoMapList[0]).tax6x;
    var sicredi12x = Tax.fromJson(todoMapList[0]).tax12x;
    var sicredi24x = Tax.fromJson(todoMapList[0]).tax24x;
    var sicredi36x = Tax.fromJson(todoMapList[0]).tax36x;
    var sicredi48x = Tax.fromJson(todoMapList[0]).tax48x;
    var sicredi60x = Tax.fromJson(todoMapList[0]).tax60x;
    var sicredi72x = Tax.fromJson(todoMapList[0]).tax72x;
    var sicrediTax = Tax.fromJson(todoMapList[0]).tax;

    var santander3x = Tax.fromJson(todoMapList[1]).tax3x;
    var santander6x = Tax.fromJson(todoMapList[1]).tax6x;
    var santander12x = Tax.fromJson(todoMapList[1]).tax12x;
    var santander24x = Tax.fromJson(todoMapList[1]).tax24x;
    var santander36x = Tax.fromJson(todoMapList[1]).tax36x;
    var santander48x = Tax.fromJson(todoMapList[1]).tax48x;
    var santander60x = Tax.fromJson(todoMapList[1]).tax60x;
    var santander72x = Tax.fromJson(todoMapList[1]).tax72x;
    var santanderTax = Tax.fromJson(todoMapList[1]).tax;

    var bvFinanceira3x = Tax.fromJson(todoMapList[2]).tax3x;
    var bvFinanceira6x = Tax.fromJson(todoMapList[2]).tax6x;
    var bvFinanceira12x = Tax.fromJson(todoMapList[2]).tax12x;
    var bvFinanceira24x = Tax.fromJson(todoMapList[2]).tax24x;
    var bvFinanceira36x = Tax.fromJson(todoMapList[2]).tax36x;
    var bvFinanceira48x = Tax.fromJson(todoMapList[2]).tax48x;
    var bvFinanceira60x = Tax.fromJson(todoMapList[2]).tax60x;
    var bvFinanceirar72x = Tax.fromJson(todoMapList[2]).tax72x;
    var bvFinanceiraTax = Tax.fromJson(todoMapList[2]).tax;

// PARA CARTAO DE CREDITO SOMENTE UMA TAXA PARA TODAS AS BANDEIRAS (MEDIANA)
//#TODO VER ISSO COM O DAVID

    var cartaoCredito3x = Tax.fromJson(todoMapList[3]).tax3x;
    var cartaoCredito6x = Tax.fromJson(todoMapList[3]).tax6x;
    var cartaoCredito12x = Tax.fromJson(todoMapList[3]).tax12x;
    var cartaoCredito24x = Tax.fromJson(todoMapList[3]).tax24x;
    var cartaoCredito36x = Tax.fromJson(todoMapList[3]).tax36x;
    var cartaoCredito48x = Tax.fromJson(todoMapList[3]).tax48x;
    var cartaoCredito60x = Tax.fromJson(todoMapList[3]).tax60x;
    var cartaoCredito72x = Tax.fromJson(todoMapList[3]).tax72x;
    var cartaoCreditoTax = Tax.fromJson(todoMapList[3]).tax;

    List<String> someMap = [
      'Sicredi:$sicredi3x,$sicredi6x,$sicredi12x,$sicredi24x,$sicredi36x,$sicredi48x,$sicredi60x,$sicredi72x,$sicrediTax',
      'Santander:$santander3x,$santander6x,$santander12x,$santander24x,$santander36x,$santander48x,$santander60x,$santander72x,$santanderTax',
      'BVFinanceira:$bvFinanceira3x,$bvFinanceira6x,$bvFinanceira12x,$bvFinanceira24x,$bvFinanceira36x,$bvFinanceira48x,$bvFinanceira60x,$bvFinanceirar72x,$bvFinanceiraTax,',
      'Cartao de Crédito:$cartaoCredito3x,$cartaoCredito6x,$cartaoCredito12x,$cartaoCredito24x,$cartaoCredito36x,$cartaoCredito48x,$cartaoCredito48x,$cartaoCredito60x,$cartaoCredito72x,$cartaoCreditoTax',
    ];

    Prefs.setStringList("TAX", someMap);

    // print(Tax.fromJson(todoMapList['BANCO']));

    // return todoList;
  }

  logoff() async {
    await Modular.get<AuthController>().logout();
    Modular.to.pushReplacementNamed('/login');
  }

  getDataLogin() async {
    await Modular.get<AuthController>().getDataLogin();
  }
}
