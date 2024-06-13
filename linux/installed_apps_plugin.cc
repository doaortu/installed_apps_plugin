#include "include/installed_apps_plugin/installed_apps_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>
#include <string>
#include <vector>

#include "installed_apps_plugin_private.h"

#define INSTALLED_APPS_PLUGIN(obj)                                             \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), installed_apps_plugin_get_type(),         \
                              InstalledAppsPlugin))

struct _InstalledAppsPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(InstalledAppsPlugin, installed_apps_plugin, g_object_get_type())
struct AppInfo {
  std::string name;
  std::string *description;
  std::string *icon_path;
  std::string id;
};

std::vector<AppInfo> get_installed_apps() {
  std::vector<AppInfo> apps;

  // Get all installed applications
  GList *apps_list = g_app_info_get_all();
  GtkIconTheme *icon_theme = gtk_icon_theme_get_default();

  // Iterate through the application list
  for (GList *l = apps_list; l != NULL; l = l->next) {
    GAppInfo *app_info = G_APP_INFO(l->data);

    // Check if the app should be shown and is launchable
    if (!g_app_info_should_show(app_info)) {
      continue;
    }

    const char *display_name = g_app_info_get_display_name(app_info);
    if (!display_name) {
      continue;
    }

    AppInfo app;
    app.name = display_name;
    app.id = g_app_info_get_id(app_info);
    const char *desc = g_app_info_get_description(app_info);
    if(!desc) {
      app.description = nullptr;
    } else {
      app.description = new std::string(desc);
    }
    

    // Try to get the application icon
    GIcon *icon = g_app_info_get_icon(app_info);
    if (icon) {
      // Convert icon to string and lookup using icon theme
      char *icon_str = g_icon_to_string(icon);
      GtkIconInfo *icon_info = gtk_icon_theme_lookup_icon(
          icon_theme, icon_str, 48, GTK_ICON_LOOKUP_USE_BUILTIN);

      if (icon_info) {
        const char *icon_path = gtk_icon_info_get_filename(icon_info);
        if (icon_path) {
          app.icon_path = new std::string(icon_path);
        }
        g_object_unref(icon_info);
      }

      g_free(icon_str);
    }

    apps.push_back(app);
  }

  // Free memory
  g_list_free_full(apps_list, g_object_unref);

  return apps;
}

// Called when a method call is received from Flutter.
static void
installed_apps_plugin_handle_method_call(InstalledAppsPlugin *self,
                                         FlMethodCall *method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar *method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getInstalledApps") == 0) {
    std::vector<AppInfo> apps = get_installed_apps();
    FlValue *result = fl_value_new_list();

    for (const AppInfo &app : apps) {
      FlValue *app_info = fl_value_new_map();
      fl_value_set_string_take(app_info, "name",
                               fl_value_new_string(app.name.c_str()));
      fl_value_set_string_take(app_info, "id",
                               fl_value_new_string(app.id.c_str()));
      if (app.description)
        fl_value_set_string_take(app_info, "description",
                               fl_value_new_string(app.description->c_str()));
      else 
        fl_value_set(app_info, fl_value_new_string("description"),
                     fl_value_new_null());
      if (app.icon_path)
        fl_value_set_string_take(app_info, "iconPath",
                                 fl_value_new_string(app.icon_path->c_str()));
      else
        fl_value_set(app_info, fl_value_new_string("iconPath"),
                     fl_value_new_null());
      fl_value_append_take(result, app_info);
    }

    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  } 
  else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void installed_apps_plugin_dispose(GObject *object) {
  G_OBJECT_CLASS(installed_apps_plugin_parent_class)->dispose(object);
}

static void installed_apps_plugin_class_init(InstalledAppsPluginClass *klass) {
  G_OBJECT_CLASS(klass)->dispose = installed_apps_plugin_dispose;
}

static void installed_apps_plugin_init(InstalledAppsPlugin *self) {}

static void method_call_cb(FlMethodChannel *channel, FlMethodCall *method_call,
                           gpointer user_data) {
  InstalledAppsPlugin *plugin = INSTALLED_APPS_PLUGIN(user_data);
  installed_apps_plugin_handle_method_call(plugin, method_call);
}

void installed_apps_plugin_register_with_registrar(
    FlPluginRegistrar *registrar) {
  InstalledAppsPlugin *plugin = INSTALLED_APPS_PLUGIN(
      g_object_new(installed_apps_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "installed_apps_plugin", FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(
      channel, method_call_cb, g_object_ref(plugin), g_object_unref);

  g_object_unref(plugin);
}
