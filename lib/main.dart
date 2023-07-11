import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signal/src/app.dart';
import 'package:signal/src/config/injection.dart';
import 'package:signal/src/extensions/extensions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerErrorHandlers();
  await Injection.init();

  runApp(const SignalApp());
}


void registerErrorHandlers() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
