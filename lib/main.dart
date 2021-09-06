import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'form.dart';
import 'model/form_model.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    print(directory.path);
    Hive.registerAdapter(FormModelAdapter());
    runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Material App',
      home: Mainform(),
       );
  }
}