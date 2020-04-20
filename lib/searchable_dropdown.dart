import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const EdgeInsetsGeometry _kAlignedButtonPadding =
    EdgeInsetsDirectional.only(start: 16.0, end: 4.0);
const EdgeInsets _kUnalignedButtonPadding = EdgeInsets.zero;

class NotGiven {
  const NotGiven();
}

class PointerThisPlease<T> {
  T value;
  PointerThisPlease(this.value);
}

Widget prepareWidget(dynamic object,
    {dynamic parameter = const NotGiven(),
    BuildContext context,
    Function stringToWidgetFunction}) {
  if (object == null) {
    return (null);
  }
  if (object is Widget) {
    return (object);
  }
  if (object is String) {
    if (stringToWidgetFunction == null) {
      return (Text(object));
    } else {
      return (stringToWidgetFunction(object));
    }
  }
  if (object is Function) {
    if (parameter is NotGiven) {
      if (context == null) {
        return (prepareWidget(object(),
            stringToWidgetFunction: stringToWidgetFunction));
      } else {
        return (prepareWidget(object(context),
            stringToWidgetFunction: stringToWidgetFunction));
      }
    }
    if (context == null) {
      return (prepareWidget(object(parameter),
          stringToWidgetFunction: stringToWidgetFunction));
    }
    return (prepareWidget(object(parameter, context),
        stringToWidgetFunction: stringToWidgetFunction));
  }
  return (Text("Unknown type: ${object.runtimeType.toString()}"));
}

class SearchableDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final Function onChanged;
  final T value;
  final TextStyle style;
  final dynamic searchHint;
  final dynamic hint;
  final dynamic disabledHint;
  final dynamic icon;
  final dynamic underline;
  final dynamic doneButton;
  final dynamic label;
  final dynamic closeButton;
  final bool displayClearIcon;
  final Icon clearIcon;
  final Color iconEnabledColor;
  final Color iconDisabledColor;
  final double iconSize;
  final bool isExpanded;
  final bool isCaseSensitiveSearch;
  final Function searchFn;
  final Function onClear;
  final Function selectedValueWidgetFn;
  final TextInputType keyboardType;
  final Function validator;
  final bool multipleSelection;
  final List<int> selectedItems;
  final Function displayItem;
  final bool dialogBox;
  final BoxConstraints menuConstraints;
  final bool readOnly;
  final Color menuBackgroundColor;

  /// Search choices Widget with a single choice that opens a dialog or a menu to let the user do the selection conveniently with a search.
  ///
  /// @param items with __child__: [Widget] displayed ; __value__: any object with .toString() used to match search keyword.
  /// @param onChanged [Function] with parameter: __value__ not returning executed after the selection is done.
  /// @param value value to be preselected.
  /// @param style used for the hint if it is given is [String].
  /// @param searchHint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed at the top of the search dialog box.
  /// @param hint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed before any value is selected or after the selection is cleared.
  /// @param disabledHint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed instead of hint when the widget is displayed.
  /// @param icon [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed next to the selected item or the hint if none.
  /// @param underline [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed below the selected item or the hint if none.
  /// @param doneButton [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed at the top of the search dialog box.
  /// @param label [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed above the selected item or the hint if none.
  /// @param closeButton [String]|[Widget]|[Function] with parameter: __value__ returning [String]|[Widget] displayed at the bottom of the search dialog box.
  /// @param displayClearIcon whether or not to display an icon to clear the selected value.
  /// @param clearIcon [Icon] to be used for clearing the selected value.
  /// @param iconEnabledColor [Color] to be used for enabled icons.
  /// @param iconDisabledColor [Color] to be used for disabled icons.
  /// @param iconSize for the icons next to the selected value (icon and clearIcon).
  /// @param isExpanded can be necessary to avoid pixel overflows (zebra symptom).
  /// @param isCaseSensitiveSearch only used when searchFn is not specified.
  /// @param searchFn [Function] with parameters: __keyword__, __items__ returning [List<int>] as the list of indexes for the items to be displayed.
  /// @param onClear [Function] with no parameter not returning executed when the clear icon is tapped.
  /// @param selectedValueWidgetFn [Function] with parameter: __item__ returning [Widget] to be used to display the selected value.
  /// @param keyboardType used for the search.
  /// @param validator [Function] with parameter: __value__ returning [String] displayed below selected value when not valid and null when valid.
  /// @param assertUniqueValue whether to run a consistency check of the list of items.
  /// @param displayItem [Function] with parameters: __item__, __selected__ returning [Widget] to be displayed in the search list.
  /// @param dialogBox whether the search should be displayed as a dialog box or as a menu below the selected value if any.
  /// @param menuConstraints [BoxConstraints] used to define the zone where to display the search menu. Example: BoxConstraints.tight(Size.fromHeight(250)) . Not to be used for dialogBox = true.
  /// @param readOnly [bool] whether to let the user choose the value to select or just present the selected value if any.
  /// @param menuBackgroundColor [Color] background color of the menu whether in dialog box or menu mode.
  factory SearchableDropdown.single({
    Key key,
    @required List<DropdownMenuItem<T>> items,
    @required Function onChanged,
    T value,
    TextStyle style,
    dynamic searchHint,
    dynamic hint,
    dynamic disabledHint,
    dynamic icon = const Icon(Icons.arrow_drop_down),
    dynamic underline,
    dynamic doneButton,
    dynamic label,
    dynamic closeButton = "Close",
    bool displayClearIcon = true,
    Icon clearIcon = const Icon(Icons.clear),
    Color iconEnabledColor,
    Color iconDisabledColor,
    double iconSize = 24.0,
    bool isExpanded = false,
    bool isCaseSensitiveSearch = false,
    Function searchFn,
    Function onClear,
    Function selectedValueWidgetFn,
    TextInputType keyboardType = TextInputType.text,
    Function validator,
    bool assertUniqueValue = true,
    Function displayItem,
    bool dialogBox = true,
    BoxConstraints menuConstraints,
    bool readOnly = false,
    Color menuBackgroundColor,
  }) {
    return (SearchableDropdown._(
      key: key,
      items: items,
      onChanged: onChanged,
      value: value,
      style: style,
      searchHint: searchHint,
      hint: hint,
      disabledHint: disabledHint,
      icon: icon,
      underline: underline,
      iconEnabledColor: iconEnabledColor,
      iconDisabledColor: iconDisabledColor,
      iconSize: iconSize,
      isExpanded: isExpanded,
      isCaseSensitiveSearch: isCaseSensitiveSearch,
      closeButton: closeButton,
      displayClearIcon: displayClearIcon,
      clearIcon: clearIcon,
      onClear: onClear,
      selectedValueWidgetFn: selectedValueWidgetFn,
      keyboardType: keyboardType,
      validator: validator,
      label: label,
      searchFn: searchFn,
      multipleSelection: false,
      doneButton: doneButton,
      displayItem: displayItem,
      dialogBox: dialogBox,
      menuConstraints: menuConstraints,
      readOnly: readOnly,
      menuBackgroundColor: menuBackgroundColor,
    ));
  }

  /// Search choices Widget with a multiple choice that opens a dialog or a menu to let the user do the selection conveniently with a search.
  ///
  /// @param items with __child__: [Widget] displayed ; __value__: any object with .toString() used to match search keyword.
  /// @param onChanged [Function] with parameter: __selectedItems__ not returning executed after the selection is done.
  /// @param selectedItems indexes of items to be preselected.
  /// @param style used for the hint if it is given is [String].
  /// @param searchHint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed at the top of the search dialog box.
  /// @param hint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed before any value is selected or after the selection is cleared.
  /// @param disabledHint [String]|[Widget]|[Function] with no parameter returning [String]|[Widget] displayed instead of hint when the widget is displayed.
  /// @param icon [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed next to the selected items or the hint if none.
  /// @param underline [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed below the selected items or the hint if none.
  /// @param doneButton [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed at the top of the search dialog box. Cannot be null in multiple selection mode.
  /// @param label [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed above the selected items or the hint if none.
  /// @param closeButton [String]|[Widget]|[Function] with parameter: __selectedItems__ returning [String]|[Widget] displayed at the bottom of the search dialog box.
  /// @param displayClearIcon whether or not to display an icon to clear the selected values.
  /// @param clearIcon [Icon] to be used for clearing the selected values.
  /// @param iconEnabledColor [Color] to be used for enabled icons.
  /// @param iconDisabledColor [Color] to be used for disabled icons.
  /// @param iconSize for the icons next to the selected values (icon and clearIcon).
  /// @param isExpanded can be necessary to avoid pixel overflows (zebra symptom).
  /// @param isCaseSensitiveSearch only used when searchFn is not specified.
  /// @param searchFn [Function] with parameters: __keyword__, __items__ returning [List<int>] as the list of indexes for the items to be displayed.
  /// @param onClear [Function] with no parameter not returning executed when the clear icon is tapped.
  /// @param selectedValueWidgetFn [Function] with parameter: __item__ returning [Widget] to be used to display the selected values.
  /// @param keyboardType used for the search.
  /// @param validator [Function] with parameter: __selectedItems__ returning [String] displayed below selected values when not valid and null when valid.
  /// @param displayItem [Function] with parameters: __item__, __selected__ returning [Widget] to be displayed in the search list.
  /// @param dialogBox whether the search should be displayed as a dialog box or as a menu below the selected values if any.
  /// @param menuConstraints [BoxConstraints] used to define the zone where to display the search menu. Example: BoxConstraints.tight(Size.fromHeight(250)) . Not to be used for dialogBox = true.
  /// @param readOnly [bool] whether to let the user choose the value to select or just present the selected value if any.
  /// @param menuBackgroundColor [Color] background color of the menu whether in dialog box or menu mode.
  factory SearchableDropdown.multiple({
    Key key,
    @required List<DropdownMenuItem<T>> items,
    @required Function onChanged,
    List<int> selectedItems = const [],
    TextStyle style,
    dynamic searchHint,
    dynamic hint,
    dynamic disabledHint,
    dynamic icon = const Icon(Icons.arrow_drop_down),
    dynamic underline,
    dynamic doneButton = "Done",
    dynamic label,
    dynamic closeButton = "Close",
    bool displayClearIcon = true,
    Icon clearIcon = const Icon(Icons.clear),
    Color iconEnabledColor,
    Color iconDisabledColor,
    double iconSize = 24.0,
    bool isExpanded = false,
    bool isCaseSensitiveSearch = false,
    Function searchFn,
    Function onClear,
    Function selectedValueWidgetFn,
    TextInputType keyboardType = TextInputType.text,
    Function validator,
    Function displayItem,
    bool dialogBox = true,
    BoxConstraints menuConstraints,
    bool readOnly = false,
    Color menuBackgroundColor,
  }) {
    return (SearchableDropdown._(
      key: key,
      items: items,
      style: style,
      searchHint: searchHint,
      hint: hint,
      disabledHint: disabledHint,
      icon: icon,
      underline: underline,
      iconEnabledColor: iconEnabledColor,
      iconDisabledColor: iconDisabledColor,
      iconSize: iconSize,
      isExpanded: isExpanded,
      isCaseSensitiveSearch: isCaseSensitiveSearch,
      closeButton: closeButton,
      displayClearIcon: displayClearIcon,
      clearIcon: clearIcon,
      onClear: onClear,
      selectedValueWidgetFn: selectedValueWidgetFn,
      keyboardType: keyboardType,
      validator: validator,
      label: label,
      searchFn: searchFn,
      multipleSelection: true,
      selectedItems: selectedItems,
      doneButton: doneButton,
      onChanged: onChanged,
      displayItem: displayItem,
      dialogBox: dialogBox,
      menuConstraints: menuConstraints,
      readOnly: readOnly,
      menuBackgroundColor: menuBackgroundColor,
    ));
  }

  SearchableDropdown._({
    Key key,
    @required this.items,
    this.onChanged,
    this.value,
    this.style,
    this.searchHint,
    this.hint,
    this.disabledHint,
    this.icon,
    this.underline,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.iconSize = 24.0,
    this.isExpanded = false,
    this.isCaseSensitiveSearch = false,
    this.closeButton,
    this.displayClearIcon = true,
    this.clearIcon = const Icon(Icons.clear),
    this.onClear,
    this.selectedValueWidgetFn,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.label,
    this.searchFn,
    this.multipleSelection = false,
    this.selectedItems = const [],
    this.doneButton,
    this.displayItem,
    this.dialogBox,
    this.menuConstraints,
    this.readOnly = false,
    this.menuBackgroundColor,
  })  : assert(items != null),
        assert(iconSize != null),
        assert(isExpanded != null),
        assert(!multipleSelection || doneButton != null),
        assert(menuConstraints == null || !dialogBox),
        super(key: key);

  SearchableDropdown({
    Key key,
    @required this.items,
    @required this.onChanged,
    this.value,
    this.style,
    this.searchHint,
    this.hint,
    this.disabledHint,
    this.icon = const Icon(Icons.arrow_drop_down),
    this.underline,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.iconSize = 24.0,
    this.isExpanded = false,
    this.isCaseSensitiveSearch = false,
    this.closeButton = "Close",
    this.displayClearIcon = false,
    this.clearIcon = const Icon(Icons.clear),
    this.onClear,
    this.selectedValueWidgetFn,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.label,
    this.searchFn,
    this.multipleSelection = false,
    this.selectedItems = const [],
    this.doneButton,
    this.displayItem,
    this.dialogBox = true,
    this.menuConstraints,
    this.readOnly = false,
    this.menuBackgroundColor,
  })  : assert(items != null),
        assert(iconSize != null),
        assert(isExpanded != null),
        assert(!multipleSelection || doneButton != null),
        assert(menuConstraints == null || !dialogBox),
        super(key: key);

  @override
  _SearchableDropdownState<T> createState() => new _SearchableDropdownState();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  List<int> selectedItems;
  PointerThisPlease<bool> displayMenu = PointerThisPlease<bool>(false);

  TextStyle get _textStyle =>
      widget.style ??
      (_enabled && !(widget.readOnly ?? false)
          ? Theme.of(context).textTheme.subhead
          : Theme.of(context)
              .textTheme
              .subhead
              .copyWith(color: _disabledIconColor));
  bool get _enabled =>
      widget.items != null &&
      widget.items.isNotEmpty &&
      widget.onChanged != null;

  Color get _enabledIconColor {
    if (widget.iconEnabledColor != null) {
      return widget.iconEnabledColor;
    }
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return Colors.grey.shade700;
      case Brightness.dark:
        return Colors.white70;
    }
    return Colors.grey.shade700;
  }

  Color get _disabledIconColor {
    if (widget.iconDisabledColor != null) {
      return widget.iconDisabledColor;
    }
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return Colors.grey.shade400;
      case Brightness.dark:
        return Colors.white10;
    }
    return Colors.grey.shade400;
  }

  Color get _iconColor {
    // These colors are not defined in the Material Design spec.
    return (_enabled && !(widget.readOnly ?? false)
        ? _enabledIconColor
        : _disabledIconColor);
  }

  bool get valid {
    if (widget.validator == null) {
      return (true);
    }
    return (widget.validator(selectedResult) == null);
  }

  bool get hasSelection {
    return (selectedItems != null && selectedItems.isNotEmpty);
  }

  dynamic get selectedResult {
    return (widget.multipleSelection
        ? selectedItems
        : selectedItems?.isNotEmpty ?? false
            ? widget.items[selectedItems.first]?.value
            : null);
  }

  int indexFromValue(T value) {
    return (widget.items.indexWhere((item) {
      return (item.value == value);
    }));
  }

  @override
  void initState() {
    _updateSelectedIndex();
    super.initState();
  }

  void _updateSelectedIndex() {
    if (!_enabled) {
      return;
    }
    if (widget.multipleSelection) {
      selectedItems = List<int>.from(widget.selectedItems ?? []);
    } else if (widget.value != null) {
      int i = indexFromValue(widget.value);
      if (i != null && i != -1) {
        selectedItems = [i];
      }
    }
    if (selectedItems == null) selectedItems = [];
  }

  @override
  void didUpdateWidget(SearchableDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSelectedIndex();
  }

  Widget get menuWidget {
    return (DropdownDialog(
      items: widget.items,
      hint: prepareWidget(widget.searchHint),
      isCaseSensitiveSearch: widget.isCaseSensitiveSearch,
      closeButton: widget.closeButton,
      keyboardType: widget.keyboardType,
      searchFn: widget.searchFn,
      multipleSelection: widget.multipleSelection,
      selectedItems: selectedItems,
      doneButton: widget.doneButton,
      displayItem: widget.displayItem,
      validator: widget.validator,
      dialogBox: widget.dialogBox,
      displayMenu: displayMenu,
      menuConstraints: widget.menuConstraints,
      menuBackgroundColor: widget.menuBackgroundColor,
      callOnPop: () {
        if (!widget.dialogBox &&
            widget.onChanged != null &&
            selectedItems != null) {
          widget.onChanged(selectedResult);
        }
        setState(() {});
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items =
        _enabled ? List<Widget>.from(widget.items) : <Widget>[];
    int hintIndex;
    if (widget.hint != null ||
        (!_enabled && prepareWidget(widget.disabledHint) != null)) {
      final Widget emplacedHint = _enabled
          ? prepareWidget(widget.hint)
          : DropdownMenuItem<Widget>(
              child: prepareWidget(widget.disabledHint) ??
                  prepareWidget(widget.hint));
      hintIndex = items.length;
      items.add(DefaultTextStyle(
        style: _textStyle.copyWith(color: Theme.of(context).hintColor),
        child: IgnorePointer(
          child: emplacedHint,
          ignoringSemantics: false,
        ),
      ));
    }
    Widget innerItemsWidget;
    List<Widget> list = List<Widget>();
    selectedItems?.forEach((item) {
      list.add(widget.selectedValueWidgetFn != null
          ? widget.selectedValueWidgetFn(widget.items[item].value)
          : items[item]);
    });
    if (list.isEmpty && hintIndex != null) {
      innerItemsWidget = items[hintIndex];
    } else {
      innerItemsWidget = Column(
        children: list,
      );
    }
    final EdgeInsetsGeometry padding = ButtonTheme.of(context).alignedDropdown
        ? _kAlignedButtonPadding
        : _kUnalignedButtonPadding;

    Widget clickable = InkWell(
        key: Key(
            "clickableResultPlaceHolder"), //this key is used for running automated tests
        onTap: (widget.readOnly ?? false) || !_enabled
            ? null
            : () async {
                if (widget.dialogBox) {
                  await showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return (menuWidget);
                      });
                  if (widget.onChanged != null && selectedItems != null) {
                    widget.onChanged(selectedResult);
                  }
                } else {
                  displayMenu.value = true;
                }
                setState(() {});
              },
        child: Row(
          children: <Widget>[
            widget.isExpanded
                ? Expanded(child: innerItemsWidget)
                : innerItemsWidget,
            IconTheme(
              data: IconThemeData(
                color: _iconColor,
                size: widget.iconSize,
              ),
              child: prepareWidget(widget.icon, parameter: selectedResult) ??
                  SizedBox.shrink(),
            ),
          ],
        ));

    Widget result = DefaultTextStyle(
      style: _textStyle,
      child: Container(
        padding: padding.resolve(Directionality.of(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.isExpanded ? Expanded(child: clickable) : clickable,
            !widget.displayClearIcon
                ? SizedBox()
                : InkWell(
                    onTap: hasSelection && _enabled && !widget.readOnly
                        ? () {
                            clearSelection();
                          }
                        : null,
                    child: Container(
                      padding: padding.resolve(Directionality.of(context)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconTheme(
                            data: IconThemeData(
                              color:
                                  hasSelection && _enabled && !widget.readOnly
                                      ? _enabledIconColor
                                      : _disabledIconColor,
                              size: widget.iconSize,
                            ),
                            child: widget.clearIcon ?? Icon(Icons.clear),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );

    final double bottom = 8.0;
    var validatorOutput;
    if (widget.validator != null) {
      validatorOutput = widget.validator(selectedResult);
    }
    var labelOutput = prepareWidget(widget.label, parameter: selectedResult,
        stringToWidgetFunction: (string) {
      return (Text(string,
          style: TextStyle(color: Colors.blueAccent, fontSize: 13)));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        labelOutput ?? SizedBox.shrink(),
        Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: result,
            ),
            widget.underline is NotGiven
                ? SizedBox.shrink()
                : Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: bottom,
                    child: prepareWidget(widget.underline,
                            parameter: selectedResult) ??
                        Container(
                          height: 1.0,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: valid
                                          ? Color(0xFFBDBDBD)
                                          : Colors.red,
                                      width: 0.0))),
                        ),
                  ),
          ],
        ),
        valid
            ? SizedBox.shrink()
            : validatorOutput is String
                ? Text(
                    validatorOutput,
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  )
                : validatorOutput,
        displayMenu.value ? menuWidget : SizedBox.shrink(),
      ],
    );
  }

  clearSelection() {
    selectedItems.clear();
    if (widget.onChanged != null) {
      widget.onChanged(selectedResult);
    }
    if (widget.onClear != null) {
      widget.onClear();
    }
    setState(() {});
  }
}

