library expandable_menu;

import 'dart:async';
import 'package:flutter/material.dart';
import 'expandable_icon.dart';

/// This class is main class of [ExpandableMenu] widget.
class ExpandableMenu extends StatefulWidget {
  /// This property declare width of widget when
  /// it's not expanded in initial state.
  final double width;

  /// This property declare height of widget.
  final double height;

  /// This property will contains items in list of menu.
  final List<Widget> items;

  /// This property declare background color of widget
  /// and default value is [Color(0xFF4B5042)].
  final Color backgroundColor;

  /// This property declare icon
  /// color of both icon(Arrow icon and Hamburger icon).
  final Color iconColor;

  /// This property declare item background color
  /// and if it's be null default value is [Colors.white.withOpacity(.4)]
  final Color? itemContainerColor;

  /// This property sets the main animation speed
  final int animationSpeed;

  /// This property sets a controller to the widget
  /// Makes it possible to eg close the menu by code
  final ExpandableMenuController? controller;

  const ExpandableMenu({
    super.key,
    this.width = 70.0,
    this.height = 70.0,
    this.animationSpeed = 800,
    required this.items,
    this.backgroundColor = const Color(0xFF4B5042),
    this.iconColor = Colors.white,
    this.itemContainerColor,
    this.controller
  });

  @override
  State<ExpandableMenu> createState() => ExpandableMenuState();
}

class ExpandableMenuState extends State<ExpandableMenu>
    with TickerProviderStateMixin {
  /// This private property declare to width of widget.
  late double _width;

  /// This private property declare for measure expanded state of widget.
  final _spacerKey = GlobalKey();

  /// This private property declare list widget.
  double _listWidth = 0;

  /// This private property declare list items size.
  /// Every item size computed with [itemSize] method
  late double _listItemSize;

  /// This private property declare items in widgets.
  List<Widget> _listWidget = <Widget>[];

  /// This private property declare expand status of widget.
  /// If [_isExpanded] equals true it's meaning widget is expanded and
  /// if [_isExpanded] equals false it's meaning widget is not expanded.
  bool _isExpanded = false;

  /// This private property declare main container animation
  late Animation<double> _containerAnimation;

  /// This private property declare main container animation controller
  late AnimationController _containerAnimationController;

  /// This private property declare main container animation progress value.
  double _containerProgress = 0.0;

  /// This private property declare list timer for build every 60 millisecond [buildContainer].
  Timer? _listTimer;

  /// This private property is for controlling icons animation
  final ExpandableIconController _iconController = ExpandableIconController();

  @override
  void initState() {
    //Set state controller if set
    if(widget.controller!=null)
      {
          widget.controller!.setControllerState(this, _iconController);
      }

    _width = widget.width;
    _containerAnimationController = AnimationController(
      duration: Duration(milliseconds: widget.animationSpeed),
      vsync: this,
    );

    final Animation<double> containerCurve = CurvedAnimation(
      parent: _containerAnimationController,
      curve: Curves.fastLinearToSlowEaseIn,
    );
    _containerAnimation = Tween(begin: 0.0, end: 1.0).animate(containerCurve)
      ..addListener(() {
        setState(() {
          _containerProgress = _containerAnimation.value;
          if (!_isExpanded && _containerProgress == 0.0) {
            _listWidget = [];
          }
        });
      });

    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      _width = _width + _spacerKey.currentContext!.size!.width;
      _listWidth = _width - widget.width;
      _listItemSize = itemSize();
    });
  }

  @override
  void dispose() {
    _containerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(
          key: _spacerKey,
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          width: _width * _containerProgress,
          constraints:
              BoxConstraints(minWidth: widget.width, minHeight: widget.height),
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.width >= widget.height
                      ? widget.width
                      : widget.height))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: widget.width * .15,
              ),
              ExpandableIcon(
                width: widget.width,
                height: widget.height,
                iconColor: widget.iconColor,
                animationSpeed: widget.animationSpeed,
                controller: _iconController,
                onClicked: () {
                  onExpandableIconClicked();
                },
              ),
              SizedBox(
                width: _containerProgress < 0.9
                    ? 0
                    : _listWidth * _containerProgress,
                height: widget.height,
                child: Directionality(
                  textDirection: Directionality.of(context),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _listWidget,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// This method invoke when clicked on arrow icon or hamburger icon.
  /// In [onExpandableIconClicked] method container animation will run.
  void onExpandableIconClicked() {
    _isExpanded = !_isExpanded;
    setState(() {
      if (_isExpanded) {
        _containerAnimationController.forward();
        if (_listWidget.isEmpty) {
          Timer.periodic(const Duration(milliseconds: 60), (timer) {
            _listTimer = timer;
            final allWidgets = widget.items;
            if (_listWidget.length < allWidgets.length) {
              if (_listWidget.isEmpty) {
                final item = widget.items[0];
                _listWidget.add(buildContainer(child: item));
              } else {
                final item = widget.items[_listWidget.length];
                _listWidget.add(buildContainer(child: item));
                if (_listWidget.length == widget.items.length) {
                  timer.cancel();
                }
              }
            }
          });
        }
      } else {
        _containerAnimationController.reverse();
        _listTimer?.cancel();
      }
    });
  }

  /// This method build menu items containers
  Widget buildContainer({required Widget child}) {
    return Center(
      child: Container(
        width: _listItemSize,
        height: _listItemSize,
        decoration: BoxDecoration(
            color: widget.itemContainerColor ?? Colors.white.withOpacity(.4),
            borderRadius: BorderRadius.all(Radius.circular(widget.height))),
        margin: const EdgeInsets.all(4.0),
        child: child,
      ),
    );
  }

  /// This method will return size of item.
  double itemSize() => widget.height * .75;

}

/// Controller [ExpandableMenuController] makes it possible to toggle states
class ExpandableMenuController
{
  ExpandableMenuState? _state;
  ExpandableIconController? _stateIcon;

  /// Sets states for the icon and menu to current controller
  void setControllerState(ExpandableMenuState state, ExpandableIconController stateIcon)
  {
    _state = state;
    _stateIcon = stateIcon;
  }

  /// Activate toggle if we are expand
  void open()
  {
    if(_state!=null)
      {
        if(!_state!._isExpanded) _stateIcon?.toggle();
      }
  }

  /// Activate toggle if we are not expand
  void close()
  {
    if(_state!=null)
    {
      if(_state!._isExpanded) _stateIcon?.toggle();
    }
  }

  /// Toggle between expand or not
  void toggle()
  {
    _stateIcon?.toggle();
  }
}
