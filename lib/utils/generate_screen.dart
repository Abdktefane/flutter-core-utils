// TODO(abd): move this to main
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tawreed_customer/feature/auth/presentation/pages/forgot_password.dart';
// import 'package:tawreed_customer/feature/auth/presentation/pages/login.dart';
// import 'package:tawreed_customer/feature/auth/presentation/pages/register.dart';
// import 'package:tawreed_customer/feature/base_screen/base_screen.dart';
// import 'package:tawreed_customer/feature/basket/presentation/pages/basket_page.dart';
// import 'package:tawreed_customer/feature/basket/presentation/pages/place_order_result.dart';
// import 'package:tawreed_customer/feature/splash/presentation/pages/splash.dart';

// class GenerateScreen {
//   static Route<dynamic> onGenerate(RouteSettings value) {
//     String name = value.name;
//     print("the name is $name");
//     final args = value.arguments;
//     switch (name) {
//       case RouteNames.SPLASH:
//         return MaterialPageRoute(builder: (context) => Splash());

//       case RouteNames.LOGIN:
//         return MaterialPageRoute(builder: (context) => Login());

//       case RouteNames.REGISTER:
//         return MaterialPageRoute(builder: (context) => Register());

//       case RouteNames.FORGOT_PASSWORD:
//         return MaterialPageRoute(builder: (context) => ForgotPassword());

//       case RouteNames.BASE_SCREEN:
//         return CupertinoPageRoute(
//           builder: (context) => BaseScreen(notificationDestenation: (args as Route)),
//         );

//       case RouteNames.BASKET:
//         return CupertinoPageRoute(builder: (context) => BasketPage());

//       /* case RouteNames.NOTIFICATIONS:
//         return CupertinoPageRoute(builder: (context) => NotificationsPage()); */

//       case RouteNames.PLACE_ORDER_RESULT:
//         return CupertinoPageRoute(builder: (context) => PlaceOrderResult((args as Map)['order']));

//       default:
//         return _errorRoute(value.name);
//     }
//   }

//   static Route<dynamic> _errorRoute(String routeName) {
//     return MaterialPageRoute(
//       builder: (_) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Routing Error!'),
//           ),
//           body: Center(
//             child: Text('ERROR: No page route found for "$routeName"'),
//           ),
//         );
//       },
//     );
//   }
// }

// class RouteNames {
//   static const String SPLASH = "/";
//   static const String PROFILE = "/profile";
//   static const String REGISTER = "/register";
//   static const String LOGIN = "/login";
//   static const String HOME = "/home";
//   static const String SETTINGS = "/settings";
//   static const String FORGOT_PASSWORD = "/forgot_password";
//   static const String BASE_SCREEN = "/base_screen";
//   static const String PLACE_ORDER_RESULT = "/place_order_result";
//   static const String NOTIFICATIONS = "/notifications";
//   static const String BASKET = "/basket";
// }
