import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

showPopupMenu<T>({
  required BuildContext context,
  required GlobalKey popupButtonKey,
  required List<PopupMenuEntry> menuEntries,
  required Function(dynamic) onSelect,
}) {
  // Here we get the render object of our physical button, later to get its size & position
  final RenderBox popupButtonObject =
      popupButtonKey.currentContext!.findRenderObject() as RenderBox;

// Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
  final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;

// Calculate the show-up area for the dropdown using button's size & position based on the `overlay` used as the coordinate space.
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      popupButtonObject.localToGlobal(Offset.zero, ancestor: overlay),
      popupButtonObject.localToGlobal(
          popupButtonObject.size.bottomRight(Offset.zero),
          ancestor: overlay),
    ),
    Offset.zero &
        overlay
            .size, // same as: new Rect.fromLTWH(0.0, 0.0, overlay.size.width, overlay.size.height)
  );

// Finally, show the menu.
  showMenu<T>(
    context: context,
    elevation: 4.0,
    // default value
    items: menuEntries as List<PopupMenuEntry<T>>,
    initialValue: null,
    position: position,
  ).then(onSelect);
}
