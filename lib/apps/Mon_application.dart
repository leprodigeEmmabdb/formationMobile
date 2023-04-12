import 'package:flutter/material.dart';
import 'package:gestion_fidele/controllers/FideleCtrl.dart';
import 'package:gestion_fidele/pages/BrouillonsPage.dart';
import 'package:gestion_fidele/pages/Demo.dart';
import 'package:gestion_fidele/pages/DemoC.dart';
import 'package:gestion_fidele/pages/FidelePage.dart';
import 'package:gestion_fidele/pages/FormPage.dart';
import 'package:gestion_fidele/pages/listeFidele.dart';
import 'package:gestion_fidele/pages/LogiPage.dart';
import 'package:gestion_fidele/pages/splashscreen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../controllers/EventCtrl.dart';
import '../controllers/UserCtrl.dart';
import '../pages/loginPage2.dart';
import '../utils/Stockage.dart';

class MonApplication extends StatelessWidget {
  var box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var user = box.read<Map>(Stockage.userKey);
    print(user);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FideleCtrl(stockage: box)),
        ChangeNotifierProvider(create: (_) => UserCtrl(stockage: box)),
        ChangeNotifierProvider(create: (_) => EventCtrl()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: user != null ? FidelePage() : LoginPage(),
      ),
    );
  }
}

