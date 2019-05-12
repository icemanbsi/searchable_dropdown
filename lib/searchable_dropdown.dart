import 'package:flutter/material.dart';

const EdgeInsetsGeometry _kAlignedButtonPadding = EdgeInsetsDirectional.only(start: 16.0, end: 4.0);
const EdgeInsets _kUnalignedButtonPadding = EdgeInsets.zero;

class SearchableDropdown<T> extends StatefulWidget{
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T> onChanged;
  final T value;
  final TextStyle style;
  final Widget searchHint;
  final Widget hint;
  final Widget disabledHint;
  final Widget icon;
  final Widget underline;
  final Color iconEnabledColor;
  final Color iconDisabledColor;
  final double iconSize;
  final bool isExpanded;

  SearchableDropdown({
    Key key,
    @required this.items,
    @required this.onChanged,
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
  }) :  assert(items != null),
        assert(iconSize != null),
        assert(isExpanded != null),
        super(key: key);

  @override
  _SearchableDropdownState<T> createState() => new _SearchableDropdownState();

}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  TextStyle get _textStyle => widget.style ?? Theme.of(context).textTheme.subhead;
  bool get _enabled => widget.items != null && widget.items.isNotEmpty && widget.onChanged != null;
  int _selectedIndex;

  Icon defaultIcon = Icon(Icons.arrow_drop_down);

  Color get _iconColor {
    // These colors are not defined in the Material Design spec.
    if (_enabled) {
      if (widget.iconEnabledColor != null) {
        return widget.iconEnabledColor;
      }

      switch(Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade700;
        case Brightness.dark:
          return Colors.white70;
      }
    } else {
      if (widget.iconDisabledColor != null) {
        return widget.iconDisabledColor;
      }

      switch(Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade400;
        case Brightness.dark:
          return Colors.white10;
      }
    }

    assert(false);
    return null;
  }

  void _updateSelectedIndex() {
    if (!_enabled) {
      return;
    }

    assert(widget.value == null ||
        widget.items.where((DropdownMenuItem<T> item) => item.value == widget.value).length == 1);
    _selectedIndex = null;
    for (int itemIndex = 0; itemIndex < widget.items.length; itemIndex++) {
      if (widget.items[itemIndex].value == widget.value) {
        _selectedIndex = itemIndex;
        return;
      }
    }
  }

  @override
  void initState() {
    _updateSelectedIndex();
    super.initState();
  }

  @override
  void didUpdateWidget(SearchableDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSelectedIndex();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = _enabled ? List<Widget>.from(widget.items) : <Widget>[];
    int hintIndex;
    if (widget.hint != null || (!_enabled && widget.disabledHint != null)) {
      final Widget emplacedHint =
      _enabled ? widget.hint : DropdownMenuItem<Widget>(child: widget.disabledHint ?? widget.hint);
      hintIndex = items.length;
      items.add(DefaultTextStyle(
        style: _textStyle.copyWith(color: Theme.of(context).hintColor),
        child: IgnorePointer(
          child: emplacedHint,
          ignoringSemantics: false,
        ),
      ));
    }
    final int index = _enabled ? (_selectedIndex ?? hintIndex) : hintIndex;
    Widget innerItemsWidget;
    if (items.isEmpty) {
      innerItemsWidget = Container();
    } else {
      innerItemsWidget = IndexedStack(
        index: index,
        alignment: AlignmentDirectional.centerStart,
        children: items,
      );
    }
    final EdgeInsetsGeometry padding = ButtonTheme.of(context).alignedDropdown
        ? _kAlignedButtonPadding
        : _kUnalignedButtonPadding;

    Widget result = new InkWell(
      onTap: () async {
        T value = await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return new DropdownDialog(
                items: widget.items,
                hint: widget.searchHint,
              );
            }
        );
        if(widget.onChanged != null && value != null){
          widget.onChanged(value);
        }
      },
      child: DefaultTextStyle(
        style: _textStyle,
        child: Container(
          padding: padding.resolve(Directionality.of(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.isExpanded ? Expanded(child: innerItemsWidget) : innerItemsWidget,
              IconTheme(
                data: IconThemeData(
                  color: _iconColor,
                  size: widget.iconSize,
                ),
                child: widget.icon ?? defaultIcon,
              ),
            ],
          ),
        ),
      ),
    );

    final double bottom = 8.0;// widget.isDense ? 0.0 : 8.0;
    return new Stack(
      children: <Widget>[
        result,
        new Positioned(
          left: 0.0,
          right: 0.0,
          bottom: bottom,
          child: widget.underline ?? Container(
            height: 1.0,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFBDBDBD), width: 0.0))
            ),
          ),
        ),
      ],
    );
  }
}


class DropdownDialog<T> extends StatefulWidget {

  final List<DropdownMenuItem<T>> items;
  final Widget hint;

  DropdownDialog({
    Key key,
    this.items,
    this.hint
  }) :  assert(items != null),
        super(key: key);

  _DropdownDialogState createState() => new _DropdownDialogState();
}

class _DropdownDialogState extends State<DropdownDialog> {

  TextEditingController txtSearch = new TextEditingController();
  TextStyle defaultButtonStyle = new TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500
  );
  List<int> shownIndexes = [];

  void _updateShownIndexes(String keyword){
    shownIndexes.clear();
    int i = 0;
    widget.items.forEach((item) {
      if(keyword.isEmpty || item.value.toString().contains(keyword)){
        shownIndexes.add(i);
      }
      i++;
    });
  }

  @override
  void initState() {
    _updateShownIndexes('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 24
      ),
      child: new Container(
        padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            titleBar(),
            searchBar(),
            list(),
            buttonWrapper(),
          ],
        ),
      ),
    );
  }

  Widget titleBar() {
    return widget.hint != null
      ? new Container(
          margin: EdgeInsets.only(
              bottom: 8
          ),
          child: widget.hint,
        )
      : new Container();
  }

  Widget searchBar() {
    return new Container(
      child: new Stack(
        children: <Widget>[
          new TextField(
            controller: txtSearch,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12
                )
            ),
            autofocus: true,
            onChanged: (value) {
              _updateShownIndexes(value);
              setState(() {

              });
            },
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
                onTap: (){
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

  Widget list() {
    return new Expanded(
      child: new ListView.builder(
        itemBuilder: (context, index) {
          DropdownMenuItem item = widget.items[shownIndexes[index]];
          return new InkWell(
            onTap: (){
              Navigator.pop(context, item.value);
            },
            child: item,
          );
        },
        itemCount: shownIndexes.length,
      ),
    );
  }

  Widget buttonWrapper() {
    return new Container(
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: new Text(
                'Close',
                style: defaultButtonStyle
            ),
          )
        ],
      ),
    );
  }
}