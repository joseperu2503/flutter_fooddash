import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FavoriteSwitch extends StatefulWidget {
  const FavoriteSwitch({
    super.key,
    required this.pageController,
    required this.width,
  });

  final PageController pageController;
  final double width;

  @override
  State<FavoriteSwitch> createState() => _FavoriteSwitchState();
}

class _FavoriteSwitchState extends State<FavoriteSwitch> {
  @override
  void initState() {
    widget.pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  double get left {
    return 4 +
        (widget.pageController.position.pixels *
            (((widget.width - 4) / 2) - 4) /
            widget.pageController.position.maxScrollExtent);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    double velocity = details.primaryVelocity ?? 0;
    if (velocity > 0) {
      // Swiped Left
      int nextPage = (widget.pageController.page?.round() ?? 0) + 1;
      if (nextPage < 2) {
        widget.pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    } else if (velocity < 0) {
      // Swiped Right
      int prevPage = (widget.pageController.page?.round() ?? 0) - 1;
      if (prevPage >= 0) {
        widget.pageController.animateToPage(
          prevPage,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: GestureDetector(
        onHorizontalDragEnd: _onHorizontalDragEnd,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xffF2EAEA),
            ),
          ),
          width: widget.width,
          height: 55,
          child: Stack(
            children: [
              if (widget.pageController.hasClients)
                Positioned(
                  left: left,
                  top: 4,
                  child: Container(
                    width: (widget.width - 2 * 4) / 2,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFE724C),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              if (widget.pageController.hasClients)
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: widget.pageController.page?.round() == 0
                                  ? const Color(0xffEFEFEF)
                                  : AppColors.orange,
                              height: 1,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                            child: const Text(
                              'Dishes',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: widget.pageController.page?.round() == 1
                                  ? const Color(0xffEFEFEF)
                                  : AppColors.orange,
                              height: 1,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                            child: const Text(
                              'Restaurants',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
