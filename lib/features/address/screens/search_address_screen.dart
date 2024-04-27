import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:delivery_app/features/address/providers/address_provider.dart';
import 'package:delivery_app/features/address/widgets/input_search_address.dart';
import 'package:delivery_app/features/shared/widgets/back_button.dart';
import 'package:delivery_app/features/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const double heightBottomSheet = 380;

class SearchAddressScreen extends ConsumerStatefulWidget {
  const SearchAddressScreen({super.key});

  @override
  SearchAddressScreenState createState() => SearchAddressScreenState();
}

class SearchAddressScreenState extends ConsumerState<SearchAddressScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.invalidate(searchAddressProvider);
      _focusNode.requestFocus();
    });
  }

  @override
  void deactivate() {
    ref.invalidate(searchAddressProvider);
    super.deactivate();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final searchAddressState = ref.watch(searchAddressProvider);
    final showResults = searchAddressState.addressResults.isNotEmpty;
    final noResults = !searchAddressState.loadingAddresses &&
        searchAddressState.addressResults.isEmpty &&
        searchAddressState.search != '';

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            height: 60,
            child: Row(
              children: [
                const CustomBackButton(),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InputSearchAddress(
                    value: searchAddressState.search,
                    onChanged: (value) {
                      ref
                          .read(searchAddressProvider.notifier)
                          .changeSearch(value);
                    },
                    focusNode: _focusNode,
                  ),
                ),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
            ),
          ),
          if (searchAddressState.loadingAddresses)
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: Center(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          if (showResults)
            SliverPadding(
              padding: const EdgeInsets.only(),
              sliver: SliverList.separated(
                itemBuilder: (context, index) {
                  final result = searchAddressState.addressResults[index];
                  return SizedBox(
                    height: 80,
                    child: TextButton(
                      onPressed: () {
                        context.push('/address-map');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  result.properties.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.label2,
                                    leadingDistribution:
                                        TextLeadingDistribution.even,
                                  ),
                                ),
                                Text(
                                  result.properties.placeFormatted ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.label,
                                    height: 1,
                                    leadingDistribution:
                                        TextLeadingDistribution.even,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    color: AppColors.gray50,
                  );
                },
                itemCount: searchAddressState.addressResults.length,
              ),
            ),
          if (noResults)
            const SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Icon(
                    Icons.search,
                    size: 80,
                    color: AppColors.label2,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'No Results',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.label2,
                      height: 1.1,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 20,
                bottom: 40,
              ),
              child: CustomButton(
                width: double.infinity,
                onPressed: () async {
                  try {
                    ref
                        .read(searchAddressProvider.notifier)
                        .getCurrentPosition();
                    await context.push('/address-map');
                  } catch (e) {}
                },
                text: 'SEARCH ADDRESS OVER THE MAP',
              ),
            ),
          )
        ],
      ),
    );
  }
}
