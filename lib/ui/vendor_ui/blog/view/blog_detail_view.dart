import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/viewobject/blog.dart';
import '../../common/ps_admob_banner_widget.dart';
import '../../common/ps_app_bar_widget.dart';
import '../../common/ps_html_text_widget.dart';
import '../../common/ps_ui_widget.dart';

class BlogView extends StatefulWidget {
  const BlogView({Key? key, required this.blog, required this.heroTagImage})
      : super(key: key);

  final Blog blog;
  final String? heroTagImage;

  @override
  BlogViewState<BlogView> createState() => BlogViewState<BlogView>();
}

class BlogViewState<T extends BlogView> extends State<BlogView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PsAppbarWidget(appBarTitle: widget.blog.name ?? ''),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              PsNetworkImage(
                photoKey: widget.heroTagImage!,
                height: PsDimens.space200,
                width: double.infinity,
                defaultPhoto: widget.blog.defaultPhoto!,
                imageAspectRation: PsConst.Aspect_Ratio_full_image,
                boxfit: BoxFit.cover,
              ),
              const SizedBox(
                height: 28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.blog.name ?? '',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: PsColors.mainColor),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.blog.addedDateStr ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: PsColors.grey),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              PsHTMLTextWidget(
                htmlData: widget.blog.description ?? '',
              ),
              const PsAdMobBannerWidget()
            ]),
      ),
    );
  }
}
