import 'dart:convert';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login/app/modules/plants/plants_interface.dart';
import 'package:login/app/shared/auth/repositories/auth_repository.dart';
import 'package:login/app/shared/repositories/entities/plants_list.dart';
import 'package:http/http.dart' as http;
import 'package:login/app/shared/repositories/entities/powerPlantsOnline.dart';

@Injectable()
class PlantsRepository implements IPlantsRepository {
  static Future<Map<String, String>> getHeaders() async {
    Map<String, String> headers = Map();
    return headers;
  }

  @override
  Future fetchPost() async {
    Map<String, String> headers = await AuthRepository.getHeaders();
    
    final q = await http.get('https://soleadapp.herokuapp.com/api/posts/get/?size=2000&page=0', headers: headers);

    final data = json.decode(q.body);

    final all = data["content"].map<PowerPlantsOnline>((json) => PowerPlantsOnline.fromJson(json)).toList();

    return all;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
