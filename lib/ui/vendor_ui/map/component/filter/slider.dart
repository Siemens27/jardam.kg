import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

class KMSlider extends StatelessWidget {
  const KMSlider(
      {required this.value, required this.onChanged, required this.label});
  final double value;
  final Function onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: PsColors.mainColor,
      value: value,
      onChanged: (double value) {
        onChanged(value);
      },
      divisions: 10,
      label: label,
    );
  }
}
