import 'package:flutter/material.dart';

class ListExpandableWidget extends StatefulWidget {
  final bool isExpanded;
  final Widget header;
  final List<ListTile> items;
  final Widget expandedIcon;
  final Widget collapsedIcon;

  ListExpandableWidget(
      {Key key,
      this.isExpanded = false,
      @required this.header,
      @required this.items,
      this.expandedIcon,
      this.collapsedIcon})
      : super(key: key);

  @override
  _ListExpandableWidgetState createState() => _ListExpandableWidgetState();
}

class _ListExpandableWidgetState extends State<ListExpandableWidget> {
  bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _updateExpandState(widget.isExpanded);
  }

  void _updateExpandState(bool isExpanded) =>
      setState(() => _isExpanded = isExpanded);

  @override
  Widget build(BuildContext context) {
    return _isExpanded ? _buildListItems(context) : _wrapHeader();
  }

  Widget _wrapHeader() {
    List<Widget> children = [];
    if (!widget.isExpanded) {
      children.add(Divider());
    }
    children.add(ListTile(
      title: widget.header,
      trailing: _isExpanded
          ? widget.expandedIcon ?? Icon(Icons.keyboard_arrow_down)
          : widget.collapsedIcon ?? Icon(Icons.keyboard_arrow_right),
      onTap: () => _updateExpandState(!_isExpanded),
    ));
    return Ink(
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildListItems(BuildContext context) {
    List<Widget> titles = [];
    titles.add(_wrapHeader());
    titles.addAll(widget.items);
    return Column(
      children: ListTile.divideTiles(tiles: titles, context: context).toList(),
    );
  }
}
