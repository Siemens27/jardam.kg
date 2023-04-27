import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';

class ShimmerItem extends StatelessWidget {
  const ShimmerItem();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor:
            Utils.isLightMode(context) ? Colors.white12 : Colors.black54,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: PsColors.black,
            borderRadius:
                const BorderRadius.all(Radius.circular(PsDimens.space2)),
          ),
        ));
  }
}
