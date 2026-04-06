import 'package:flutter/material.dart';

enum ColorSelection {
  marquee('Marquee', Color(0xFFD7263D)),
  popcorn('Popcorn', Color(0xFFF2D479)),
  midnight('Midnight', Color(0xFF0F1B40)),
  backstage('Backstage', Color(0xFF243447)),
  reel('Reel Silver', Color(0xFF9DA9B5)),
  neon('Neon Glow', Color(0xFF34D399)),
  noir('Noir', Color(0xFF111827));

  const ColorSelection(this.label, this.color);
  final String label;
  final Color color;
}
