// import 'package:core_sdk/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations/controlled_animation.dart';
// import 'package:simple_animations/simple_animations/multi_track_tween.dart';

// class SwitchButton extends StatelessWidget {
//   final bool checked;

//   final Color checkedColor;

//   final Color unCheckedColor;

//   final ValueChanged<bool> onSwitch;

//   SwitchButton({this.checked, this.checkedColor, this.unCheckedColor, this.onSwitch});

//   @override
//   Widget build(BuildContext context) {
//     var tween = MultiTrackTween([
//       Track("paddingLeft").add(Duration(milliseconds: 400), Tween(begin: 0.0, end: 20.0)),
//       Track("color").add(Duration(milliseconds: 400), ColorTween(begin: unCheckedColor, end: checkedColor)),
//     ]);

//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: ControlledAnimation(
//         playback: checked ? Playback.PLAY_FORWARD : Playback.PLAY_REVERSE,
//         startPosition: checked ? 1.0 : 0.0,
//         duration: tween.duration * 1.2,
//         tween: tween,
//         curve: Curves.easeInOut,
//         builder: _buildCheckbox,
//       ),
//     );
//   }

//   Widget _buildCheckbox(context, animation) {
//     return GestureDetector(
//       onTap: () {
//         if (onSwitch != null) onSwitch(!checked);
//       },
//       child: Container(
//         decoration: _outerBoxDecoration(animation['color']),
//         width: 40,
//         height: 20,
//         padding: const EdgeInsets.all(3.0),
//         child: Stack(
//           children: [
//             Positioned(
//               child: Padding(
//                 padding: EdgeInsets.only(left: animation["paddingLeft"]),
//                 child: Container(
//                   decoration: _innerBoxDecoration(animation["color"]),
//                   width: 13,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   BoxDecoration _innerBoxDecoration(color) => BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(25)),
//         color: WHITE,
//       );

//   BoxDecoration _outerBoxDecoration(color) => BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(30)),
//         color: color,
//       );
// }
