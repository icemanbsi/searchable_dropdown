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
| selectedValueWidgetFn   | Function        | null                                                                                                             |
| assertUniqueValue       | bool            | true                                                                                                             |


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
### Values
Values of the `DropdownMenuItem` objects must be strings or implement the `toString()` method. Those strings are used for the search.

### Clear button
A clear button can be displayed to unselect the selected value.

### Display selected value differently
It can be that one wants to display the selected value differently than in the list. In this case, the parameter selectedValueWidgetFn can be used to customize the rendering widget. Here is an example with an outcome similar to the one in the main.dart example:
```
selectedValueWidgetFn: (value) => Padding(
  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
  child:Text(
    value??"Select please",
    style: value==null?TextStyle(color:Theme.of(context).hintColor):null,
  )
),
```

### Assert unique value
It can be that the selected value doesn't correspond to a single or any items. In this case, an assert will generate an error. If, you would like to avoid this assert, cou can call the `SearchableDropDown` constructor with the following parameter:
```
assertUniqueValue: false,
```