class DropdownDialog<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final Widget hint;
  final bool isCaseSensitiveSearch;
  final dynamic closeButton;
  final TextInputType keyboardType;
  final Function searchFn;
  final bool multipleSelection;
  final List<int> selectedItems;
  final Function displayItem;
  final dynamic doneButton;
  final Function validator;
  final bool dialogBox;
  final PointerThisPlease<bool> displayMenu;
  final BoxConstraints menuConstraints;
  final Function callOnPop;
  final Color menuBackgroundColor;

  DropdownDialog({
    Key key,
    this.items,
    this.hint,
    this.isCaseSensitiveSearch = false,
    this.closeButton,
    this.keyboardType,
    this.searchFn,
    this.multipleSelection,
    this.selectedItems,
    this.displayItem,
    this.doneButton,
    this.validator,
    this.dialogBox,
    this.displayMenu,
    this.menuConstraints,
    this.callOnPop,
    this.menuBackgroundColor,
  })  : assert(items != null),
        super(key: key);

  _DropdownDialogState<T> createState() => new _DropdownDialogState<T>();
}

class _DropdownDialogState<T> extends State<DropdownDialog> {
  TextEditingController txtSearch = new TextEditingController();
  TextStyle defaultButtonStyle =
      new TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  List<int> shownIndexes = [];
  Function searchFn;

