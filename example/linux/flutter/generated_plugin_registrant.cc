//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <tbib_button_with_loader/tbib_button_with_loader_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) tbib_button_with_loader_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "TbibButtonWithLoaderPlugin");
  tbib_button_with_loader_plugin_register_with_registrar(tbib_button_with_loader_registrar);
}
