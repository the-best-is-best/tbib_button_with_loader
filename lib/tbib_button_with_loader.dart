library button_with_loading;

export 'package:tbib_button_with_loader/styles/button_style.dart';

import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as mat;
import 'package:tbib_button_with_loader/styles/button_style.dart';

typedef IsSuccess = void Function(bool isSuccess);

class ButtonWithLoader extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final ButtonLoaderData buttonData;

  /// receive startLoading , stopLoading, isSuccess m btnState
  final void Function(Function startLoading, Function stopLoading,
      IsSuccess isSuccess, ButtonSpinnerState btnState)? onPressed;

  final void Function(Function startLoading, Function stopLoading,
      IsSuccess isSuccess, ButtonSpinnerState btnState)? onLongPressed;
  const ButtonWithLoader({
    super.key,
    required this.title,
    required this.onPressed,
    this.onLongPressed,
    this.titleStyle,
    this.buttonData = const ButtonLoaderData(),
  });

  @override
  State<ButtonWithLoader> createState() => _ButtonWithLoaderState();
}

enum ButtonSpinnerState { init, loading, success }

class _ButtonWithLoaderState extends State<ButtonWithLoader> {
  late ButtonSpinnerState state = ButtonSpinnerState.init;
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: state != ButtonSpinnerState.init
          ? widget.buttonData.buttonWidth ?? 60
          : widget.buttonData.buttonLoader.loaderContainerWidth ?? 160,
      height: state != ButtonSpinnerState.init
          ? widget.buttonData.buttonHeight ?? 50
          : widget.buttonData.buttonLoader.loaderContainerHeight ?? 50,
      duration: widget.buttonData.buttonLoader.animatedDuration,
      child: state == ButtonSpinnerState.init
          ? (widget.buttonData.useFluentUi
              ? FilledButton(
                  key: widget.buttonData.buttonKey,
                  autofocus: widget.buttonData.autofocus,
                  focusNode: widget.buttonData.focusNode,
                  style: widget.buttonData.fluentButtonStyle,
                  onPressed: () {
                    widget.onPressed
                        ?.call(startLoading, stopLoading, isSuccess, state);
                  },
                  onLongPress: () => widget.onLongPressed
                      ?.call(startLoading, stopLoading, isSuccess, state),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          widget.title,
                          style: widget.titleStyle,
                        ),
                      ),
                    ),
                  ))
              : Platform.isAndroid
                  ? mat.FilledButton(
                      key: widget.buttonData.buttonKey,
                      autofocus: widget.buttonData.autofocus,
                      focusNode: widget.buttonData.focusNode,
                      onPressed: () => widget.onPressed
                          ?.call(startLoading, stopLoading, isSuccess, state),
                      onLongPress: () => widget.onLongPressed
                          ?.call(startLoading, stopLoading, isSuccess, state),
                      style: widget.buttonData.flutterButtonStyle,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.title,
                          style: widget.titleStyle,
                        ),
                      ),
                    )
                  : CupertinoButton.filled(
                      key: widget.buttonData.buttonKey,
                      onPressed: () async {
                        widget.onPressed
                            ?.call(startLoading, stopLoading, isSuccess, state);
                      },
                      minSize: widget.buttonData.curpertinoButtonStyle?.minSize,

                      // style
                      alignment:
                          widget.buttonData.curpertinoButtonStyle?.alignment ??
                              Alignment.center,
                      borderRadius:
                          widget.buttonData.curpertinoButtonStyle?.borderRadius,
                      disabledColor: widget.buttonData.curpertinoButtonStyle
                              ?.disabledColor ??
                          CupertinoColors.quaternarySystemFill,
                      pressedOpacity: widget.buttonData.curpertinoButtonStyle
                              ?.pressedOpacity ??
                          0.4,

                      padding: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.title,
                          style: widget.titleStyle,
                        ),
                      ),
                    ))
          : _buildSpanner(isDone, state == ButtonSpinnerState.success),
    );
  }

  Widget _buildSpanner(bool isDone, bool isSuccess) {
    return Container(
        height: widget.buttonData.buttonLoader.loaderContainerHeight,
        width: widget.buttonData.buttonLoader.loaderContainerWidth,
        decoration: BoxDecoration(
          color: widget.buttonData.buttonLoader.backgroundLoaderColor,
          borderRadius: BorderRadius.circular(widget.buttonData.borderRadius),
        ),
        // decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Center(
          child: isDone
              ? Icon(
                  isDone && isSuccess
                      ? widget.buttonData.buttonLoader.successIcon ??
                          FluentIcons.check_mark
                      : widget.buttonData.buttonLoader.errorIcon ??
                          FluentIcons.error,
                  color: isSuccess
                      ? widget.buttonData.buttonLoader.successIconColor
                      : widget.buttonData.buttonLoader.errorIconColor,
                  size: 30,
                )
              : widget.buttonData.buttonLoader.loader ??
                  (widget.buttonData.useFluentUi
                      ? widget.buttonData.buttonLoader.fluentUILoader
                      : Platform.isAndroid
                          ? widget.buttonData.buttonLoader.androidLoader
                          : widget.buttonData.buttonLoader.iosLoader),
        ));
  }

  void startLoading() {
    state = ButtonSpinnerState.loading;
    setState(() {});
    // await Future.delayed(const Duration(seconds: 1));
  }

  void stopLoading() {
    // await Future.delayed(const Duration(seconds: 1));
    state = ButtonSpinnerState.init;
    isDone = false;
    setState(() {});
  }

  void isSuccess(bool isSuccess) async {
    isDone = true;
    if (isSuccess) {
      state = ButtonSpinnerState.success;
    }
    setState(() {});
    Future.delayed(widget.buttonData.buttonLoader.animatedDuration, () {
      stopLoading();
      setState(() {});
    });
  }
}
