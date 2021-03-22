import 'package:VennUI/components/StatusBar.dart';
import 'package:VennUI/components/TopBarIcon.dart';
import 'package:VennUI/providers/SettingsProvider.dart';
import 'package:VennUI/utilies.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tuple/tuple.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:VennUI/components/SliderWidget.dart';
import 'package:VennUI/api/v1/ui.pb.dart' as proto;
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                colors: [
                  const Color(0xfff9fafe),
                  const Color(0xfff4f4fc),
                ],
              ),
            ),
            child: Column(
              children: [
                SettingsTitleBar(),
                SettingsPanel(),
                SizedBox(
                  height: 10,
                ),
                SettingsBottomBar(),
              ],
            )),
        StatusBar(),
      ],
    ));
  }
}

class SettingsTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(40, 50, 40, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                    color: baseColor,
                    fontSize: 55,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 15),
              Spacer(),
              GestureDetector(
                  child: Container(
                child: IconButton(
                    icon: Icon(Typicons.wi_fi),
                    onPressed: () {},
                    iconSize: 50.0,
                    color: baseColor),
                height: 60,
                width: 60,
              )),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                  child: Container(
                child: IconButton(
                    icon: Icon(Typicons.user),
                    onPressed: () {},
                    iconSize: 50.0,
                    color: baseColor),
                height: 60,
                width: 60,
              )),
              SizedBox(
                width: 15,
              ),
              TopBarIcon(Icon(Typicons.home), 'dashboard', 50),
            ]));
  }
}

class SettingsBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10,
        padding: EdgeInsets.fromLTRB(0, 15, 145, 0),
        child: AnimatedSmoothIndicator(
          count: context.watch<SettingsProvider>().numPages,
          effect: WormEffect(
              dotColor: paleColor.withOpacity(0.6), activeDotColor: infoColor),
          activeIndex: context.watch<SettingsProvider>().activeIndex,
        ));
  }
}

class SettingsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: paleColor.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 15,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.fromLTRB(40, 15, 0, 0),
        height: 900,
        width: 800,
        child: Selector<SettingsProvider, bool>(
          selector: (BuildContext context, SettingsProvider provider) =>
              provider.isLoading,
          builder: (context, bool isLoading, _) {
            if (isLoading) {
              return Container();
            } else {
              return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  child: PageView(
                    controller: PageController(
                      viewportFraction: 0.99,
                    ),
                    children: getSliderPages(context),
                    onPageChanged: (index) => context
                        .read<SettingsProvider>()
                        .setActivePageIndex(index),
                  ));
            }
          },
        ),
      ),
      SettingsButtons(),
    ]);
  }

  List<Widget> getSliderPages(BuildContext context) {
    int numSettings =
        Provider.of<SettingsProvider>(context, listen: false).settings.length;
    int numPages =
        Provider.of<SettingsProvider>(context, listen: false).numPages;
    int sliderPerPage =
        Provider.of<SettingsProvider>(context, listen: false).sliderPerPage;
    List<Container> pagesContainer = [];
    for (int indexPage = 0; indexPage < numPages; indexPage++) {
      List<Widget> slidersRow1 = [];
      List<Widget> slidersRow2 = [];
      List<Widget> sliders = [];
      for (int indexSlider = indexPage * sliderPerPage;
          indexSlider < (indexPage + 1) * sliderPerPage;
          indexSlider++) {
        if (indexSlider > numSettings - 1) {
          break;
        }
        // if()
        sliders.add(
          Selector<SettingsProvider, Tuple3<proto.Setting, int, int>>(
            shouldRebuild: (Tuple3<proto.Setting, int, int> prev,
                    Tuple3<proto.Setting, int, int> next) =>
                next.item2 == next.item3,
            selector: (BuildContext context, SettingsProvider provider) =>
                Tuple3(provider.settings[indexSlider], provider.modifiedSlider,
                    indexSlider),
            builder: (context, tuple, _) {
              return SliderContainer(
                index: indexSlider,
                key: Key(indexSlider.toString()),
                setting: tuple.item1,
              );
            },
          ),
        );
      }

      pagesContainer.add(Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: sliders,
        ),
      ));
    }
    return pagesContainer;
  }
}

class SettingsButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 200),
        child: Column(
          children: [
            SettingButton('Save', (arg) {
              context.read<SettingsProvider>().saveRecipe();
            }),
            SizedBox(
              height: 15,
            ),
            SettingButton('Load', (arg) {
              context.read<SettingsProvider>().loadRecipe();
            }),
            SizedBox(
              height: 15,
            ),
            SettingButton('Info', (arg) {
              context.read<SettingsProvider>().showInfoModal(arg);
            }),
          ],
        ));
  }
}

class SettingButton extends StatelessWidget {
  final String text;
  final Function f;

  SettingButton(this.text, this.f);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: paleColor.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 18,
            offset: Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () => f(context),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            splashColor: Colors.grey[500],
            child: Center(
              child: Text(
                this.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                    color: baseColor),
              ),
            )),
      ),
    );
  }
}

class SliderContainer extends StatelessWidget {
  final proto.Setting setting;
  final int index;

  SliderContainer({
    Key key,
    this.setting,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              AlertDialog alert = AlertDialog(
                title: Text("Information"),
                content: Text(setting.info),
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            },
            child: Container(
              padding: EdgeInsets.only(top: 30, bottom: 8),
              child: Text(
                setting.name,
                style: TextStyle(
                  color: baseColor,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 0),
              alignment: Alignment.center,
              child: SliderWidget(
                max: setting.max.toInt(),
                min: setting.min.toInt(),
                sliderHeight: 48,
                value: setting.value.toInt(),
                index: this.index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
