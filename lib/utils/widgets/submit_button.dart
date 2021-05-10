import 'package:auto_size_text/auto_size_text.dart';
import 'package:core_sdk/utils/colors.dart';
import 'package:core_sdk/utils/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? onSubmit;
  final String title;
  final double width;
  final bool isLoading;
  final bool isEnabled;
  final double borderRadius;
  final double? elevation;
  final double verticalPadding;
  final Color textColor;
  final Color color;
  final Color borderColor;
  final Widget? icon;

  SubmitButton({
    Key? key,
    required this.onSubmit,
    required this.title,
    this.isLoading = false,
    this.isEnabled = true,
    this.width = 0.9,
    this.elevation,
    this.borderRadius = 4.0,
    this.verticalPadding = 10.0,
    this.textColor = WHITE,
    this.color = LIGHT_GREEN,
    this.borderColor = LIGHT_GREEN,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: isEnabled && !isLoading
          ? () {
              FocusScope.of(context).unfocus();
              onSubmit!();
            }
          : null,
      color: isEnabled && !isLoading ? color : LIGHT_GREY,
      elevation: elevation,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: verticalPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(this.borderRadius)),
        side: BorderSide(color: isEnabled && !isLoading ? borderColor : Colors.transparent),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? icon! : Container(),
            AutoSizeText(
              title,
              style: Theme.of(context).textTheme.headline1!.copyWith(color: textColor),
            ),
            ProgressBar(visibility: isLoading, padding: 8.0),
          ],
        ),
      ),
    );
  }
}
