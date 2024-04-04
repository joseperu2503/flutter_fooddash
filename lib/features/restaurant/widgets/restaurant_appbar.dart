import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/restaurant/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ImageAppBar extends StatefulWidget {
  const ImageAppBar({
    super.key,
    required this.title,
    required this.image,
    required this.scrollController,
  });
  final String title;
  final String image;
  final ScrollController scrollController;

  @override
  State<ImageAppBar> createState() => _ImageAppBarState();
}

class _ImageAppBarState extends State<ImageAppBar> {
  double opacity = 0;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      final offsset = widget.scrollController.offset;
      setState(() {
        if (offsset < 187) {
          opacity = 0;
        }

        if (offsset > 228) {
          opacity = 1;
        }
        if (offsset >= 187 && offsset <= 228) {
          opacity = (offsset - 187) / (228 - 187);
        }
        ;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: 0,
      toolbarHeight: collapsedHeightAppbar,
      title: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        height: collapsedHeightAppbar,
        child: Row(
          children: [
            SizedBox(
              width: 38,
              height: 38,
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.zero,
                  elevation: 4,
                  surfaceTintColor: AppColors.white,
                ),
                child: SvgPicture.asset(
                  'assets/icons/arrow_down.svg',
                ),
              ),
            ),
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      expandedHeight: expandedHeightAppbar,
      foregroundColor: Colors.white,
      collapsedHeight: collapsedHeightAppbar,
      excludeHeaderSemantics: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          width: double.infinity,
          color: AppColors.white,
          child: Image.network(
            widget.image,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
