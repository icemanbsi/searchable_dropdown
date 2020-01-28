# searchable_dropdown

Searchable dropdown item inside a dialog

<h5>Normal Usage</h5>
<br/><img src="https://raw.githubusercontent.com/icemanbsi/searchable_dropdown/master/doc/sample1.gif"/>


## Props
| props                   | types           | defaultValues                                                                                                     |
| :---------------------- | :-------------: | :---------------------------------------------------------------------------------------------------------------: |
| items                   | List<DropdownMenuItem<T>>        |                                                                                                  |
| onChanged               | ValueChanged<T> |                                                                                                                   |
| value                   | T               |                                                                                                                   |
| style                   | TextStyle       |                                                                                                                   |
| searchHint              | Widget          |                                                                                                                   |
| hint                    | Widget          |                                                                                                                   |
| disabledHint            | Widget          |                                                                                                                   |
| icon                    | Widget          |                                                                                                                   |
| underline               | Widget          |                                                                                                                   |
| iconEnabledColor        | Color           |                                                                                                                   |
| iconDisabledColor       | Color           |                                                                                                                   |
| iconSize                | Double          | 24                                                                                                                |
| isCaseSensitiveSearch   | bool            | false                                                                                                             |
| isExpanded              | bool            | false                                                                                                             |
| closeButtonText         | String          | "Close"                                                                                                           |
| displayClearButton      | bool            | false                                                                                                             |
| clearIcon               | Widget          | Icon(Icons.clear)                                                                                                 |
| onClear                 | Function        | null                                                                                                             |


## Usage
```dart
import 'package:searchable_dropdown/searchable_dropdown.dart';

List<DropdownMenuItem> items = [];
String selectedValue;

Widget widget() {
  for(int i=0; i < 20; i++){
    items.add(new DropdownMenuItem(
      child: new Text(
        'test ' + i.toString(),
      ),
      value: 'test ' + i.toString(),
    ));
  }

  return new SearchableDropdown(
     items: items,
     value: selectedValue,
     hint: new Text(
       'Select One'
     ),
     searchHint: new Text(
       'Select One',
       style: new TextStyle(
           fontSize: 20
       ),
     ),
     onChanged: (value) {
       setState(() {
         selectedValue = value;
       });
     },
   );
}
```
