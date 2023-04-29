// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart' as cup;
import 'package:flutter/material.dart';

class ButtonLoaderData {
  final ButtonStyle flutterButtonStyle;
  final fluent.ButtonStyle fluentButtonStyle;
  final CurpertinoButtonStyle? curpertinoButtonStyle;
  final Key? buttonKey;
  final double borderRadius;
  final double? buttonHeight;
  final double? buttonWidth;

  /// not available in cupertino
  final bool autofocus;

  /// not available in cupertino

  final FocusNode? focusNode;
  final bool useFluentUi;
  final ButtonLoader buttonLoader;

  const ButtonLoaderData({
    this.flutterButtonStyle = const ButtonStyle(),
    this.fluentButtonStyle = const fluent.ButtonStyle(),
    this.curpertinoButtonStyle,
    this.buttonKey,
    this.borderRadius = 15,
    this.autofocus = false,
    this.focusNode,
    this.useFluentUi = false,
    this.buttonLoader = const ButtonLoader(),
    this.buttonHeight,
    this.buttonWidth,
  });
}

class CurpertinoButtonStyle {
  final cup.AlignmentGeometry alignment;
  final cup.BorderRadius borderRadius;
  final cup.Color? disabledColor;
  final double? pressedOpacity;
  final double? minSize;
  const CurpertinoButtonStyle({
    this.alignment = Alignment.center,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.disabledColor,
    this.pressedOpacity,
    this.minSize,
  });
}

class ButtonLoader {
  final IconData? successIcon;
  final Color? successIconColor;
  final IconData? errorIcon;
  final Color? errorIconColor;
  final Widget? loader;
  final CircularProgressIndicator androidLoader;
  final cup.CupertinoActivityIndicator iosLoader;
  final fluent.ProgressRing fluentUILoader;
  final Duration animatedDuration;
  final Color backgroundLoaderColor;
  final double? loaderContainerHeight;
  final double? loaderContainerWidth;
  const ButtonLoader({
    this.successIcon,
    this.successIconColor = Colors.green,
    this.errorIcon,
    this.errorIconColor = Colors.red,
    this.loader,
    this.androidLoader = const CircularProgressIndicator(color: Colors.white),
    this.iosLoader = const cup.CupertinoActivityIndicator(color: Colors.white),
    this.fluentUILoader = const fluent.ProgressRing(activeColor: Colors.white),
    this.animatedDuration = const Duration(milliseconds: 500),
    this.backgroundLoaderColor = const Color.fromRGBO(4, 99, 180, 1),
    this.loaderContainerHeight,
    this.loaderContainerWidth,
  });
}
