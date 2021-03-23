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
            child: Container(
                padding: EdgeInsets.fromLTRB(55, 0, 40, 0),
                child: Column(
                  children: [
                    SettingsTitleBar(),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SettingsPanel(),
                              SizedBox(
                                height: 10,
                              ),
                              SelectorPanel(),
                            ],
                          ),
                          RecipePanel(),
                        ]),
                  ],
                ))),
        StatusBar(),
      ],
    ));
  }
}

class RecipePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 470,
              height: 910,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: tileShadows(3, 1, 3),
              ),
            ),
            RecipeButtons(),
          ],
        ));
  }
}

class SelectorPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(children: [
          Container(
            width: 1000,
            height: 410,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: tileShadows(3, 1, 3),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SelectorPageIndicator(),
        ]),
        SelectorButtons(),
      ],
    ));
  }
}

class SettingsTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 60, 0, 15),
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

class SettingsPageIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10,
        child: AnimatedSmoothIndicator(
          count: context.watch<SettingsProvider>().numPages,
          effect: WormEffect(
              dotColor: paleColor.withOpacity(0.6), activeDotColor: infoColor),
          activeIndex: context.watch<SettingsProvider>().activeIndex,
        ));
  }
}

class SelectorPageIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10,
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
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: tileShadows(3, 1, 3),
                  ),
                  height: 460,
                  width: 1000,
                  child: Selector<SettingsProvider, bool>(
                    selector:
                        (BuildContext context, SettingsProvider provider) =>
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
                SizedBox(
                  height: 15,
                ),
                SettingsPageIndicator(),
              ]),
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
      List<Widget> sliders = [];
      for (int indexSlider = indexPage * sliderPerPage;
          indexSlider < (indexPage + 1) * sliderPerPage;
          indexSlider++) {
        if (indexSlider > numSettings - 1) {
          break;
        }
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

class RecipeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
        child: Column(
          children: [
            SettingButton('Select', (arg) {
              context.read<SettingsProvider>().saveRecipe();
            }),
            SizedBox(
              height: 15,
            ),
            SettingButton('Edit', (arg) {
              context.read<SettingsProvider>().saveRecipe();
            }),
            SizedBox(
              height: 15,
            ),
            SettingButton('Create', (arg) {
              context.read<SettingsProvider>().loadRecipe();
            }),
            SizedBox(
              height: 15,
            ),
            SettingButton('Delete', (arg) {
              context.read<SettingsProvider>().showInfoModal(arg);
            }),
          ],
        ));
  }
}

class SelectorButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
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
            SettingButton('Edit', (arg) {
              context.read<SettingsProvider>().showInfoModal(arg);
            }),
          ],
        ));
  }
}

class SettingsButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
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

class SettingButton extends StatefulWidget {
  final String text;
  final Function f;

  SettingButton(this.text, this.f);

  @override
  _SettingButtonState createState() => _SettingButtonState();
}

class _SettingButtonState extends State<SettingButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 2,
      ),
      lowerBound: 0.5,
      upperBound: 1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: () => widget.f(context),
      child: Container(
        height: 60,
        width: 140,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: tileShadows(5 * _scale, 1 * _scale, 3 * _scale)),
        child: Material(
            color: Colors.transparent,
            // child: GestureDetector(
            //     onTapDown: _tapDown,
            //     onTapUp: _tapUp,
            //     onTap: () => widget.f(context),
            // borderRadius: BorderRadius.all(Radius.circular(10)),
            // splashColor: Colors.grey[500],
            child: Center(
              child: Text(
                this.widget.text,
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

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
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
