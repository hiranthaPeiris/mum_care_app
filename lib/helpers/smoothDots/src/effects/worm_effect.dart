import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/smoothDots/src/painters/indicator_painter.dart';
import 'package:mun_care_app/helpers/smoothDots/src/painters/worm_painter.dart';

import 'indicator_effect.dart';

const accentColor = Color(0xFFffffff);

class WormEffect extends IndicatorEffect {
  const WormEffect({
    double offset,
    double dotWidth = 8.0,
    double dotHeight = 8.0,
    double spacing = 8.0,
    double radius = 8,
    Color dotColor = Colors.grey,
    Color activeDotColor = accentColor,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(activeDotColor != null),
        super(
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          spacing: spacing,
          radius: radius,
          strokeWidth: strokeWidth,
          paintStyle: paintStyle,
          dotColor: dotColor,
          activeDotColor: activeDotColor,
        );

  @override
  IndicatorPainter buildPainter(int count, double offset, bool isRTL) {
    return WormPainter(
        count: count, offset: offset, effect: this, isRTL: isRTL);
  }
}
