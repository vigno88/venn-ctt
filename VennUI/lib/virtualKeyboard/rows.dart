import 'package:VennUI/virtualKeyboard/key.dart';
import 'package:VennUI/virtualKeyboard/type.dart';
import 'package:VennUI/virtualKeyboard/key_type.dart';
import 'package:VennUI/virtualKeyboard/key_action.dart';

/// Keys for Virtual Keyboard's rows.
const List<List> keyRows = [
  // Row 1
  const [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
  ],
  // Row 2
  const [
    'q',
    'w',
    'e',
    'r',
    't',
    'y',
    'u',
    'i',
    'o',
    'p',
  ],
  // Row 3
  const [
    'a',
    's',
    'd',
    'f',
    'g',
    'h',
    'j',
    'k',
    'l',
    '+',
    ':',
  ],
  // Row 4
  const [
    'z',
    'x',
    'c',
    'v',
    'b',
    'n',
    'm',
    '.',
    '-',
    '/',
  ],
  // Row 5
  const [
    '@',
    '_',
  ]
];

/// Keys for Virtual Keyboard's rows.
const List<List> keyRowsNumeric = [
  // Row 1
  const [
    '1',
    '2',
    '3',
  ],
  // Row 1
  const [
    '4',
    '5',
    '6',
  ],
  // Row 1
  const [
    '7',
    '8',
    '9',
  ],
  // Row 1
  const [
    '.',
    '0',
  ],
];

/// Returns a list of `VirtualKeyboardKey` objects for Numeric keyboard.
List<VirtualKeyboardKey> getKeyboardRowKeysNumeric(rowNum) {
  // Generate VirtualKeyboardKey objects for each row.
  return List.generate(keyRowsNumeric[rowNum].length, (int keyNum) {
    // Get key string value.
    String key = keyRowsNumeric[rowNum][keyNum];

    // Create and return new VirtualKeyboardKey object.
    return VirtualKeyboardKey(
      text: key,
      capsText: key.toUpperCase(),
      keyType: VirtualKeyboardKeyType.String,
    );
  });
}

/// Returns a list of `VirtualKeyboardKey` objects.
List<VirtualKeyboardKey> getKeyboardRowKeys(rowNum) {
  // Generate VirtualKeyboardKey objects for each row.
  return List.generate(keyRows[rowNum].length, (int keyNum) {
    // Get key string value.
    String key = keyRows[rowNum][keyNum];

    // Create and return new VirtualKeyboardKey object.
    return VirtualKeyboardKey(
      text: key,
      capsText: key.toUpperCase(),
      keyType: VirtualKeyboardKeyType.String,
    );
  });
}

/// Returns a list of VirtualKeyboard rows with `VirtualKeyboardKey` objects.
List<List<VirtualKeyboardKey>> getKeyboardRows() {
  // Generate lists for each keyboard row.
  return List.generate(keyRows.length, (int rowNum) {
    // Will contain the keyboard row keys.
    List<VirtualKeyboardKey> rowKeys = [];

    // We have to add Action keys to keyboard.
    switch (rowNum) {
      case 1:
        // String keys.
        rowKeys = getKeyboardRowKeys(rowNum);

        // 'Backspace' button.
        rowKeys.add(
          VirtualKeyboardKey(
              keyType: VirtualKeyboardKeyType.Action,
              action: VirtualKeyboardKeyAction.Backspace),
        );
        break;
      case 2:
        // String keys.
        rowKeys = getKeyboardRowKeys(rowNum);

        // 'Return' button.
        rowKeys.add(
          VirtualKeyboardKey(
              keyType: VirtualKeyboardKeyType.Action,
              action: VirtualKeyboardKeyAction.Return,
              text: '\n',
              capsText: '\n'),
        );
        break;
      case 3:
        // Left Shift
        rowKeys.add(
          VirtualKeyboardKey(
              keyType: VirtualKeyboardKeyType.Action,
              action: VirtualKeyboardKeyAction.Shift),
        );

        // String keys.
        rowKeys.addAll(getKeyboardRowKeys(rowNum));

        // Right Shift
        rowKeys.add(
          VirtualKeyboardKey(
              keyType: VirtualKeyboardKeyType.Action,
              action: VirtualKeyboardKeyAction.Shift),
        );
        break;
      case 4:
        // String keys.
        rowKeys = getKeyboardRowKeys(rowNum);

        // Insert the space key into second position of row.
        rowKeys.insert(
          1,
          VirtualKeyboardKey(
              keyType: VirtualKeyboardKeyType.Action,
              text: ' ',
              capsText: ' ',
              action: VirtualKeyboardKeyAction.Space),
        );

        break;
      default:
        rowKeys = getKeyboardRowKeys(rowNum);
    }

    return rowKeys;
  });
}

/// Returns a list of VirtualKeyboard rows with `VirtualKeyboardKey` objects.
List<List<VirtualKeyboardKey>> getKeyboardRowsNumeric() {
  // Generate lists for each keyboard row.
  return List.generate(keyRowsNumeric.length, (int rowNum) {
    // Will contain the keyboard row keys.
    List<VirtualKeyboardKey> rowKeys = [];

    // We have to add Action keys to keyboard.
    switch (rowNum) {
      case 3:
        // String keys.
        rowKeys.addAll(getKeyboardRowKeysNumeric(rowNum));

        // Right Shift
        rowKeys.add(
          VirtualKeyboardKey(
              keyType: VirtualKeyboardKeyType.Action,
              action: VirtualKeyboardKeyAction.Backspace),
        );
        break;
      default:
        rowKeys = getKeyboardRowKeysNumeric(rowNum);
    }

    return rowKeys;
  });
}
