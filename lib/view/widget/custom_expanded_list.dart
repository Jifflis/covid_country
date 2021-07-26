import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomExpandedList extends StatefulWidget {
  CustomExpandedList({
    required this.title,
    required this.child,
    required this.onTap,
    this.titleStyle,
    this.highlight = false,
  });

  final String title;
  final Widget child;
  final TextStyle? titleStyle;
  final bool highlight;
  final Function onTap;

  @override
  _CustomExpandedListState createState() => _CustomExpandedListState();
}

class _CustomExpandedListState extends State<CustomExpandedList> {
  bool collapse = true;
  double begin = 180;
  double end = 0;
  double childHeight = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      child: Container(
        color: widget.highlight ? Colors.blue[300] : null,
        child: Column(
          children: [
            _buildHeader(),
            _buildSubList(),
            if (!collapse)
              Divider(
                thickness: 1,
              )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          _buildTitle(),
          _buildArrow(),
        ],
      ),
    );
  }

  Widget _buildTitle() => Expanded(
        child: Text(
          widget.title,
          style: widget.titleStyle ??
              TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
      );

  Widget _buildSubList() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: childHeight,
      child: widget.child,
    );
  }

  Widget _buildArrow() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (collapse) {
            begin = 0;
            end = 180;
            collapse = false;
            childHeight = 140;
          } else {
            begin = 180;
            end = 0;
            collapse = true;
            childHeight = 0;
          }
        });
      },
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: begin, end: end),
        child: Icon(Icons.keyboard_arrow_down_sharp),
        duration: Duration(milliseconds: 200),
        builder: (BuildContext context, double val, Widget? child) {
          return Transform.rotate(
            angle: val * pi / 180,
            child: child,
          );
        },
      ),
    );
  }
}
