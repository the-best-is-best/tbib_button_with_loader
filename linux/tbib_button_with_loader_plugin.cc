#include "include/tbib_button_with_loader/tbib_button_with_loader_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#define TBIB_BUTTON_WITH_LOADER_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), tbib_button_with_loader_plugin_get_type(), \
                              TbibButtonWithLoaderPlugin))

struct _TbibButtonWithLoaderPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(TbibButtonWithLoaderPlugin, tbib_button_with_loader_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void tbib_button_with_loader_plugin_handle_method_call(
    TbibButtonWithLoaderPlugin* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getPlatformVersion") == 0) {
    struct utsname uname_data = {};
    uname(&uname_data);
    g_autofree gchar *version = g_strdup_printf("Linux %s", uname_data.version);
    g_autoptr(FlValue) result = fl_value_new_string(version);
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void tbib_button_with_loader_plugin_dispose(GObject* object) {
  G_OBJECT_CLASS(tbib_button_with_loader_plugin_parent_class)->dispose(object);
}

static void tbib_button_with_loader_plugin_class_init(TbibButtonWithLoaderPluginClass* klass) {
  G_OBJECT_CLASS(klass)->dispose = tbib_button_with_loader_plugin_dispose;
}

static void tbib_button_with_loader_plugin_init(TbibButtonWithLoaderPlugin* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  TbibButtonWithLoaderPlugin* plugin = TBIB_BUTTON_WITH_LOADER_PLUGIN(user_data);
  tbib_button_with_loader_plugin_handle_method_call(plugin, method_call);
}

void tbib_button_with_loader_plugin_register_with_registrar(FlPluginRegistrar* registrar) {
  TbibButtonWithLoaderPlugin* plugin = TBIB_BUTTON_WITH_LOADER_PLUGIN(
      g_object_new(tbib_button_with_loader_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "tbib_button_with_loader",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}
