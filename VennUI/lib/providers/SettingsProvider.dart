import 'package:VennUI/components/Notification.dart';
import 'package:VennUI/grpc/metric.dart';
import 'package:VennUI/grpc/settings.dart';
import 'package:VennUI/providers/NotificationProvider.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/grpc/v1/ui.pb.dart' as proto;
import 'package:VennUI/utilies.dart';
import 'package:provider/provider.dart';

class SettingsProvider with ChangeNotifier {
  // Sliders
  final int sliderPerPage = 4;

  bool isLoading = true;
  int numPagesSliders = 3;
  int activeIndexSlider = 0;
  int modifiedSlider = 0;

  List<proto.Setting> settings = [];
  List<double> oldSettings = [];

  // Selectors
  final int selectorPerPage = 4;

  int numPagesSelectors = 0;
  int activeIndexSelectors = 0;
  List<proto.Selector> selectors = [];
  List<List<String>> selectorChoicesName = [];

  // Recipes
  int hoverRecipe = -1;
  int selectedRecipe = 0;
  List<proto.Recipe> recipes = [];

  SettingGrpcAPI _settingAPI;
  MetricGrpcAPI _metricAPI;

  SettingsProvider(SettingGrpcAPI r, MetricGrpcAPI s) {
    _settingAPI = r;
    _metricAPI = s;
    initiate();
  }

  void initiate() async {
    // Retrieve the initial settings
    // var currentRecipe = await _settingAPI.readRecipe('default');
    var currentRecipe = await _settingAPI.readCurrentRecipe();

    settings = List.of(currentRecipe.settings);
    oldSettings =
        List.generate(settings.length, (index) => settings[index].value);
    numPagesSliders = (settings.length / sliderPerPage).ceil();

    // Send the initial settings to the backend
    for (var s in settings) {
      _settingAPI
          .updateSetting(proto.SettingUpdate(name: s.name, value: s.value));
    }

    // Retrieve the set of selector
    var s = await _settingAPI.readSelectorList();
    selectors = List.of(s.selectors);
    numPagesSelectors = (selectors.length / selectorPerPage).ceil();
    for (var selector in selectors) {
      List<String> choicesName = [];
      for (var choice in selector.possibleChoices) {
        choicesName.add(choice.name);
      }
      selectorChoicesName.add(choicesName);
    }

    // Retrieve Initial Set of recipe
    var uuids = await _settingAPI.readRecipesUUID();
    for (var uuid in List.of(uuids.uuids)) {
      var r = await _settingAPI.readRecipe(uuid);
      recipes.add(r);
    }
    selectedRecipe = recipes.indexOf(currentRecipe);

    isLoading = false;
    notifyListeners();
  }

  void setSetting(int i, int value) {
    settings[i].value = value.toDouble();
    modifiedSlider = i;
    notifyListeners();
  }

  void setPageSliders(int i) {
    if (i < 0 || i >= numPagesSliders) {
      throw ('Invalid page index');
    }
    activeIndexSlider = i;
    notifyListeners();
  }

  void setPageSelectors(int i) {
    if (i < 0 || i >= numPagesSelectors) {
      throw ('Invalid page index');
    }
    activeIndexSelectors = i;
    notifyListeners();
  }

  void showInfoModal(BuildContext context) {
    var text = "";
    settings.forEach((element) {
      text += "${element.name}: ${element.info}\n\n";
    });
    Future.delayed(const Duration(milliseconds: 250), () {
      showModal(context, 'Settings Information', text);
    });
  }

  void loadRecipe(BuildContext context) async {
    var same = await getCurrentSettings(context);
    if (same) {
      context.read<NotificationProvider>().displayNotification(NotificationData(
          NotificationType.Info,
          "Nothing to load, all the settings are the same."));
    } else {
      context.read<NotificationProvider>().displayNotification(NotificationData(
          NotificationType.Success,
          "The previous settings were successfully loaded."));
    }
    notifyListeners();
  }

  Future<bool> getCurrentSettings(BuildContext context) async {
    var recipe = await _settingAPI.readCurrentRecipe();
    var same = settings == recipe.settings;
    settings = recipe.settings;
    oldSettings =
        List.generate(settings.length, (index) => settings[index].value);
    return same;
  }

