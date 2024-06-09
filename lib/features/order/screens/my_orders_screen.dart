import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/order/widgets/order_switch.dart';
import 'package:delivery_app/features/restaurant/data/menu.dart';
import 'package:delivery_app/features/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  OrderType orderType = OrderType.upcoming;

  @override
  Widget build(BuildContext context) {
    final dishes = staticMenu[0].dishes;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: 60,
            child: const Row(
              children: [
                Spacer(),
                Text(
                  'My Orders',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.input,
                    height: 1,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: 8,
              ),
              child: OrderSwitch(
                orderType: orderType,
                onChange: (value) {
                  setState(() {
                    orderType = value;
                  });
                },
                width: MediaQuery.of(context).size.width - 2 * 24,
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 24,
                      bottom: 30,
                    ),
                    sliver: SliverList.separated(
                      itemBuilder: (context, index) {
                        return const UpcomingOrderItem();
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          height: 20,
                        );
                      },
                      itemCount: dishes.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum OrderType { upcoming, history }

class UpcomingOrderItem extends StatelessWidget {
  const UpcomingOrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffD3D1D8).withOpacity(0.25),
            offset: const Offset(18.21, 18.21),
            blurRadius: 36.43,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 65,
                height: 65,
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(11.48),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffD3D1D8).withOpacity(0.45),
                      offset: const Offset(11.48, 17.22),
                      blurRadius: 22.96,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(
                    'https://www.edigitalagency.com.au/wp-content/uploads/starbucks-logo-png.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3 Items',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.label,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Starbuck',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                '#264100',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.orange,
                  height: 1,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estimated Arrival',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.label,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '25',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: AppColors.input,
                          height: 1,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                      Text(
                        ' min',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.input,
                          height: 2,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Now',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.label,
                      height: 1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Food on the way',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.input,
                      height: 19.6 / 14,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 43,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffD3D1D8).withOpacity(0.25),
                        offset: const Offset(0, 20),
                        blurRadius: 30,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      minimumSize: const Size(
                        double.infinity,
                        60,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      backgroundColor: AppColors.white,
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.input,
                        height: 15 / 15,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 17,
              ),
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    context.push('/order');
                  },
                  text: 'Track Order',
                  height: 43,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
