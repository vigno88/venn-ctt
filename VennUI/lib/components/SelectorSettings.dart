import 'package:VennUI/utilies.dart';
import 'package:flutter/material.dart';

class SelectorSettings extends StatefulWidget {
  static const _fruits = [
    'Apple',
    'Orange',
    'Lemon',
    'Strawberry',
    'Peach',
    'Cherry',
    'Watermelon',
  ];

  @override
  _SelectorSettingsState createState() => _SelectorSettingsState();
}

class _SelectorSettingsState extends State<SelectorSettings> {
  var _selectedFruit = 'Cherry';

  @override
  Widget build(BuildContext context) {
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
                "Title",
                style: TextStyle(
                    fontSize: 32,
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
                            _selectedFruit, // A global variable used to keep track of the selection
                        items: SelectorSettings._fruits.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                            ),
                          );
                        }).toList(),
                        onChanged: (selectedItem) => setState(
                          () => _selectedFruit = selectedItem,
                        ),
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
}
