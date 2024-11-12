import 'package:flutter/material.dart';

import 'core/app.dart';
import 'core/dio_manager/dio_client.dart';
import 'core/service_locator/service_locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  runApp(const MyApp());
}