// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart' as cup;
//import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:flutter/material.dart';

class ButtonLoaderData {
  /// style button in material app
  final ButtonStyle materialButtonStyle;

  /// style button in fluent ui app need use fluent ui package
  final fluent.ButtonStyle fluentButtonStyle;

  /// style button in macos ui app need macos ui package
  //final MacosButtonStyle macosButtonStyle;

  /// style button in cupertino app
  final CupertinoButtonStyle cupertinoButtonStyle;

  /// Add key for button for test
  final Key? buttonKey;

  /// Add border radius for button and the same for loader
  final double borderRadius;

  /// button height for idle state
  final double? buttonHeight;

  /// button width for idle state
  final double? buttonWidth;

  /// not available in cupertino
  final bool autofocus;

  /// not available in cupertino
  final FocusNode? focusNode;

  /// for use fluent ui button from fluent ui package
  final bool useFluentUi;

  /// for use macos ui button from macos ui package
  final bool useMacUi;

  /// Custom Button Loader and can custom success or error widget
  final ButtonLoader buttonLoader;

  const ButtonLoaderData({
    this.materialButtonStyle = const ButtonStyle(),
    this.fluentButtonStyle = const fluent.ButtonStyle(),
    //  this.macosButtonStyle = const MacosButtonStyle(),
    this.cupertinoButtonStyle = const CupertinoButtonStyle(),
    this.buttonKey,
    this.borderRadius = 15,
    this.autofocus = false,
    this.focusNode,
    this.useFluentUi = false,
    this.useMacUi = false,
    this.buttonLoader = const ButtonLoader(),
    this.buttonHeight,
    this.buttonWidth,
  });
}

class CupertinoButtonStyle {
  final cup.AlignmentGeometry alignment;
  final cup.BorderRadius borderRadius;
  final cup.Color disabledColor;
  final double pressedOpacity;
  final double? minSize;
  const CupertinoButtonStyle({
    this.alignment = Alignment.center,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.disabledColor = cup.CupertinoColors.quaternarySystemFill,
    this.pressedOpacity = 0.4,
    this.minSize,
  });
}

// class MacosButtonStyle extends CupertinoButtonStyle {
//   final macos.ButtonSize buttonSize;
//   final Color? color;
//   final bool isSecondary;
//   final MouseCursor mouseCursor;
//   final EdgeInsetsGeometry? padding;
//   final String? semanticLabel;

//   const MacosButtonStyle(
//       {this.buttonSize = macos.ButtonSize.large,
//       super.alignment,
//       this.color,
//       super.pressedOpacity,
//       super.borderRadius,
//       super.disabledColor,
//       this.isSecondary = false,
//       this.mouseCursor = SystemMouseCursors.basic,
//       this.padding,
//       this.semanticLabel});
// }

class ButtonLoader {
  final IconData? successIcon;
  final Color? successIconColor;
  final IconData? errorIcon;
  final Color? errorIconColor;

  /// use custom loader
  final Widget? loader;
  final CircularProgressIndicator androidLoader;
  final cup.CupertinoActivityIndicator iosLoader;
  final fluent.ProgressRing fluentUILoader;
  final Duration animatedDuration;

  /// Background color container loader
  final Color backgroundLoaderColor;

  final double? loaderContainerHeight;
  final double? loaderContainerWidth;

  final Widget? customWidgetInSuccess;
  final Widget? customWidgetInError;
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
    this.customWidgetInSuccess,
    this.customWidgetInError,
  });
}
