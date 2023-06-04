library button_with_loading;

import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
//import 'package:macos_ui/macos_ui.dart' as macos;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as mat;
import 'package:tbib_button_with_loader/styles/button_style.dart';

export 'package:tbib_button_with_loader/styles/button_style.dart';

typedef IsSuccess = void Function(bool isSuccess);

class ButtonWithLoader extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;

  /// Use To Add style and loader
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
              ? ClipRRect(
                  borderRadius:
                      BorderRadius.circular(widget.buttonData.borderRadius),
                  child: FilledButton(
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
                      )),
                )
              :
              // widget.buttonData.useMacUi && Platform.isMacOS
              //     ? ClipRRect(
              //         borderRadius:
              //             BorderRadius.circular(widget.buttonData.borderRadius),
              //         child: macos.PushButton(
              //             key: widget.buttonData.buttonKey,
              //             buttonSize:
              //                 widget.buttonData.macosButtonStyle.buttonSize,
              //             alignment:
              //                 widget.buttonData.macosButtonStyle.alignment,
              //             borderRadius: BorderRadius.circular(
              //                 widget.buttonData.borderRadius),
              //             color: widget.buttonData.macosButtonStyle.color,
              //             disabledColor:
              //                 widget.buttonData.macosButtonStyle.disabledColor,
              //             isSecondary:
              //                 widget.buttonData.macosButtonStyle.isSecondary,
              //             mouseCursor:
              //                 widget.buttonData.macosButtonStyle.mouseCursor,
              //             padding: widget.buttonData.macosButtonStyle.padding,
              //             pressedOpacity:
              //                 widget.buttonData.macosButtonStyle.pressedOpacity,
              //             semanticLabel:
              //                 widget.buttonData.macosButtonStyle.semanticLabel,
              //             onPressed: () {
              //               widget.onPressed?.call(
              //                   startLoading, stopLoading, isSuccess, state);
              //             },
              //             child: Padding(
              //               padding: const EdgeInsets.all(4.0),
              //               child: Center(
              //                 child: FittedBox(
              //                   child: Text(
              //                     widget.title,
              //                     style: widget.titleStyle,
              //                   ),
              //                 ),
              //               ),
              //             )),
              //       )
              //     :
              Platform.isAndroid
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.circular(widget.buttonData.borderRadius),
                      child: mat.FilledButton(
                        key: widget.buttonData.buttonKey,
                        autofocus: widget.buttonData.autofocus,
                        focusNode: widget.buttonData.focusNode,
                        onPressed: () => widget.onPressed
                            ?.call(startLoading, stopLoading, isSuccess, state),
                        onLongPress: () => widget.onLongPressed
                            ?.call(startLoading, stopLoading, isSuccess, state),
                        style: widget.buttonData.materialButtonStyle,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            widget.title,
                            style: widget.titleStyle,
                          ),
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius:
                          BorderRadius.circular(widget.buttonData.borderRadius),
                      child: CupertinoButton.filled(
                        key: widget.buttonData.buttonKey,
                        onPressed: () async {
                          widget.onPressed?.call(
                              startLoading, stopLoading, isSuccess, state);
                        },
                        minSize: widget.buttonData.cupertinoButtonStyle.minSize,

                        // style
                        alignment:
                            widget.buttonData.cupertinoButtonStyle.alignment,
                        borderRadius:
                            widget.buttonData.cupertinoButtonStyle.borderRadius,
                        disabledColor: widget
                            .buttonData.cupertinoButtonStyle.disabledColor,
                        pressedOpacity: widget
                            .buttonData.cupertinoButtonStyle.pressedOpacity,

                        padding: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            widget.title,
                            style: widget.titleStyle,
                          ),
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
              ? widget.buttonData.buttonLoader.customWidgetInSuccess != null &&
                      isSuccess
                  ? widget.buttonData.buttonLoader.customWidgetInSuccess
                  : widget.buttonData.buttonLoader.customWidgetInError !=
                              null &&
                          !isSuccess
                      ? widget.buttonData.buttonLoader.customWidgetInError
                      : Icon(
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

  /// bool isSuccess == false it meaning error
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
