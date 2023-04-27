import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/ui/vendor_ui/common/smooth_star_rating_widget.dart';

import '../../../config/route/route_paths.dart';
import '../../../core/vendor/constant/ps_dimens.dart';
import '../../../core/vendor/utils/utils.dart';
import '../../../core/vendor/viewobject/user.dart';

class UserRatingWidget extends StatelessWidget {
  const UserRatingWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User? user;
  @override
  Widget build(BuildContext context) {
    final String? rating =
        user!.overallRating != '' ? user!.overallRating : '0';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          rating ?? '0',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Utils.isLightMode(context)
                  ? Colors.grey[400]
                  : PsColors.textColor2,
              fontSize: 14),
        ),
        const SizedBox(
          width: PsDimens.space8,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RoutePaths.ratingList,
                arguments: user!.userId);
          },
          child: SmoothStarRating(
              key: Key(rating ?? '0'),
              rating: double.parse(rating ?? '0'),
              allowHalfRating: false,
              isReadOnly: true,
              starCount: 1,
              color: PsColors.cRatingColor,
              borderColor: PsColors.cRatingColor,
              onRated: (double? v) async {},
              spacing: 0.0),
        ),
      ],
    );
  }
}
