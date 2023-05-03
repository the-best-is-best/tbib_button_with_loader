#include "include/tbib_button_with_loader/tbib_button_with_loader_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "tbib_button_with_loader_plugin.h"

void TbibButtonWithLoaderPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  tbib_button_with_loader::TbibButtonWithLoaderPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
