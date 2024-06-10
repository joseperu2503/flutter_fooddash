import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/restaurant/data/constants.dart';
import 'package:delivery_app/features/shared/widgets/back_button.dart';
import 'package:flutter/material.dart';

class ImageAppBar extends StatefulWidget {
  const ImageAppBar({
    super.key,
    required this.title,
    required this.image,
    required this.scrollController,
    this.logoImage,
  });
  final String title;
  final String image;
  final String? logoImage;
  final ScrollController scrollController;

  @override
  State<ImageAppBar> createState() => _ImageAppBarState();
}

class _ImageAppBarState extends State<ImageAppBar> {
  double opacity = 0;
  double opacityLogo = 1;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      final offsset = widget.scrollController.offset;
      setState(() {
        if (offsset < 200) {
          opacity = 0;
        }

        if (offsset > 228) {
          opacity = 1;
        }
        if (offsset >= 200 && offsset <= 228) {
          opacity = (offsset - 200) / (228 - 200);
        }
      });

      setState(() {
        if (offsset < 120) {
          opacityLogo = 1;
        }

        if (offsset > 187) {
          opacityLogo = 0;
        }
        if (offsset >= 120 && offsset <= 187) {
          opacityLogo = 1 - (offsset - 120) / (187 - 120);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return SliverAppBar(
      titleSpacing: 0,
      title: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Row(
          children: [
            const CustomBackButton(),
            const SizedBox(
              width: 20,
            ),
            Opacity(
              opacity: opacity,
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray800,
                ),
              ),
            )
          ],
        ),
      ),
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: AppColors.background,
      expandedHeight: expandedHeightAppbar,
      foregroundColor: AppColors.background,
      collapsedHeight: collapsedHeightAppbar,
      excludeHeaderSemantics: true,
      flexibleSpace: Stack(
        clipBehavior: Clip.none,
        children: [
          FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: Container(
                width: double.infinity,
                color: AppColors.background,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          if (widget.logoImage != null)
            Positioned(
              bottom: -50,
              left: deviceWidth / 2 - 50,
              child: Opacity(
                opacity: opacityLogo,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      widget.logoImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
