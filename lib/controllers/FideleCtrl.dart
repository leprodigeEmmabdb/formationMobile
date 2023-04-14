import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gestion_fidele/utils/Constance.dart';
import 'package:gestion_fidele/utils/Stockage.dart';
import 'package:gestion_fidele/utils/requetes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/FidelModele.dart';
import '../utils/Constance.dart';

class FideleCtrl with ChangeNotifier {
  List<FidelModele> fideles = [];
  bool loading = false;
  GetStorage? stockage;
  FideleCtrl({this.stockage});


  Future<bool> envoieDonneesAuth(Map data) async {
    var url = Uri.parse("${Constance.BASE_URL}${Constance.authEndpoint}");
    var dataStr = json.encode(data);
    var reponse = await http.post(url, body: dataStr);
    print("status : ${reponse.statusCode}");
    if (reponse.statusCode == 200) {
      Map bodymap = json.decode(reponse.body);
      print(bodymap['id']);
      return true;
    }
    return false;
  }


  void recupererDataAPI() async {
    var url = "${Constance.BASE_URL}${Constance.fidelesEndpoint}";
    loading = true;
    notifyListeners();
    var reponse = await getData(url);
    if (reponse != null) {
      List<FidelModele> tmp = reponse
          .map<FidelModele>((data) => FidelModele.fromJson(data))
          .toList();
      fideles = tmp;
      stockage?.write(Stockage.fidelesKey, reponse);
      notifyListeners();
    }
    else{
      var dataStockee=stockage?.read(Stockage.fidelesKey) ;
      var tmp=dataStockee.map<FidelModele>((e)=> FidelModele.fromJson(e)).toList();
      fideles = tmp;
      print("Mes donnees : $tmp");
    }
    loading=false;
    notifyListeners();
  }
}

void main() {
  var f = FideleCtrl();
  f.recupererDataAPI();
}

/*
class User {
   String? name;
   int? age;

  User({ this.name, this.age});
}

void main() {
  var mapList = [{'name': 'John', 'age': 30}, {'name': 'Jane', 'age': 40}];
  var userList = mapList.map((item) => User(name: item['name'] as String,age: item['age'] as int)).toList();
  userList.forEach((user) {
    print("Nom : ${user.name}, Age: ${user.age}");
  });



  var data = jsonEncode(userList);
  print(data);
  print("="*20);
  print(userList.length);
  print(userList); // [Instance of 'User', Instance of 'User']
}*/
