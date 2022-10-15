import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:core_sdk/utils/app_localizations.dart';
import 'package:core_sdk/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

String? dateFormatter(String dateStr, AppLocalizations localizations) {
  if (dateStr == null || dateStr.isEmpty) return '';
  final date = DateTime.parse(dateStr);
  final diff = DateTime.now().difference(date);
  final locale = localizations.locale.languageCode == LANGUAGE_ARABIC ? 'ar_AR' : 'en_US';
  if (diff.inMinutes <= 59)
    return diff.inMinutes > 1
        ? '${diff.inMinutes} ${localizations.translate('lbl_minutes_ago')}'
        : localizations.translate('lbl_just_now');
  else if (diff.inHours < 24)
    return diff.inHours > 1
        ? '${diff.inHours} ${localizations.translate('lbl_hours_ago')}'
        : localizations.translate('lbl_an_hour_ago');
  else if (diff.inDays <= 7)
    return '${DateFormat.EEEE(locale).format(date)} ${localizations.translate('lbl_time_at')} ${DateFormat.jm(locale).format(date)}';
  return '${DateFormat.d(locale).add_MMM().format(date)} ${localizations.translate('lbl_time_at')} ${DateFormat.jm(locale).format(date)}';
}

String durationToFormattedTime(Duration time, Locale locale) {
  DateTime eventTime = DateTime.fromMillisecondsSinceEpoch(time.inMilliseconds * 1000).subtract(Duration(days: 1));
  String formattedTime = DateFormat.yMMMMEEEEd(
    locale.languageCode == LANGUAGE_ARABIC ? 'ar_AR' : 'en_US',
  ).format(eventTime);
  return formattedTime;
}

bool isArabic({BuildContext? context, AppLocalizations? localizations}) {
  assert(context != null || localizations != null);
  return (localizations ?? AppLocalizations.of(context!))!.locale.languageCode == LANGUAGE_ARABIC;
}

Future<BitmapDescriptor?> getMapMarker(String assetPath) async {
  final data = await rootBundle.load(assetPath);
  final list = Uint8List.view(data.buffer);
  final completer = Completer<ui.Image>();
  ui.decodeImageFromList(list, completer.complete);
  return getMarkerIconWithTitle(await completer.future);
}

Future<BitmapDescriptor?> getMarkerIconWithTitle(ui.Image image) async {
  final size = Size(400, 200);
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final double shadowWidth = 15.0;

//  final Paint borderPaint = Paint()..color = Colors.white;
  final double borderWidth = 3.0;

  final double imageOffset = shadowWidth + borderWidth;

  // Oval for the image
  Rect oval =
      Rect.fromLTWH(imageOffset, imageOffset + 20, size.width - (imageOffset * 2), size.height - (imageOffset * 2));

  // Add image
  paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.contain);

  // Convert canvas to image
  final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(size.width.toInt(), size.height.toInt());

  // Convert image to bytes
  final ByteData? byteData = await (markerAsImage.toByteData(format: ui.ImageByteFormat.png) as Future<ByteData?>);
  final Uint8List? uint8List = byteData?.buffer.asUint8List();
  if (uint8List == null) return null;

  return BitmapDescriptor.fromBytes(uint8List);
}

// Future<String> findLocalPath({bool forDownload = false}) async {
//   final directory = Platform.isAndroid
//       ? forDownload
//           ? Directory('/storage/emulated/0')
//           : await getExternalStorageDirectory()
//       : await getApplicationDocumentsDirectory();
//   return directory.path;
// }
