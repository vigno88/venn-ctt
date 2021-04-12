import 'package:VennUI/api/metric_service.dart';
import 'package:VennUI/api/v1/ui.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/api/setting_service.dart';
import 'package:VennUI/api/v1/ui.pb.dart' as proto;
import 'package:VennUI/utilies.dart';

class SettingsProvider with ChangeNotifier {
  // Sliders
  final int sliderPerPage = 5;

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

  SettingService settingService;
  MetricService metricService;

  SettingsProvider(SettingService r, MetricService s) {
    settingService = r;
    metricService = s;
    initiate();
  }

  void initiate() async {
    // Retrieve the initial settings
    var defaultRecipe = await settingService.readRecipe('default');
    settings = List.of(defaultRecipe.settings);
    oldSettings =
        List.generate(settings.length, (index) => settings[index].value);
    numPagesSliders = (settings.length / sliderPerPage).ceil();

    // Retrieve the set of selector
    var s = await settingService.readSelectorList();
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
    var uuids = await settingService.readRecipesUUID();
    for (var uuid in List.of(uuids.uuids)) {
      var r = await settingService.readRecipe(uuid);
      recipes.add(r);
    }

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
      text += "${element.name}: ${element.info}\n";
    });
    Future.delayed(const Duration(milliseconds: 250), () {
      showModal(context, 'Settings Information', text);
    });
  }

  void loadRecipe() async {
    var recipe = await settingService.readRecipe('default');
    settings = recipe.settings;
    oldSettings =
        List.generate(settings.length, (index) => settings[index].value);
    notifyListeners();
  }

  void saveRecipe() async {
    for (int i = 0; i < settings.length; i++) {
      if (settings[i].value != oldSettings[i]) {
        if (settings[i].hasTarget()) {
          updateTarget(settings[i]);
        }
        settingService.updateSetting(proto.SettingUpdate(
            name: settings[i].name, value: settings[i].value));
        oldSettings[i] = settings[i].value;
      }
    }
  }

  void updateTarget(proto.Setting setting) async {
    proto.MetricConfigs M = await metricService.readConfig();
    for (int i = 0; i < M.configs.length; i++) {
      if (M.configs[i].name == setting.target.name) {
        M.configs[i].target = setting.value;
        metricService.updateConfig(M);
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
    }
    hoverRecipe = i;
    notifyListeners();
  }
}
