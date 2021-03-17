// TODO(abd): check if this exist
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:tawreed_customer/core/utils/colors.dart';

// class SettingOption {
//   final IconData icon;
//   final String title;
//   final String description;
//   final VoidCallback onTap;

//   SettingOption({
//     @required this.icon,
//     @required this.title,
//     @required this.onTap,
//     this.description = '',
//   });
// }

// void showSettingBottomSheet(context, {@required List<SettingOption> options}) {
//   final titleStyle = TextStyle(
//     fontSize: 16,
//     color: TEXT_COLOR,
//     fontWeight: FontWeight.bold,
//   );
//   final descriptionStyle = TextStyle(
//     fontSize: 14,
//     color: TEXT_COLOR,
//     fontWeight: FontWeight.w400,
//   );
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext bc) {
//       return SafeArea(
//         minimum: EdgeInsets.symmetric(vertical: 8.0),
//         child: Container(
//           child: new Wrap(
//             children: options
//                 .map(
//                   (option) => ListTile(
//                     onTap: () {
//                       context.pop();
//                       option.onTap();
//                     },
//                     leading: Icon(
//                       option.icon,
//                       color: Colors.blueAccent,
//                     ),
//                     title: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(option.title, style: titleStyle),
//                         Visibility(
//                           visible: option.description.isNotEmpty,
//                           child: Text(
//                             option.description,
//                             style: descriptionStyle,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),
//       );
//     },
//   );
// }
