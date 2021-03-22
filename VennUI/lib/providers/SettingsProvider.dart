import 'package:VennUI/api/configuration_service.dart';
import 'package:flutter/material.dart';
import 'package:VennUI/api/recipe_service.dart';
import 'package:VennUI/api/v1/ui.pb.dart' as proto;
import 'package:VennUI/utilies.dart';

class SettingsProvider with ChangeNotifier {
  final int sliderPerPage = 4;

  bool isLoading = true;
  int numPages = 1;
  int activeIndex = 0;
  int modifiedSlider = 0;

  List<proto.Setting> settings = List<proto.Setting>();
  List<double> oldSettings = List<double>();
  RecipeService recipeService;
  ConfigurationService configurationService;

  SettingsProvider(RecipeService r, ConfigurationService c) {
    recipeService = r;
    configurationService = c;
    initiate();
  }

  void initiate() async {
    var defaultRecipe = await recipeService.getRecipe('default');
    settings = List.of(defaultRecipe.settings);
    oldSettings =
        List.generate(settings.length, (index) => settings[index].value);
    isLoading = false;
    numPages = (settings.length / sliderPerPage).ceil();
    notifyListeners();
  }

  void setSetting(int i, int value) {
    settings[i].value = value.toDouble();
    modifiedSlider = i;
    notifyListeners();
  }

  void setActivePageIndex(int i) {
    if (i < 0 || i > numPages) {
      throw ('Invalid page index');
    }
    activeIndex = i;
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
    var recipe = await recipeService.getRecipe('default');
    settings = recipe.settings;
    oldSettings =
        List.generate(settings.length, (index) => settings[index].value);
    notifyListeners();
  }

  void saveRecipe() async {
    for (int i = 0; i < settings.length; i++) {
      if (settings[i].value != oldSettings[i]) {
        if (settings[i].hasGoalName()) {
          updateGoal(settings[i]);
        }
        recipeService.setSetting(settings[i]);
        oldSettings[i] = settings[i].value;
      }
    }
  }

  void updateGoal(proto.Setting setting) async {
    proto.Configuration config = await configurationService.getConfiguration();
    for (int i = 0; i < config.metricsConfig.length; i++) {
      if (config.metricsConfig[i].name == setting.goalName) {
        config.metricsConfig[i].goal = setting.value;
        configurationService.setConfiguration(config);
        return;
      }
    }
  }
}
