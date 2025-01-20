import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';
import 'package:wajeed/features/home/presentation/widgets/customer/delivery_location_bottom_sheet.dart';
import 'package:wajeed/features/home/presentation/widgets/customer/filter.dart';
import 'package:wajeed/features/home/presentation/widgets/resturant.dart';

class SalesTab extends StatelessWidget {
  const SalesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.s16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Delevirng to',
                            style: getRegularStyle(
                              color: ColorManager.grey,
                            ).copyWith(
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        child: Row(
                          children: [
                            Text(
                              'KAFD Al Aqiq, Riyadh',
                              style: getMediumStyle(
                                color: ColorManager.black,
                              ).copyWith(
                                fontSize: FontSize.s18,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down_outlined),
                              color: ColorManager.black,
                              onPressed: () => _showDeliveryLocationBottomSheet(
                                context,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: ColorManager.primary,
                    foregroundColor: ColorManager.black,
                    child: Text(
                      'H',
                      style: getBoldStyle(
                        color: ColorManager.black,
                      ).copyWith(
                        fontSize: FontSize.s18,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hint: 'Search',
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    width: 50.w,
                    margin: EdgeInsets.only(left: Insets.s12),
                    decoration: BoxDecoration(
                      color: ColorManager.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.filter_list,
                      ),
                      onPressed: () => _showFilter(context),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => Resturant(),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: 4,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _showDeliveryLocationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => const DeliveryLocationBottomSheet(),
  );
}

void _showFilter(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => const Filter(),
  );
}
