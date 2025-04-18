import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

extension FaIconTesterExt on CommonFinders {
  Finder byFaIcon(IconData icon) {
    final finder = find.byWidgetPredicate(
      (Widget widget) => widget is FaIcon && widget.icon == icon,
    );
    expect(finder, findsWidgets);
    return finder;
  }
}