  _DropdownDialogState();

  dynamic get selectedResult {
    return (widget.multipleSelection
        ? widget.selectedItems
        : widget.selectedItems?.isNotEmpty ?? false
            ? widget.items[widget.selectedItems.first]?.value
            : null);
  }

  void _updateShownIndexes(String keyword) {
    shownIndexes = searchFn(keyword, widget.items);
  }

  @override
  void initState() {
    if (widget.searchFn != null) {
      searchFn = widget.searchFn;
    } else {
      Function matchFn;
      if (widget.isCaseSensitiveSearch) {
        matchFn = (item, keyword) {
          return (item.value.toString().contains(keyword));
        };
      } else {
        matchFn = (item, keyword) {
          return (item.value
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()));
        };
      }
      searchFn = (keyword, items) {
        List<int> shownIndexes = [];
        int i = 0;
        widget.items.forEach((item) {
          if (matchFn(item, keyword) || (keyword?.isEmpty ?? true)) {
            shownIndexes.add(i);
          }
          i++;
        });
        return (shownIndexes);
      };
    }
    assert(searchFn != null);
    _updateShownIndexes('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 300),
      child: new Card(
        color: widget.menuBackgroundColor,
        margin: EdgeInsets.symmetric(
            vertical: widget.dialogBox ? 10 : 5,
            horizontal: widget.dialogBox ? 10 : 4),
        child: new Container(
          constraints: widget.menuConstraints,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              titleBar(),
              searchBar(),
              list(),
              closeButtonWrapper(),
            ],
          ),
        ),
      ),
    );
  }

  bool get valid {
    if (widget.validator == null) {
      return (true);
    }
    return (widget.validator(selectedResult) == null);
  }

  Widget titleBar() {
    var validatorOutput;
    if (widget.validator != null) {
      validatorOutput = widget.validator(selectedResult);
    }

    Widget validatorOutputWidget = valid
        ? SizedBox.shrink()
        : validatorOutput is String
            ? Text(
                validatorOutput,
                style: TextStyle(color: Colors.red, fontSize: 13),
              )
            : validatorOutput;

    Widget doneButtonWidget =
        widget.multipleSelection || widget.doneButton != null
            ? prepareWidget(widget.doneButton,
                parameter: selectedResult,
                context: context, stringToWidgetFunction: (string) {
                return (FlatButton.icon(
                    onPressed: !valid
                        ? null
                        : () {
                            pop();
                            setState(() {});
                          },
                    icon: Icon(Icons.close),
                    label: Text(string)));
              })
            : SizedBox.shrink();
    return widget.hint != null
        ? new Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  prepareWidget(widget.hint),
                  Column(
                    children: <Widget>[doneButtonWidget, validatorOutputWidget],
                  ),
                ]),
          )
        : new Container(
            child: Column(
              children: <Widget>[doneButtonWidget, validatorOutputWidget],
            ),
          );
  }

  Widget searchBar() {
    return new Container(
      child: new Stack(
        children: <Widget>[
          new TextField(
            controller: txtSearch,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
            autofocus: true,
            onChanged: (value) {
              _updateShownIndexes(value);
              setState(() {});
            },
            keyboardType: widget.keyboardType,
          ),
          new Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: new Center(
              child: new Icon(
                Icons.search,
                size: 24,
              ),
            ),
          ),
          txtSearch.text.isNotEmpty
              ? new Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: new Center(
                    child: new InkWell(
                      onTap: () {
                        _updateShownIndexes('');
                        setState(() {
                          txtSearch.text = '';
                        });
                      },
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      child: new Container(
                        width: 32,
                        height: 32,
                        child: new Center(
                          child: new Icon(
                            Icons.close,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : new Container(),
        ],
      ),
    );
  }

  pop() {
    if (widget.dialogBox) {
      Navigator.pop(context);
    } else {
      widget.displayMenu.value = false;
      if (widget.callOnPop != null) {
        widget.callOnPop();
      }
    }
  }

  Widget list() {
    return new Expanded(
      child: Scrollbar(
        child: new ListView.builder(
          itemBuilder: (context, index) {
            DropdownMenuItem item = widget.items[shownIndexes[index]];
            return new InkWell(
              onTap: () {
                if (widget.multipleSelection) {
                  setState(() {
                    if (widget.selectedItems.contains(shownIndexes[index])) {
                      widget.selectedItems.remove(shownIndexes[index]);
                    } else {
                      widget.selectedItems.add(shownIndexes[index]);
                    }
                  });
                } else {
                  widget.selectedItems.clear();
                  widget.selectedItems.add(shownIndexes[index]);
                  if (widget.doneButton == null) {
                    pop();
                  } else {
                    setState(() {});
                  }
                }
              },
              child: widget.multipleSelection
                  ? widget.displayItem == null
                      ? (Row(children: [
                          Icon(
                            widget.selectedItems.contains(shownIndexes[index])
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Flexible(child: item),
                        ]))
                      : widget.displayItem(item,
                          widget.selectedItems.contains(shownIndexes[index]))
                  : widget.displayItem == null
                      ? item
                      : widget.displayItem(item, item.value == selectedResult),
            );
          },
          itemCount: shownIndexes.length,
        ),
      ),
    );
  }

  Widget closeButtonWrapper() {
    return (prepareWidget(widget.closeButton, parameter: selectedResult,
            stringToWidgetFunction: (string) {
          return (Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    pop();
                  },
                  child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2),
                      child: Text(
                        string,
                        style: defaultButtonStyle,
                        overflow: TextOverflow.ellipsis,
                      )),
                )
              ],
            ),
          ));
        }) ??
        SizedBox.shrink());
  }
}
