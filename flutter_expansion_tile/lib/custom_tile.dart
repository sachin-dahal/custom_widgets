import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTile extends StatefulWidget {
  //* Main Title to the tile
  final Text title;

  //* This determines the ratio of a tile in front UI
  final double notExpandedTileHeightRatio; // = 0.1;

  //* This determines the ratio of a tile when expanded
  final double expandedTileHeightRatio; // = 0.4;

  //* Color of the main tile
  final Color tileColor;

  //* Color of the Container of content
  final Color contentBoxColor;

  //* This is the content for the tile
  final List<Widget> children;

  //* Padding for the listed contents inside expansion tile
  final EdgeInsets contentPadding;

  //! imageURL is default here
  //* But could be changed by mutating some of the values in the Image section
  //final String imgUrl;

  CustomTile({
    @required this.title,
    @required this.notExpandedTileHeightRatio,
    @required this.expandedTileHeightRatio,
    @required this.children,
    this.tileColor,
    this.contentBoxColor,
    this.contentPadding,
  }) : assert(
          title != null &&
              notExpandedTileHeightRatio != null &&
              expandedTileHeightRatio != null &&
              children != null &&
              notExpandedTileHeightRatio < expandedTileHeightRatio,
        );

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _animation = CurvedAnimation(curve: Curves.bounceOut, parent: _controller);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            _controller.status == AnimationStatus.completed
                ? _controller.reverse()
                : _controller.forward();
          },
          child: Container(
            height: _animation.value == 0
                ? height * widget.notExpandedTileHeightRatio
                : (_animation.value * height * widget.expandedTileHeightRatio) +
                    height * widget.notExpandedTileHeightRatio,
            width: width,
            color: widget.tileColor ?? Colors.grey[300],
            //* Difference between container height (expandedTileHeightRatio) and Image
            //* Position should be x - 0.04

            child: Stack(
              children: [
                //* IMAGE SECTION
                Positioned(
                  top: _animation.value == 0
                      ? height * 0.03
                      : ((_animation.value *
                                      height *
                                      (widget.expandedTileHeightRatio - 0.4)) +
                                  60) /
                              2 +
                          height * 0.03,
                  left: _animation.value == 0
                      ? 10.0
                      : (_animation.value * -(height * 0.14)) + 10,
                  child: Image(
                    //TODO: SHOULD CHANGE THE VALUE IF NOT SEEMS GOOD ENOUGH
                    height: _animation.value == 0
                        ? height * 0.05
                        : (_animation.value * height * 0.24) + height * 0.05,
                    image: AssetImage("images/demo.png"),
                  ),
                ),
                //* TITLE TEXT SECTION
                Positioned(
                  top: height * 0.03,
                  left: width * 0.12,
                  child: widget.title,
                ),
                //* CONTENT SECTION OF THE TILE
                Positioned(
                  top: height * 0.1,
                  left: width * 0.12,
                  child: Container(
                    height: height,
                    width: width - height * 0.08,
                    color: widget.contentBoxColor ?? Colors.blueGrey[100],
                    padding: widget.contentPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.children,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
