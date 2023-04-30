import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart' hide Colors, OutlinedButton;
import 'package:flutter/material.dart';
import 'package:tbib_button_with_loader/tbib_button_with_loader.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Function? startLoading;
  Function? stopLoading;
  Function(bool isSuccess)? isSuccess;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FluentTheme(
                data: FluentThemeData(),
                child: ButtonWithLoader(
                  onPressed: (startLoading, stopLoading,
                      Function(bool isSuccess) isSuccess, state) {
                    this.startLoading = startLoading;
                    this.stopLoading = stopLoading;
                    this.isSuccess = isSuccess;
                    this.startLoading?.call();
                    Future.delayed(const Duration(seconds: 2), () {
                      this.stopLoading?.call();
                    });
                  },
                  buttonData: const ButtonLoaderData(
                      useFluentUi: true, borderRadius: 10),
                  title: 'Click Me',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ButtonWithLoader(
                onPressed: (startLoading, stopLoading,
                    Function(bool isSuccess) isSuccess, state) {
                  this.startLoading = startLoading;
                  this.stopLoading = stopLoading;
                  this.isSuccess = isSuccess;
                  this.startLoading?.call();

                  Future.delayed(const Duration(seconds: 2), () {
                    this.isSuccess?.call(true);
                  });
                },
                title: 'success',
                buttonData: const ButtonLoaderData(borderRadius: 30),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ButtonWithLoader(
                onPressed: (startLoading, stopLoading,
                    Function(bool isSuccess) isSuccess, state) {
                  this.startLoading = startLoading;
                  this.stopLoading = stopLoading;
                  this.isSuccess = isSuccess;
                  this.startLoading?.call();
                  Future.delayed(const Duration(seconds: 2), () {
                    this.isSuccess?.call(false);
                  });
                },
                title: 'error',
                buttonData: const ButtonLoaderData(
                    buttonLoader: ButtonLoader(
                        customWidgetInError: Icon(Icons.running_with_errors))),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
