import 'package:core_sdk/utils/colors.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String content;
  final String image;
  final IconData icon;

  EmptyView({
    @required this.content,
    this.image,
    this.icon,
  }) : assert(icon != null || image != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Icon(
                  icon,
                  color: GREY,
                  size: 100.0,
                )
              : Image.asset(
                  image,
                  width: MediaQuery.of(context).size.width * 0.3,
                  fit: BoxFit.contain,
                  color: GREY,
                ),
          SizedBox(height: 12.0),
          Text(
            content.toString(),
            style: TextStyle(
              fontSize: 16,
              color: GREY,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