  void saveRecipe(BuildContext context) async {
    var modified = false;
    for (int i = 0; i < settings.length; i++) {
      if (settings[i].value != oldSettings[i]) {
        if (settings[i].hasTarget()) {
          updateTarget(settings[i]);
        }
        _settingAPI.updateSetting(proto.SettingUpdate(
            name: settings[i].name, value: settings[i].value));
        oldSettings[i] = settings[i].value;
        modified = true;
      }
    }
    if (modified) {
      context.read<NotificationProvider>().displayNotification(NotificationData(
          NotificationType.Success, "Sucessfully saved the new settings."));
    } else {
      context.read<NotificationProvider>().displayNotification(NotificationData(
          NotificationType.Info,
          "Nothing to save, all the settings are the same."));
    }
    notifyListeners();
  }

  void updateTarget(proto.Setting setting) async {
    proto.MetricConfigs M = await _metricAPI.readConfig();
    for (int i = 0; i < M.configs.length; i++) {
      if (M.configs[i].name == setting.target.name) {
        M.configs[i].target = setting.value;
        await _metricAPI.updateConfig(M);
        return;
      }
    }
  }

  void updateSelectorChoice(int index, String newChoiceName) {
    var newChoice;
    for (var choice in selectors[index].possibleChoices) {
      if (choice.name == newChoiceName) {
        newChoice = choice;
      }
    }
    selectors[index].selectedChoice = newChoice;
  }

  void updateRecipeHover(int i) {
    if (i == hoverRecipe) {
      hoverRecipe = -1;
    } else {
      hoverRecipe = i;
    }
    notifyListeners();
  }

  void createRecipe(BuildContext context) async {
    if (recipes.length >= 99) {
      context.read<NotificationProvider>().displayNotification(NotificationData(
          NotificationType.Error, "Cannot add more than 99 recipes."));
      return;
    }
    proto.Recipe newRecipe = await _settingAPI.createRecipe();
    recipes.add(newRecipe);
    notifyListeners();
  }

  void updateRecipe(BuildContext context, proto.Recipe r) async {
    if (r.title.length > 25) {
      context.read<NotificationProvider>().displayNotification(NotificationData(
          NotificationType.Error,
          r.title + "The new title is too long. (Max 25 char)"));
      return;
    }
    if (r.info.length > 80) {
      context.read<NotificationProvider>().displayNotification(NotificationData(
          NotificationType.Error,
          "The new information text is too long. (Max 80 char)"));
      return;
    }
    await _settingAPI.updateRecipe(r);
    recipes[hoverRecipe] = r;
    context.read<NotificationProvider>().displayNotification(NotificationData(
        NotificationType.Success,
        "Succesfully updated the recipe's information."));
    notifyListeners();
  }

  void deleteRecipe(BuildContext context) async {
    // Cannot delete a recipe if none is selected
    if (hoverRecipe == -1) {
      context.read<NotificationProvider>().displayNotification(NotificationData(
          NotificationType.Error, "Please press any recipe to delete it."));
      return;
    }
    // Cannot remove the first/default recipe
    if (recipes.elementAt(hoverRecipe).uuid == "default") {
      context.read<NotificationProvider>().displayNotification(NotificationData(
          NotificationType.Error, "Cannot remove the default recipe."));
      return;
    }
    _settingAPI.deleteRecipe(recipes.elementAt(hoverRecipe).uuid);
    recipes.removeAt(hoverRecipe);
    hoverRecipe = -1;
    notifyListeners();
  }

  void selectRecipe(BuildContext context) async {
    // Cannot select a recipe if none is selected
    if (hoverRecipe == -1) {
      context.read<NotificationProvider>().displayNotification(NotificationData(
          NotificationType.Error, "Please press any recipe to select it."));
      return;
    }
    // Send the new recipe
    await _settingAPI.updateCurrentRecipe(recipes.elementAt(hoverRecipe).uuid);
    selectedRecipe = hoverRecipe;
    // Load the new recipe settings
    await getCurrentSettings(context);
    context.read<NotificationProvider>().displayNotification(NotificationData(
        NotificationType.Success, "Sucessfully selected the recipe."));
    notifyListeners();
  }
}
