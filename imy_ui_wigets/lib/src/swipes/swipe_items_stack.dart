import 'dart:math';
import 'package:flutter/material.dart';

class SwipeItemsStack extends StatefulWidget {
  final GlobalKey<SwipeItemsStackState> key;
  final int stackItems;
  final int horizontalDragSpeed;
  final int verticalDragSpeed;
  final int rotationSpeed;
  final Offset stackItemOffset;
  final double stackScaleDownFactor;
  final List<Widget> children;
  final Widget noItemWidget;
  final Function onSwipeItemChanged;

  SwipeItemsStack({
    this.key,
    this.stackItems = 3,
    this.horizontalDragSpeed = 100,
    this.verticalDragSpeed = 50,
    this.rotationSpeed = 5,
    this.stackItemOffset,
    this.stackScaleDownFactor = 0.035,
    @required this.children,
    this.noItemWidget,
    this.onSwipeItemChanged,
  }) : assert(stackScaleDownFactor < 1.0);

  @override
  SwipeItemsStackState createState() =>  SwipeItemsStackState();
}

class SwipeItemsStackState extends State<SwipeItemsStack> with SingleTickerProviderStateMixin {
  List<Widget> _swipeItems = List();

  double _frontItemXPos;
  double _frontItemYPos;
  double _frontItemRot;

  Offset _stackOffset;
  double _stackScaling;

  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;
  Animation<double> _swipeAwayAnim;
  Animation<Offset> _moveStackUpAnim;

  @override
  void initState() {
    super.initState();

    _resetFrontItemDisplay();

    for (int i=0; i<widget.children.length-1; i++){
      _swipeItems.add(widget.children[i]);
    }

    _stackOffset = widget.stackItemOffset?? Offset(0.0, -0.03);
    _stackScaling = widget.stackScaleDownFactor;

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300),);
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _moveStackUpAnim = Tween(begin: Offset(_stackOffset.dx, _stackOffset.dy), end: Offset(0.0, 0.0)).animate(_curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _swipeItemsAndGestureDetectors(),
    );
  }

  List<Widget> _swipeItemsAndGestureDetectors() {
    int maxStackItems = _swipeItems.length >= widget.stackItems ? widget.stackItems : _swipeItems.length;
    List<Widget> swipeItemWidgets;

    if (_swipeItems.length > 0) {
      swipeItemWidgets = _swipeItems.reversed.map((swipeItem){
        int itemIndex = _swipeItems.indexOf(swipeItem);
        if (itemIndex == 0)  //Only the first item is able to be dragged and swiped
          return Transform.translate(
            offset: _animationController.status == AnimationStatus.forward
                ? Offset(_swipeAwayAnim.value, _frontItemYPos) : Offset(_frontItemXPos, _frontItemYPos),
            child: Transform.rotate(
              angle: (pi / 180.0) * _frontItemRot,
              child: Center(child: swipeItem)),
          );
        if (itemIndex <= maxStackItems - 1)
          return FractionalTranslation(
            translation: _stackedItemOffset(itemIndex),
            child: Transform.scale(
              scale:  _stackedItemScale(itemIndex),
              child: Center(child: swipeItem),
            ),
          );
        return Container();
      }).toList();

      if (_animationController.status != AnimationStatus.forward) {
        swipeItemWidgets.add(SizedBox.expand(
          child: _gestureDetector(),
        ));
      }
      return swipeItemWidgets;
    }

    swipeItemWidgets = List<Widget>();

    if (widget.noItemWidget != null){
      swipeItemWidgets.add(widget.noItemWidget);
      return swipeItemWidgets;
    }

    swipeItemWidgets.add(Center(child: Text("No items left!")));
    return swipeItemWidgets;
  }

  GestureDetector _gestureDetector() {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        double dx = details.delta.dx / MediaQuery.of(context).size.width;
        _frontItemXPos +=  widget.horizontalDragSpeed * dx;
        _frontItemYPos += widget.verticalDragSpeed * details.delta.dy / MediaQuery.of(context).size.height;
        _frontItemRot += widget.rotationSpeed * dx;

        setState(() {});
      },
      onPanEnd: (_) {
        // If the front item was swiped far enough as swiped
        if(_frontItemXPos > 20.0 || _frontItemXPos < -20.0) {
          _swipeAwayAnim = Tween(
            begin: _frontItemXPos,
            end: _frontItemXPos > 0 ? _frontItemXPos + 1000.0 : _frontItemXPos - 1000.0,
          ).animate(_curvedAnimation)..addListener(() { setState(() {}); });

          _animationController.reset();
          _animationController.forward().whenComplete(_moveStackItemUp);
        }
        else {
          _resetFrontItemDisplay();

          setState(() {});
        }
      },
    );
  }

  void _moveStackItemUp() {
    _swipeItems.removeAt(0);

    _resetFrontItemDisplay();

    if (widget.onSwipeItemChanged!= null) {
      widget.onSwipeItemChanged(_swipeItems.length);
    }
  }

  void _resetFrontItemDisplay() {
    _frontItemXPos = 0.0;
    _frontItemYPos = 0.0;
    _frontItemRot = 0.0;
  }

  Offset _stackedItemOffset(int itemIndex) {
    if (_animationController.status == AnimationStatus.forward) {
      return _moveStackUpAnim.value.translate(_stackOffset.dx * (itemIndex - 1), _stackOffset.dy * (itemIndex - 1));
    }
    return Offset(0.0, 0.0).translate(_stackOffset.dx * itemIndex, _stackOffset.dy * itemIndex);
  }

  double _stackedItemScale(int itemIndex) {
    if (_animationController.status == AnimationStatus.forward) {
      double beginScale = 1 - (_stackScaling * itemIndex);
      double endScale = 1 - (_stackScaling * (itemIndex - 1));

      Animation<double> scaleAnim = Tween(begin: beginScale, end: endScale).animate(_curvedAnimation);
      return scaleAnim.value;
    }
    return 1.0 - (_stackScaling * itemIndex);
  }

  void addItems(List<Widget> widgets) {
    for (int i=0; i<widgets.length-1; i++){
      _swipeItems.add(widgets[i]);
    }

    setState(() {});
  }
}