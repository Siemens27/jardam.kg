import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';

class EmptyVideoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(PsDimens.space4),
      color: PsColors.grey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Icon(
          Icons.video_call_outlined,
          size: 32,
          color: PsColors.mainColor,
        ),
      ),
    );
    // return SizedBox(
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.height,
    //   child: const Icon(
    //     Icons.play_circle,
    //     color: Colors.grey,
    //     size: 50,
    //   ),
    // );
  }
}
