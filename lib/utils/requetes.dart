import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/FidelModele.dart';

Future<dynamic> getData(String url_api) async {
  try{
    var url= Uri.parse(url_api);
    var reponse= await http.get(url).timeout(Duration(seconds:5));
    //List<Map> data= jsonDecode(reponse.body); // contient le resultat de la response
    // print(data);
    //
    // data.map((item) => item as FidelModele );
    // print(reponse.body.runtimeType); // contient le type de resultat de la response
    // print(reponse.statusCode); // contient le code http
    if(reponse.statusCode==200){
      return json.decode(reponse.body);
    }
    return null;
  }catch(e, trace){
    print(e.toString());
    print(trace.toString());
    return null;
  }
}
  Future<dynamic> postData(String url_api, Map data) async {
   try{
     var url=Uri.parse(url_api);
     String dataStr=json.encode(data);
     var reponse=await http.post(url,body: dataStr);
     var successList= [200,201];
     if(successList.contains(reponse.statusCode)){
       return json.decode(reponse.body);
     }
     return null;
   }catch(e, trace){
     print(e.toString());
     print(trace.toString());
     return null;
   }
  }
