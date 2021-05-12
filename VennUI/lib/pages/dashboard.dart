import 'package:VennUI/components/BottomBar.dart';
import 'package:VennUI/components/Notification.dart';
import 'package:VennUI/dialogs/user_dialog.dart';
import 'package:VennUI/dialogs/wifi_dialog.dart';
import 'package:VennUI/providers/NetworkProvider.dart';
import 'package:VennUI/providers/DashboardProvider.dart';
import 'package:VennUI/providers/NotificationProvider.dart';
import 'package:VennUI/providers/UserProvider.dart';
import 'package:VennUI/utilies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:VennUI/components/StatusBar.dart';
import 'package:VennUI/components/TopBarIcon.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = PageController();

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
                MetricTitleBar(),
                MetricPanel(),
              ],
            )),
        PageIndicator(),
        StatusBar(),
        BottomBar(),
        // Display notification object in the dashboard stack
        context
            .select((NotificationProvider provider) => provider.notification),
      ],
    ));
  }
}

class MetricPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<DashboardProvider, bool>(
      selector: (BuildContext context, DashboardProvider provider) =>
          provider.isLoading,
      builder: (context, bool isLoading, _) {
        if (isLoading) {
          return Container();
        } else {
          return SizedBox(
            width: 1920,
            height: 930,
            child: Container(
              child: PageView(
                onPageChanged: (index) =>
                    context.read<DashboardProvider>().setActivePageIndex(index),
                scrollDirection: Axis.horizontal,
                controller: PageController(viewportFraction: 0.999),
                children: <Widget>[
                  DashboardPanel(4, 8),
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
        count: context.watch<DashboardProvider>().numPages,
        effect: WormEffect(
          dotColor: paleColor.withOpacity(0.6),
          activeDotColor: infoColor,
          dotHeight: 12,
          dotWidth: 12,
        ),
        activeIndex: context.watch<DashboardProvider>().activeIndex,
      ),
    );
  }
}

class DashboardPanel extends StatelessWidget {
  final int width;
  final int height;

  DashboardPanel(
    this.height,
    this.width,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Stack(
          children: List.generate(
              context.watch<DashboardProvider>().widgets.length,
              (index) => Selector<DashboardProvider, int>(
                    shouldRebuild: (_, next) =>
                        // Next is the index of the tile that was modified
                        next == index,
                    selector:
                        (BuildContext context, DashboardProvider provider) =>
                            provider.modifiedTileIndex,
                    builder: (context, __, _) {
                      return context.watch<DashboardProvider>().widgets[index];
                    },
                  ))),
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
                    onPressed: () {
                      final provider =
                          Provider.of<NetworkProvider>(context, listen: false);
                      showDialog(
                          context: context,
                          builder: (_) {
                            return ChangeNotifierProvider.value(
                                value: provider, child: WifiDialogBox());
                          });
                    },
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
                    onPressed: () {
                      final provider =
                          Provider.of<UserProvider>(context, listen: false);
                      showDialog(
                          context: context,
                          builder: (_) {
                            return ChangeNotifierProvider.value(
                                value: provider, child: UserDialogBox());
                          });
                    },
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
    return Selector<DashboardProvider, bool>(
        selector: (BuildContext context, DashboardProvider provider) =>
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
