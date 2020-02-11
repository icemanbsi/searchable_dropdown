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
| keyboardType       | TextInputType            | TextInputType.text                                                                                                             |
| validator       | Function            | null                                                                                                             |
| label       | Function            | null                                                                                                             |
| searchFn       | Function            | null                                                                                                             |


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

### Label and validator
Label and error can be returned by a function as a Widget:
```
      validator: (value){return(value==null?Row(
        children: <Widget>[
          Icon(Icons.error,color: Colors.red,size: 14,),
          SizedBox(width: 5,),
          Text("Mandatory",style: TextStyle(color: Colors.red,fontSize: 13),),
        ],
      ):null);},
      label: (value){return(Row(
        children: <Widget>[
          Icon(Icons.info,color: Colors.blueAccent,size: 14,),
          SizedBox(width: 5,),
          Text("Oil producer",style: TextStyle(color: Colors.blueAccent,fontSize: 13),),
        ],
      ));},
```
![image](https://user-images.githubusercontent.com/32125299/74223889-f6b4ed80-4cb7-11ea-972b-bd62fcef29d8.png)
Or as a String:
```
      validator: (value){return(value==null?"Mandatory":null);},
      label: (value){return("Oil producer");},
```
![image](https://user-images.githubusercontent.com/32125299/74223999-311e8a80-4cb8-11ea-91a1-73f853277703.png)

### Search keyboard
The keyboard type for searches can be defined as follows:
```
keyboardType: TextInputType.number,
```
![image](https://user-images.githubusercontent.com/32125299/74224388-0a148880-4cb9-11ea-9fc3-82491474e44d.png)

### Search function
One may wish to search through the list items differently than just by finding the keyword string matching in the toString() of the value. For example, one may wish to search with multiple keywords if they are separated by a space. The example below shows how to make use of the `searchFn` for this purpose:
```dart
      searchFn: (String keyword, List<DropdownMenuItem<MyData>> items) {
        List<int> ret = List<int>();
        if (keyword != null && items != null) {
          keyword.split(" ").forEach((k) {
            int i = 0;
            items.forEach((item) {
              if (keyword.isEmpty || (k.isNotEmpty &&
                  (item.value.toString().toLowerCase().contains(k.toLowerCase())))) {
                ret.add(i);
              }
              i++;
            });
          });
        }
        if(keyword.isEmpty){
          ret = Iterable<int>.generate(items.length).toList();
        }
        return (ret);
      },
```
Here is an example of result:

![image](https://user-images.githubusercontent.com/32125299/74232473-29b3ad00-4cc9-11ea-94bd-fd4b64739e20.png)
