import 'dart:convert';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/app_module.dart';
import 'package:login/app/modules/plants/plants_interface.dart';
import 'package:login/app/shared/auth/auth_controller.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/entities/plants_list.dart';
import 'package:http/http.dart' as http;
import 'package:login/app/shared/repositories/entities/powerPlantsOnline.dart';
import 'package:login/app/shared/repositories/entities/power_plants_selected.dart';
import 'package:login/app/shared/utils/prefs.dart';

@Injectable()
class PlantsRepository implements IPlantsRepository {
  static Future<Map<String, String>> getHeaders() async {
    Map<String, String> headers = Map();
    return headers;
  }

  @override
  Future getAllLeads() async {
    Map<String, String> headers = await AuthRepository.getHeaders();

    final q = await http.get('https://soleadapp.herokuapp.com/api/posts/get/?size=2000&page=0', headers: headers);

    final data = json.decode(q.body);

    final all = data["content"].map<PowerPlantsOnline>((json) => PowerPlantsOnline.fromJson(json)).toList();

    return all;
  }
  /*
{"id":1080,"geracao":null,"cpf":"","cep":"","bairro":"","numero":"null","area":"64","codigo":"2002080018","inversor":"SGROW, REFUSOL, GROWATT SG8K3","marcaDoModulo":"BYD","numeroDeModulo":"32","peso":"787","potencia":"10.72","potenciaDoModulo":null,"valor":"R$ 43.290,00","potenciaNovo":null,"consumoEmReais":"1200.0","consumoEmKw":"1318.6813186813185","cliente":"João Carlos Clean","endereco":"","data_cadastro":"2020-11-03T13:33:02.521+0000","dados":"Peso kg\t810 52\nTipo de Telhado\tTelhado Colonial\nPotncia kWp\t1072\nQuantidade de Mdulos\t32\nModelo do Inversor\tSG8K3D\nQuantidade de Cabo\t60m Preto  60m Vermelho\nQuantidade de Grampo Final\t16\nQuantidade de Grampo Intermedirio\t56\nMonitoramento Incluso\tSim\nrea Necessria Aproximada m\t64\nPeso Sobre o Telhado Aproximado kg\t767\nPar Conector MC4\t3\nQuantidade de Perfil 4 2m\t16\nQuantidade de Perfil 2 1m\t0\nQuantidade de Juno de Perfil\t8\nQuantidade de Bases de Fixao\t48\nFabricante do Mdulo\tBYD\nPotncia do Mdulo Wp\t335","usuario":{"id":1,"name":"Heitor Klaus","username":"heitorklaus@hotmail.com","company":"Soli Energia Solar","email":"heitorklaus@hotmail.com","foto":null,"avatar":null,"roles":[{"id":1,"name":"ROLE_ADMIN"}]}}

  */

  @override
  Future getLeadSelected(id) async {
    Map<String, String> headers = await AuthRepository.getHeaders();
    headers["Content-Type"] = "application/json";
    final auth = await http.get('https://soleadapp.herokuapp.com/api/posts/get/$id', headers: headers);

    final data = PowerPlantsOnline.fromJson(json.decode(auth.body));
    return data;
  }

  @override
  Future deleteLead(id) async {
    var token = await AuthRepository().getAcessToken();
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final auth = await http.delete('https://soleadapp.herokuapp.com/api/posts/delete/?id=$id', headers: headers);

    final data = auth.body;
    return auth.statusCode;
  }

  @override
  Future updateLead(body) async {
    final x = body;
    var token = await AuthRepository().getAcessToken();
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final encodedResults = jsonEncode(body).replaceAll("\n", "");

    final auth = await http.put('https://soleadapp.herokuapp.com/api/update', headers: headers, body: encodedResults);

    if (auth.statusCode != 200) {
      final user = await Prefs.getString("USER1");
      final pass = await Prefs.getString("PASS1");

      await AuthController().login(user, pass).then((value) => updateLead(x));
    } else if (auth.statusCode == 200) {
      final data = PowerPlantsOnline.fromJson(json.decode(auth.body));

      return data;
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
