import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/auth/providers/auth_provider.dart';
import 'package:delivery_app/features/dashboard/data/categories.dart';
import 'package:delivery_app/features/dashboard/data/restaurants.dart';
import 'package:delivery_app/features/dashboard/widgets/restaurant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: 50,
              floating: true,
              flexibleSpace: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary50,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/map_pin.svg',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Current location',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.gray500,
                                height: 1.5,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                        Text(
                          'Jl. Soekarno Hatta 15A...',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray900,
                            height: 1.5,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        color: AppColors.primary500,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary500,
                          elevation: 3,
                        ),
                        onPressed: () {
                          context.push('/cart');
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/tabs/cart_outlined.svg',
                              colorFilter: const ColorFilter.mode(
                                AppColors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Text(
                              '1',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverAppBar(
              scrolledUnderElevation: 0,
              backgroundColor: AppColors.white,
              automaticallyImplyLeading: false,
              toolbarHeight: 80,
              pinned: true,
              flexibleSpace: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                height: 80,
                child: Center(
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: AppColors.gray300,
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
                            'Search menu, restaurant or etc',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.gray600,
                              height: 1.5,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/tune.svg',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(
                  top: 16,
                ),
                height: 142,
                child: Container(
                  height: 142,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary400,
                    gradient: const LinearGradient(colors: [
                      AppColors.primary500,
                      AppColors.primary500,
                      AppColors.primary200,
                    ], stops: [
                      0,
                      0.2,
                      1
                    ]),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Claim your\ndiscount 30%\ndaily now!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                                height: 19 / 16,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                            const Spacer(),
                            FilledButton(
                              onPressed: () {
                                ref
                                    .read(authProvider.notifier)
                                    .setAuthStatus(AuthStatus.authenticated);
                              },
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                backgroundColor: AppColors.gray900,
                              ),
                              child: const Text(
                                'Order now',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                  height: 14.4 / 12,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned(
                              right: 24,
                              top: -30,
                              child: Transform.flip(
                                flipX: true,
                                child: Image.asset(
                                  'assets/images_prueba/icecream.png',
                                  height: 225,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 24,
                      right: 24,
                    ),
                    child: const Text(
                      'Top Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray900,
                        height: 1.5,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Image.network(
                                    category.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              category.name,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.gray800,
                                height: 1,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: categories.length,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      'Recommended',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray900,
                        height: 1.5,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              sliver: SliverList.separated(
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return RestaurantItem(restaurant: restaurant);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 28,
                  );
                },
                itemCount: restaurants.length,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            )
          ],
        ),
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     const Center(
      //       child: Text('Home Screen'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         ref
      //             .read(authProvider.notifier)
      //             .setAuthStatus(AuthStatus.notAuthenticated);
      //       },
      //       child: const Text('Logout'),
      //     )
      //   ],
      // ),
    );
  }
}
