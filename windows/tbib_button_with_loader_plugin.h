#ifndef FLUTTER_PLUGIN_TBIB_BUTTON_WITH_LOADER_PLUGIN_H_
#define FLUTTER_PLUGIN_TBIB_BUTTON_WITH_LOADER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace tbib_button_with_loader {

class TbibButtonWithLoaderPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  TbibButtonWithLoaderPlugin();

  virtual ~TbibButtonWithLoaderPlugin();

  // Disallow copy and assign.
  TbibButtonWithLoaderPlugin(const TbibButtonWithLoaderPlugin&) = delete;
  TbibButtonWithLoaderPlugin& operator=(const TbibButtonWithLoaderPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace tbib_button_with_loader

#endif  // FLUTTER_PLUGIN_TBIB_BUTTON_WITH_LOADER_PLUGIN_H_
