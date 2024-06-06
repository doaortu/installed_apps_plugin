//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <installed_apps_plugin/installed_apps_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) installed_apps_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "InstalledAppsPlugin");
  installed_apps_plugin_register_with_registrar(installed_apps_plugin_registrar);
}
