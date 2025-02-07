import 'package:flutter/material.dart';
import 'package:open_nest/app/app.dart';
import 'package:open_nest/app/di/di.dart';
import 'package:open_nest/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive Database
  await HiveService.init();

  // Delete all the hive data and boxes
  // await HiveService().clearAll();
  // Initialize Dependencies
  await initDependencies();

  runApp(
    
    App(),
  );
}
