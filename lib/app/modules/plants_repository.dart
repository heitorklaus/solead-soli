import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/native_imp.dart';
import 'package:login/app/modules/plants/plants_interface.dart';
import 'package:login/app/shared/auth/entities/auth.dart';
import 'package:login/app/shared/repositories/entities/plants_list.dart';
import 'package:http/http.dart' as http;

@Injectable()
class PlantsRepository implements IPlantsRepository {
  static Future<Map<String, String>> getHeaders() async {
    Map<String, String> headers = Map();
    return headers;
  }

  @override
  Future fetchPost() async {
    Map<String, String> headers = await getHeaders();

    headers["Content-Type"] = "application/json";
    final auth = await http.get('https://jsonplaceholder.typicode.com/posts/', headers: headers);

    Iterable list = json.decode(auth.body);
    final users = list.map((model) => PlantsList.fromJson(model)).toList();

    return users;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
