import 'package:VennUI/components/BottomBar.dart';
import 'package:VennUI/providers/MetricProvider.dart';
import 'package:VennUI/providers/WidgetGridProvider.dart';
import 'package:VennUI/utilies.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tuple/tuple.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:VennUI/components/StatusBar.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:VennUI/components/TopBarIcon.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            colors: [
              const Color(0xfff9fafe),
              const Color(0xfff4f4fc),
            ],
          ),
        ),
        child: Scaffold(
            body: Stack(
          children: [
            BottomBar(),
            StatusBar(),
            PageIndicator(),
            Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    MetricTitleBar(),
                    MetricPanel_(),
                  ],
                )),
          ],
        )));
  }
}

class MetricPanel_ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<MetricProvider, bool>(
      selector: (BuildContext context, MetricProvider provider) =>
          provider.isLoading,
      builder: (context, bool isLoading, _) {
        if (isLoading) {
          return Container();
        } else {
          return SizedBox(
            width: 1920,
            height: 930,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: PageView(
                onPageChanged: (index) => context
                    .read<WidgetGridProvider>()
                    .setActivePageIndex(index),
                scrollDirection: Axis.horizontal,
                controller: PageController(),
                children: <Widget>[
                  MetricPage(4, 8),
                  MetricPage(4, 8),
                  MetricPage(4, 8),
                  MetricPage(4, 8),
                  MetricPage(4, 8),
                  MetricPage(4, 8),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class PageIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
      child: AnimatedSmoothIndicator(
        count: context.watch<WidgetGridProvider>().numPages,
        effect: WormEffect(
          dotColor: paleColor.withOpacity(0.6),
          activeDotColor: infoColor,
          dotHeight: 12,
          dotWidth: 12,
        ),
        activeIndex: context.watch<WidgetGridProvider>().activeIndex,
      ),
    );
  }
}

class MetricPage extends StatelessWidget {
  final int width;
  final int height;

  MetricPage(
    this.height,
    this.width,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Stack(
        children: context.watch<WidgetGridProvider>().getWidgets(),
      ),
    );
  }
}

class MetricPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<MetricProvider, bool>(
      selector: (BuildContext context, MetricProvider provider) =>
          provider.isLoading,
      builder: (context, bool isLoading, _) {
        if (isLoading) {
          return Container();
          // return CircularProgressIndicator(
          //   valueColor: AlwaysStoppedAnimation<Color>(baseColor),
          // );
        } else {
          return SizedBox(
              height: 900,
              child: GridView.count(
                childAspectRatio: 0.38,
                primary: false,
                padding: EdgeInsets.fromLTRB(40, 25, 40, 25),
                crossAxisSpacing: 40,
                mainAxisSpacing: 40,
                crossAxisCount: 4,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    context.watch<MetricProvider>().metricTiles.length,
                    (index) =>
                        Selector<MetricProvider, Tuple3<MetricTile, int, int>>(
                          shouldRebuild: (Tuple3<MetricTile, int, int> prev,
                                  Tuple3<MetricTile, int, int> next) =>
                              // Item 2 is the modified index tile that is watch in the provider
                              // and item3 is the index of the current tile
                              next.item2 == next.item3,
                          selector:
                              (BuildContext context, MetricProvider provider) =>
                                  Tuple3(provider.metricTiles[index],
                                      provider.modifiedTileIndex, index),
                          builder: (context, tuple, _) {
                            if (tuple.item1.isAlert) {
                              return CustomAnimation<double>(
                                control: CustomAnimationControl.MIRROR,
                                tween: 0.5.tweenTo(0.9),
                                duration: 1.seconds,
                                delay: (0.5).seconds,
                                curve: Curves.easeInOut,
                                startPosition: 0.3,
                                builder: (context, _, value) {
                                  return MetricChip(Key(index.toString()),
                                      tuple.item1, value);
                                },
                              );
                            } else {
                              return MetricChip(
                                  Key(index.toString()), tuple.item1, 0);
                            }
                          },
                        )),
              ));
        }
      },
    );
  }
}

class MetricTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(55, 60, 40, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Dashboard',
                style: TextStyle(
                    color: baseColor,
                    fontSize: 55,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 15),
              Spacer(),
              MetricAlert(),
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
              TopBarIcon(Icon(Typicons.cog), 'settings', 50.0),
            ]));
  }
}

class MetricAlert extends StatelessWidget {
  final modalTitle = 'Alerte';
  final modalText = 'Information concernant l\'alerte';

  @override
  Widget build(BuildContext context) {
    return Selector<MetricProvider, bool>(
        selector: (BuildContext context, MetricProvider provider) =>
            provider.isAlert,
        builder: (context, isAlert, _) {
          if (isAlert) {
            return GestureDetector(
                onTap: () {
                  showModal(context, modalTitle, modalText);
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.9),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 17,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: IconButton(
                      icon: Icon(Typicons.info_large),
                      onPressed: () {
                        showModal(context, modalTitle, modalText);
                      },
                      iconSize: 25.0,
                      color: Colors.white),
                  height: 40,
                  width: 60,
                ));
          } else {
            return Container();
          }
        });
  }
}

class MetricChip extends StatelessWidget {
  MetricChip(
    Key key,
    this.tile,
    this.opacityValue,
  ) : super(key: key);

  final MetricTile tile;
  final double opacityValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showModal(context, "Information of" + tile.name, tile.info);
        },
        child: Container(
          decoration: BoxDecoration(
            color:
                tile.isAlert ? Colors.redAccent.withOpacity(0.6) : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: tile.isAlert
                    ? Colors.redAccent.withOpacity(opacityValue)
                    : paleColor.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 15,
                offset: Offset(0, 10), // changes position of shadow
              ),
            ],
          ),
          height: 170,
          width: 440,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: IconButton(
                    icon: tile.icon,
                    onPressed: () {
                      showModal(
                          context, "Information of" + tile.name, tile.info);
                    },
                    iconSize: 90.0,
                    color: Colors.white),
              ),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 254,
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: AutoSizeText.rich(
                        TextSpan(
                            text: "",
                            style: TextStyle(
                                color: tile.isAlert ? Colors.white : baseColor,
                                fontSize: 60,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: tile.value.toStringAsFixed(1) +
                                      " " +
                                      tile.unit,
                                  style: TextStyle(
                                      color: tile.isAlert
                                          ? Colors.white
                                          : baseColor,
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: ' (' +
                                      tile.goal.toString() +
                                      ' ' +
                                      tile.unit +
                                      ')',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: tile.hasGoal
                                          ? (tile.isAlert
                                              ? Colors.white
                                              : paleColor.withOpacity(0.7))
                                          : Colors.transparent)),
                            ]),
                        maxLines: 1,
                        minFontSize: 5,
                        textAlign: TextAlign.left,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: 254,
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: AutoSizeText.rich(
                        TextSpan(
                            text: "",
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: tile.type + " ",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: tile.isAlert
                                          ? Colors.white
                                          : infoColor)),
                              TextSpan(
                                text: tile.name,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: tile.isAlert
                                        ? Colors.white
                                        : infoColor),
                              )
                            ]),
                        maxLines: 1,
                        minFontSize: 5,
                        textAlign: TextAlign.left,
                      )),
                ],
              ))
            ],
          ),
        ));
  }
}
