import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ExampleNumber {
  int number;

  static final Map<int, String> map = {
    0: "zero",
    1: "one",
    2: "two",
    3: "three",
    4: "four",
    5: "five",
    6: "six",
    7: "seven",
    8: "eight",
    9: "nine",
    10: "ten",
    11: "eleven",
    12: "twelve",
    13: "thirteen",
    14: "fourteen",
    15: "fifteen",
  };

  String get numberString {
    return (map.containsKey(number) ? map[number] : "unknown");
  }

  ExampleNumber(this.number);

  String toString() {
    return ("$number $numberString");
  }

  static List<ExampleNumber> get list {
    return (map.keys.map((num) {
      return (ExampleNumber(num));
    })).toList();
  }
}

void main() {
  testWidgets(
    'single dialog open dialog, search keyword, select single value, clear',
    (WidgetTester tester) async {
      String selectedValue;
      String searchKeyword = "4";
      List<DropdownMenuItem> items = [];
      for (int i = 0; i < 20; i++) {
        items.add(new DropdownMenuItem(
          child: new Text(
            'test ' + i.toString(),
          ),
          value: 'test ' + i.toString(),
        ));
      }
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Search Choices plugin test'),
          ),
          body: Center(
            child: SearchableDropdown.single(
              items: items,
              value: selectedValue,
              hint: new Text('Select One'),
              searchHint: new Text(
                'Search and select one',
                style: new TextStyle(fontSize: 20),
              ),
              onChanged: (value) {
//              setState(() {
                selectedValue = value;
//              });
              },
            ),
          ),
        ),
      ));
      final clickableResultPlaceHolderFinder =
          find.byKey(Key("clickableResultPlaceHolder"));
      expect(clickableResultPlaceHolderFinder, findsNWidgets(1),
          reason: "Initial widget in place");
      final nothingSelectedFinder = find.descendant(
          of: clickableResultPlaceHolderFinder,
          matching: find.text("Select One"));
      expect(nothingSelectedFinder, findsNWidgets(1), reason: "No selection");
      await tester.tap(nothingSelectedFinder);
      await tester.pump();
      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsNWidgets(1),
          reason: "List of items displayed");
      ListView listView = tester.element(listViewFinder).widget;
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsNWidgets(1),
          reason: "Search field displayed");
      expect(listView.semanticChildCount, items.length,
          reason: "List of items is complete");
      await tester.enterText(textFieldFinder, searchKeyword);
      await tester.pump();
      listView = tester.element(listViewFinder).widget;
      int expectedNbResults = items.where((it) {
        return (it.value.toString().contains(searchKeyword));
      }).length;
      expect(listView.semanticChildCount, expectedNbResults,
          reason: "Search filter number of items displayed");
      String expectedValue = items.firstWhere((it) {
        return (it.value.toString().contains(searchKeyword));
      }).value;
      final itemFinder = find.descendant(
          of: listViewFinder,
          matching: find.widgetWithText(DropdownMenuItem, expectedValue));
      expect(itemFinder, findsNWidgets(1),
          reason: "One item corresponds to search criteria");
      await tester.tap(itemFinder);
      await tester.pump();
      final dropDownDialogFinder = find.byType(DropdownDialog);
      expect(dropDownDialogFinder, findsNWidgets(0),
          reason: "Items list is closed after selection");
      expect(selectedValue, expectedValue,
          reason: "Selected value corresponds to tapped item");
      expect(nothingSelectedFinder, findsNWidgets(0),
          reason: "Something selected");
      final valueSelectedFinder = find.descendant(
          of: clickableResultPlaceHolderFinder,
          matching: find.text(expectedValue));
      expect(valueSelectedFinder, findsNWidgets(1),
          reason: "Expected is selected");
      final clearButtonFinder = find.byIcon(Icons.clear);
      expect(clearButtonFinder, findsNWidgets(1), reason: "One clear icon");
      await tester.tap(clearButtonFinder);
      await tester.pump();
      expect(nothingSelectedFinder, findsNWidgets(1), reason: "No selection");
      expect(selectedValue, null, reason: "selectedValue cleared");
    },
    skip: false,
  );

  testWidgets(
    'single menu open menu, search keyword, select single value, clear',
    (WidgetTester tester) async {
      String selectedValue;
      String searchKeyword = "4";
      List<DropdownMenuItem> items = [];
      for (int i = 0; i < 20; i++) {
        items.add(new DropdownMenuItem(
          child: new Text(
            'test ' + i.toString(),
          ),
          value: 'test ' + i.toString(),
        ));
      }
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Search Choices plugin test'),
          ),
          body: Center(
            child: SearchableDropdown.single(
              items: items,
              value: selectedValue,
              dialogBox: false,
              hint: new Text('Select One'),
              searchHint: new Text(
                'Search and select one',
                style: new TextStyle(fontSize: 20),
              ),
              onChanged: (value) {
//              setState(() {
                selectedValue = value;
//              });
              },
              menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
            ),
          ),
        ),
      ));
      final clickableResultPlaceHolderFinder =
          find.byKey(Key("clickableResultPlaceHolder"));
      expect(clickableResultPlaceHolderFinder, findsNWidgets(1),
          reason: "Initial widget in place");
      final nothingSelectedFinder = find.descendant(
          of: clickableResultPlaceHolderFinder,
          matching: find.text("Select One"));
      expect(nothingSelectedFinder, findsNWidgets(1), reason: "No selection");
      await tester.tap(nothingSelectedFinder);
      await tester.pump();
      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsNWidgets(1),
          reason: "List of items displayed");
      ListView listView = tester.element(listViewFinder).widget;
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsNWidgets(1),
          reason: "Search field displayed");
      expect(listView.semanticChildCount, items.length,
          reason: "List of items is complete");
      await tester.enterText(textFieldFinder, searchKeyword);
      await tester.pump();
      listView = tester.element(listViewFinder).widget;
      int expectedNbResults = items.where((it) {
        return (it.value.toString().contains(searchKeyword));
      }).length;
      expect(listView.semanticChildCount, expectedNbResults,
          reason: "Search filter number of items displayed");
      String expectedValue = items.firstWhere((it) {
        return (it.value.toString().contains(searchKeyword));
      }).value;
      final itemFinder = find.descendant(
          of: listViewFinder,
          matching: find.widgetWithText(DropdownMenuItem, expectedValue));
      expect(itemFinder, findsNWidgets(1),
          reason: "One item corresponds to search criteria");
      await tester.tap(itemFinder);
      await tester.pump();
      final dropDownDialogFinder = find.byType(DropdownDialog);
      expect(dropDownDialogFinder, findsNWidgets(0),
          reason: "Items list is closed after selection");
      expect(selectedValue, expectedValue,
          reason: "Selected value corresponds to tapped item");
      expect(nothingSelectedFinder, findsNWidgets(0),
          reason: "Something selected");
      final valueSelectedFinder = find.descendant(
          of: clickableResultPlaceHolderFinder,
          matching: find.text(expectedValue));
      expect(valueSelectedFinder, findsNWidgets(1),
          reason: "Expected is selected");
      final clearButtonFinder = find.byIcon(Icons.clear);
      expect(clearButtonFinder, findsNWidgets(1), reason: "One clear icon");
      await tester.tap(clearButtonFinder);
      await tester.pump();
      expect(nothingSelectedFinder, findsNWidgets(1), reason: "No selection");
      expect(selectedValue, null, reason: "selectedValue cleared");
    },
    skip: false,
  );

  testWidgets(
    'single object dialog open dialog, search keyword, select single value, clear',
    (WidgetTester tester) async {
      ExampleNumber selectedNumber;
      String searchKeyword = "4";
      List<DropdownMenuItem> items = ExampleNumber.list.map((exNum) {
        return (DropdownMenuItem(
            key: Key("dropdown${exNum.number}"),
            child: Text(exNum.numberString),
            value: exNum));
      }).toList();
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Search Choices plugin test'),
          ),
          body: Center(
            child: SearchableDropdown.single(
              items: items,
              value: selectedNumber,
              hint: "Select one number",
              searchHint: "Select one number",
              onChanged: (value) {
//              setState(() {
                selectedNumber = value;
//              });
              },
              dialogBox: true,
              isExpanded: true,
            ),
          ),
        ),
      ));
      final clickableResultPlaceHolderFinder =
          find.byKey(Key("clickableResultPlaceHolder"));
      expect(clickableResultPlaceHolderFinder, findsNWidgets(1),
          reason: "Initial widget in place");
      final nothingSelectedFinder = find.descendant(
          of: clickableResultPlaceHolderFinder,
          matching: find.text("Select one number"));
      expect(nothingSelectedFinder, findsNWidgets(1), reason: "No selection");
      await tester.tap(nothingSelectedFinder);
      await tester.pump();
      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsNWidgets(1),
          reason: "List of items displayed");
      ListView listView = tester.element(listViewFinder).widget;
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsNWidgets(1),
          reason: "Search field displayed");
      expect(listView.semanticChildCount, items.length,
          reason: "List of items is complete");
      await tester.enterText(textFieldFinder, searchKeyword);
      await tester.pump();
      listView = tester.element(listViewFinder).widget;
      int expectedNbResults = items.where((it) {
        return (it.value.toString().contains(searchKeyword));
      }).length;
      expect(listView.semanticChildCount, expectedNbResults,
          reason: "Search filter number of items displayed");
      ExampleNumber expectedValue = items.firstWhere((it) {
        return (it.value.toString().contains(searchKeyword));
      }).value;
      final itemFinder = find.byKey(Key("dropdown${expectedValue.number}"));
      expect(itemFinder, findsNWidgets(1),
          reason: "One item corresponds to search criteria");
      await tester.tap(itemFinder);
      await tester.pump();
      final dropDownDialogFinder = find.byType(DropdownDialog);
      expect(dropDownDialogFinder, findsNWidgets(0),
          reason: "Items list is closed after selection");
      expect(selectedNumber, expectedValue,
          reason: "Selected value corresponds to tapped item");
      expect(nothingSelectedFinder, findsNWidgets(0),
          reason: "Something selected");
      final valueSelectedFinder = find.descendant(
          of: clickableResultPlaceHolderFinder,
          matching: find.text(expectedValue.numberString));
      expect(valueSelectedFinder, findsNWidgets(1),
          reason: "Expected is selected");
      final clearButtonFinder = find.byIcon(Icons.clear);
      expect(clearButtonFinder, findsNWidgets(1), reason: "One clear icon");
      await tester.tap(clearButtonFinder);
      await tester.pump();
      expect(nothingSelectedFinder, findsNWidgets(1), reason: "No selection");
      expect(selectedNumber, null, reason: "selectedValue cleared");
    },
    skip: false,
  );

  testWidgets(
    'single dialog text no overflow because expanded',
    (WidgetTester tester) async {
      String searchKeyword = "at";
      String selectedValue;
      List<DropdownMenuItem> items = [
        DropdownMenuItem(
            child: Text(
                "way too long text for a smartphone at least one that goes in a normal sized pair of trousers"),
            value:
                "way too long text for a smartphone at least one that goes in a normal sized pair of trousers")
      ];
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Search Choices plugin test'),
          ),
          body: Center(
            child: SearchableDropdown.single(
              items: items,
              value: "",
              hint: "Select one number",
              searchHint: "Select one number",
              onChanged: (value) {
//              setState(() {
                selectedValue = value;
//              });
              },
              dialogBox: true,
              isExpanded: true,
            ),
          ),
        ),
      ));
      final clickableResultPlaceHolderFinder =
          find.byKey(Key("clickableResultPlaceHolder"));
      expect(clickableResultPlaceHolderFinder, findsNWidgets(1),
          reason: "Initial widget in place");
      final nothingSelectedFinder = find.descendant(
          of: clickableResultPlaceHolderFinder,
          matching: find.text("Select one number"));
      expect(nothingSelectedFinder, findsNWidgets(1), reason: "No selection");
      await tester.tap(nothingSelectedFinder);
      await tester.pump();
      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsNWidgets(1),
          reason: "List of items displayed");
      ListView listView = tester.element(listViewFinder).widget;
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsNWidgets(1),
          reason: "Search field displayed");
      expect(listView.semanticChildCount, items.length,
          reason: "List of items is complete");
      await tester.enterText(textFieldFinder, searchKeyword);
      await tester.pump();
      listView = tester.element(listViewFinder).widget;
      int expectedNbResults = items.where((it) {
        return (it.value.toString().contains(searchKeyword));
      }).length;
      expect(listView.semanticChildCount, expectedNbResults,
          reason: "Search filter number of items displayed");
      String expectedValue = items.firstWhere((it) {
        return (it.value.toString().contains(searchKeyword));
      }).value;
      final itemFinder = find.descendant(
          of: listViewFinder,
          matching: find.widgetWithText(DropdownMenuItem, expectedValue));
      expect(itemFinder, findsNWidgets(1),
          reason: "One item corresponds to search criteria");
      await tester.tap(itemFinder);
      await tester.pump();
      final dropDownDialogFinder = find.byType(DropdownDialog);
      expect(dropDownDialogFinder, findsNWidgets(0),
          reason: "Items list is closed after selection");
      expect(selectedValue, expectedValue,
          reason: "Selected value corresponds to tapped item");
      expect(nothingSelectedFinder, findsNWidgets(0),
          reason: "Something selected");
      final valueSelectedFinder = find.descendant(
          of: clickableResultPlaceHolderFinder,
          matching: find.text(expectedValue));
      expect(valueSelectedFinder, findsNWidgets(1),
          reason: "Expected is selected");
      final clearButtonFinder = find.byIcon(Icons.clear);
      expect(clearButtonFinder, findsNWidgets(1), reason: "One clear icon");
      await tester.tap(clearButtonFinder);
      await tester.pump();
      expect(nothingSelectedFinder, findsNWidgets(1), reason: "No selection");
      expect(selectedValue, null, reason: "selectedValue cleared");
    },
    skip: false,
  );

  testWidgets(
    'multi dialog open dialog, search keyword, select multiple values, clear',
    (WidgetTester tester) async {
      List<int> selectedItems = [];
      String searchKeyword = "4";
      List<DropdownMenuItem> items = [];
      for (int i = 0; i < 20; i++) {
        items.add(new DropdownMenuItem(
          child: new Text(
            'test ' + i.toString(),
          ),
          value: 'test ' + i.toString(),
        ));
      }
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Search Choices plugin test'),
          ),
          body: Center(
            child: SearchableDropdown.multiple(
              items: items,
              selectedItems: selectedItems,
              hint: new Text('Select any'),
              searchHint: new Text(
                'Search and select any',
                style: new TextStyle(fontSize: 20),
              ),
              onChanged: (value) {
                //              setState(() {
                selectedItems = value;
                //              });
              },
            ),
          ),
        ),
      ));
      final clickableResultPlaceHolderFinder =
          find.byKey(Key("clickableResultPlaceHolder"));
      expect(clickableResultPlaceHolderFinder, findsNWidgets(1),
          reason: "Initial widget in place");
      final nothingSelectedFinder = find.descendant(
          of: clickableResultPlaceHolderFinder,
          matching: find.text("Select any"));
      expect(nothingSelectedFinder, findsNWidgets(1), reason: "No selection");
      await tester.tap(nothingSelectedFinder);
      await tester.pump();
      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsNWidgets(1),
          reason: "List of items displayed");
      ListView listView = tester.element(listViewFinder).widget;
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsNWidgets(1),
          reason: "Search field displayed");
      expect(listView.semanticChildCount, items.length,
          reason: "List of items is complete");
      await tester.enterText(textFieldFinder, searchKeyword);
      await tester.pump();
      listView = tester.element(listViewFinder).widget;
      int expectedNbResults = items.where((it) {
        return (it.value.toString().contains(searchKeyword));
      }).length;
      expect(listView.semanticChildCount, expectedNbResults,
          reason: "Search filter number of items displayed");
      List<int> expectedList = [];
      for (int i = 0; i < items.length; i++) {
        var item = items[i];
        if (item.value.toString().contains(searchKeyword)) {
          expectedList.add(i);
          final itemFinder = find.descendant(
              of: listViewFinder,
              matching:
                  find.widgetWithText(DropdownMenuItem, item.value.toString()));
          expect(itemFinder, findsNWidgets(1),
              reason: "One item corresponds to search criteria");
          await tester.tap(itemFinder);
        }
      }
      await tester.pump();
      final doneButtonFinder = find.widgetWithText(FlatButton, "Close");
      expect(doneButtonFinder, findsNWidgets(1), reason: "Done button");
      await tester.tap(doneButtonFinder);
      await tester.pump();
      final dropDownDialogFinder = find.byType(DropdownDialog);
      expect(dropDownDialogFinder, findsNWidgets(0),
          reason: "Items list is closed after selection");
      expect(listEquals(selectedItems, expectedList), true,
          reason: "Selected values corresponds to tapped items");
      expect(nothingSelectedFinder, findsNWidgets(0),
          reason: "Something selected");
      expectedList.forEach((i) {
        final valueSelectedFinder = find.descendant(
            of: clickableResultPlaceHolderFinder,
            matching: find.text(items[i].value.toString()));
        expect(valueSelectedFinder, findsNWidgets(1),
            reason: "Expected is selected");
      });
      final clearButtonFinder = find.byIcon(Icons.clear);
      expect(clearButtonFinder, findsNWidgets(1), reason: "One clear icon");
      await tester.tap(clearButtonFinder);
      await tester.pump();
      expect(nothingSelectedFinder, findsNWidgets(1), reason: "No selection");
      expect(selectedItems?.length ?? 0, 0, reason: "selectedValue cleared");
    },
    skip: false,
  );
}
