import 'package:fooddash/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputSearchDashboard extends StatelessWidget {
  const InputSearchDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: 70,
      pinned: true,
      flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 70,
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 51,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFCFCFD),
                    border: Border.all(
                      color: const Color(0xffEFEFEF),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/search.svg',
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Expanded(
                        child: Text(
                          'Find for food or restaurant...',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff9AA0B4),
                            height: 14 / 14,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              Container(
                height: 51,
                width: 51,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffE9EDF2).withOpacity(0.5),
                      offset: const Offset(
                          0, 15), // Desplazamiento horizontal y vertical
                      blurRadius: 30, // Radio de desenfoque
                      spreadRadius: 0, // Extensión de la sombra
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/tune.svg',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
