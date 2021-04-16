import 'package:VennUI/providers/SettingsProvider.dart';
import 'package:VennUI/utilies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectorSettings extends StatefulWidget {
  final _index;

  SelectorSettings(
    this._index,
  );

  @override
  _SelectorSettingsState createState() => _SelectorSettingsState();
}

class _SelectorSettingsState extends State<SelectorSettings> {
  String _selectedItem;
  List<String> _items;
  String _name;

  @override
  Widget build(BuildContext context) {
    _selectedItem = context
        .watch<SettingsProvider>()
        .selectors[widget._index]
        .selectedChoice
        .name;
    _name = context.watch<SettingsProvider>().selectors[widget._index].name;
    _items =
        context.watch<SettingsProvider>().selectorChoicesName[widget._index];
    return Container(
        height: 160,
        width: 420,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          // color: paleBlue.withOpacity(0.2),
          // border: Border.all(color: darkBlue, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                _name,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: baseColor),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(children: [
              Expanded(
                  child: InputDecorator(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: paleColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              dropdownColor: Colors.white,
                              style: TextStyle(fontSize: 22, color: baseColor),
                              elevation: 1,
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconEnabledColor: paleColor,
                              isExpanded: true,
                              value:
                                  _selectedItem, // A global variable used to keep track of the selection
                              items: _items.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                  ),
                                );
                              }).toList(),
                              onChanged: (selectedItem) =>
                                  updateSelectedChoice(context, selectedItem)
                              // onChanged: null,
                              )))),
              SizedBox(
                width: 10,
              ),
              // GestureDetector(
              //   child: Icon(
              //     Icons.edit,
              //     size: 40,
              //   ),
              // )
            ]),
          ],
        ));
  }

  void updateSelectedChoice(BuildContext context, String newItem) {
    context
        .read<SettingsProvider>()
        .updateSelectorChoice(widget._index, newItem);
    setState(
      () => _selectedItem = newItem,
    );
  }
}
