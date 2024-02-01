import 'package:flutter/material.dart';

/// [ExpandableIcon] is icon of [ExpandableMenu] widget.
/// This widget when users clicked on widget will change icon
/// from an hamburger icon to arrow icon.
/// When user clicks on menu icon widgets will invoke onClick function.
class ExpandableIcon extends StatefulWidget {
  /// This Function invoke when user clicked on
  /// arrow icon(When menu is expanded) or
  /// hamburger icon(when menu is not expanded).
  final Function onClicked;

  /// This property is width of widget when widget is expanded.
  final double width;

  /// This property is height of widget.
  final double height;

  /// This property is color of icon(Hamburger icon and arrow icon).
  final Color iconColor;

  /// This property makes it possible to controll the [ExpandableIcon]
  final ExpandableIconController? controller;

  /// This property sets the main animationspeed
  final int animationSpeed;

  const ExpandableIcon({
    super.key,
    required this.onClicked,
    required this.width,
    required this.height,
    required this.iconColor,
    this.animationSpeed = 500,
    this.controller,
  });

  @override
  State<ExpandableIcon> createState() => ExpandableIconState();
}

class ExpandableIconState extends State<ExpandableIcon>
    with TickerProviderStateMixin {
  /// This private property declare hamburger animation progress value.
  double _hamburgerProgress = 0.0;

  /// This private property declare hamburger animation.
  late Animation<double> _hamburgerAnimation;

  /// This private property declare hamburger controller.
  late AnimationController _hamburgerAnimationController;

  /// This private property declare arrow animation progress value.
  double _arrowProgress = 0.0;

  /// This private property declare arrow animation.
  late Animation<double> _arrowAnimation;

  /// This private property declare arrow controller.
  late AnimationController _arrowAnimationController;

  /// This private property presents running state of all animations
  /// in [ExpandableMenu].
  bool _isAnimating = false;

  /// This property declare width of
  /// icons(Hamburger icon and arrow icon) in widget.
  /// iconWidth will be equals (widget.width * 0.7)
  late double iconWidth;

  /// This property declare height of
  /// icons(Hamburger icon and arrow icon) in widget.
  /// iconHeight will be equals (widget.height * 0.7)
  late double iconHeight;

  /// This controller changes icon state.
  late final ExpandableIconController _expandableIconController;

  @override
  void initState() {
    //Use external controller if set
    if (widget.controller != null) {
      _expandableIconController = widget.controller!;
    } else {
      _expandableIconController = ExpandableIconController();
    }
    _expandableIconController.setControllerState(this);

    iconWidth = widget.width * 0.7;
    iconHeight = widget.height * 0.7;

    _hamburgerAnimationController = AnimationController(
      duration: Duration(milliseconds: (widget.animationSpeed * 0.4).toInt()),
      vsync: this,
    );

    final Animation<double> hamburgerCurve = CurvedAnimation(
        parent: _hamburgerAnimationController, curve: Curves.easeOutQuart);
    _hamburgerAnimation = Tween(begin: 0.0, end: 1.0).animate(hamburgerCurve)
      ..addListener(() {
        setState(() {
          _hamburgerProgress = _hamburgerAnimation.value;
        });
        if (_hamburgerAnimation.isCompleted) {
          _expandableIconController.setExpandStatus();
        }
      });

    _arrowAnimationController = AnimationController(
      duration: Duration(milliseconds: (widget.animationSpeed * 0.2).toInt()),
      vsync: this,
    );

    final Animation<double> arrowCurve = CurvedAnimation(
        parent: _arrowAnimationController, curve: Curves.easeOutQuart);
    _arrowAnimation = Tween(begin: 0.0, end: 1.0).animate(arrowCurve)
      ..addListener(() {
        setState(() {
          _arrowProgress = _arrowAnimation.value;
        });
      });

    _expandableIconController.addListener(() {
      if (_expandableIconController.isExpanded) {
        Future.delayed(
            Duration(milliseconds: (widget.animationSpeed * 0.4).toInt()), () {
          _arrowAnimationController.forward();
        });
      } else {
        _arrowAnimationController.reverse();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    _hamburgerAnimationController.dispose();
    _expandableIconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: Directionality.of(context) == TextDirection.rtl ? 2 : 0,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Colors.black.withOpacity(.2),
            splashColor: Colors.black.withOpacity(.2),
            borderRadius: BorderRadius.all(Radius.circular(widget.width)),
            onTap: () {
              onClickInternal();
            },
            child: CustomPaint(
              size: Size(iconWidth, iconHeight),
              painter: MyPainter(
                hamburgerProgress: _hamburgerProgress,
                iconWidth: iconWidth,
                iconHeight: iconHeight,
                arrowProgress: _arrowProgress,
                iconColor: widget.iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onClickInternal() {
    if (!_isAnimating) {
      if (_hamburgerAnimationController.isCompleted) {
        _animationLocker();
        _expandableIconController.setExpandStatus();
        widget.onClicked();
        Future.delayed(
            Duration(milliseconds: (widget.animationSpeed * 0.4).toInt()), () {
          _hamburgerAnimationController.reverse();
        });
      } else {
        _animationLocker();
        _hamburgerAnimationController.forward();
        Future.delayed(
            Duration(milliseconds: (widget.animationSpeed * 0.4).toInt()), () {
          widget.onClicked();
        });
      }
    }
  }

  /// This method will lock clickable of button
  /// to ensure all animations finished.
  void _animationLocker() {
    _isAnimating = true;
    Future.delayed(
        Duration(
            milliseconds: (widget.animationSpeed * 0.4).toInt() +
                (widget.animationSpeed * 0.25).toInt() * 2), () {
      _isAnimating = false;
    });
  }
}

/// This class draw arrow shape and hamburger shape.
class MyPainter extends CustomPainter {
  final double hamburgerProgress;
  final double arrowProgress;
  final double iconWidth;
  final double iconHeight;
  final Color iconColor;

  MyPainter({
    required this.hamburgerProgress,
    required this.arrowProgress,
    required this.iconColor,
    required this.iconWidth,
    required this.iconHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final line1Point1 = Offset(
        (iconWidth * .27) + ((iconWidth * .27) * arrowProgress),
        ((((iconHeight * 0.35) +
                (((((iconHeight * .32) / 2))) * hamburgerProgress)))) -
            ((iconHeight * 0.20) * arrowProgress));
    final line1Point2 = Offset(
        (iconWidth * .73),
        ((((iconHeight * 0.35) +
                (((((iconHeight * .32) / 2))) * hamburgerProgress))) -
            ((iconHeight * .01) * arrowProgress)));

    final line2Point1 = Offset(
        (iconWidth * .27) + ((iconWidth * .27) * arrowProgress),
        (((iconHeight * 0.65) -
                (((((iconHeight * .32) / 2))) * hamburgerProgress))) +
            ((iconHeight * 0.20) * arrowProgress));
    final line2Point2 = Offset(
        (iconWidth * .73),
        ((((iconHeight * 0.65) -
                (((((iconHeight * .32) / 2))) * hamburgerProgress)))) +
            ((iconHeight * .01) * arrowProgress));

    final paint = Paint()
      ..color = iconColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = iconHeight * .12;

    canvas.drawLine(line1Point1, line1Point2, paint);
    canvas.drawLine(line2Point1, line2Point2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/// This class is controller for control expand icon.
class ExpandableIconController extends ChangeNotifier {
  bool isExpanded = false;
  ExpandableIconState? state;

  void setControllerState(ExpandableIconState state) {
    this.state = state;
  }

  /// This method will change expand status.
  void setExpandStatus() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  /// This metod is the same as a toggle
  void toggle() {
    state?.onClickInternal();
  }
}
