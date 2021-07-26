
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicRow extends StatelessWidget {
  BasicRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 17, left: 17, right: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.grey[700]),
          ),
          Text(
            value.length > 20 ? value.substring(0, 20)+'...' : value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}