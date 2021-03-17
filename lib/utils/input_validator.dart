//TODO(abd): chanege location to common this to
// import 'package:injectable/injectable.dart';

// @lazySingleton
// class InputValidator {
//   RegExp mobileRegExp = new RegExp(
//     "^[0-9]+\$",
//     caseSensitive: false,
//     multiLine: false,
//   );

//   RegExp emailRegExp = new RegExp(
//     "^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w{2,}([-.]\\w+)*\$",
//     caseSensitive: false,
//     multiLine: false,
//   );

//   RegExp nameRegExp = new RegExp(
//     "^[A-Z]+\$",
//     caseSensitive: false,
//     multiLine: false,
//   );

//   RegExp poboxRegx = new RegExp(
//     r'^(?:\+971|00971|0)?(?:50|51|52|55|56|2|3|4|6|7|9)\d{7}$',
//     caseSensitive: false,
//     multiLine: false,
//   );

//   bool checkPassword(String password) {
//     return password.length >= 8 && password.length <= 20;
//   }

//   bool checkName(String name) {
//     return nameRegExp.hasMatch(name.replaceAll(' ', '')) && name.length >= 2 && name.length <= 20;
//   }

//   bool checkPartnerName(String name) {
//     return nameRegExp.hasMatch(name.replaceAll(' ', '')) && name.length >= 2 && name.length <= 40;
//   }

//   bool checkStreet(String name) {
//     return name.length >= 2 && name.length <= 20;
//   }

//   bool checkEmail(String email) {
//     return emailRegExp.hasMatch(email);
//   }

//   bool checkMobile(String mobile, {SiteModel site, String phoneCode}) {
//     return mobileRegExp.hasMatch(mobile) &&
//         (((phoneCode ?? site.phoneCode) == '+971' && mobile.length == 9) ||
//             ((phoneCode ?? site.phoneCode) == '+20' && mobile.length == 10));
//   }

//   bool checkOfficeNumber(String pobox) {
//     return poboxRegx.hasMatch(pobox);
//   }

//   bool checkTaxNumber(String tax) {
//     return tax.isNotEmpty && tax.length == 15;
//   }
// }
