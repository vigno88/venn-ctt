import 'package:VennUI/providers/SettingsProvider.dart';
import 'package:VennUI/utilies.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:provider/provider.dart';

class StatusBar extends StatefulWidget {
  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  String _timeString;
  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
            child: Text(
              _timeString,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w600, color: baseColor),
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
            child: Selector<SettingsProvider, bool>(
                selector: (BuildContext context, SettingsProvider provider) =>
                    provider.isLoading,
                builder: (context, bool isLoading, _) {
                  if (isLoading) {
                    return Text("");
                  } else {
                    return Text(
                      "Recipe: " +
                          context
                              .watch<SettingsProvider>()
                              .recipes[context
                                  .watch<SettingsProvider>()
                                  .selectedRecipe]
                              .title,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: baseColor),
                    );
                  }
                }),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
            child: Text(
              _timeString,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  void _getTime() {
    if (this.mounted) {
      final DateTime now = DateTime.now();
      final String formattedDateTime = _formatDateTime(now);
      setState(() {
        _timeString = formattedDateTime;
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }
}
