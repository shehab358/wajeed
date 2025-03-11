import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/features/home/presentation/widgets/customer/resturant_product.dart';
import 'package:wajeed/features/product/presentation/cubit/fetch_all_products_cubit/fetch_all_products_cubit.dart';
import 'package:wajeed/features/product/presentation/cubit/fetch_all_products_cubit/fetch_all_products_states.dart';
import 'package:wajeed/features/store/domain/entities/store.dart';

class Resturant extends StatefulWidget {
  final Store store;
  const Resturant({super.key, required this.store});

  @override
  State<Resturant> createState() => _ResturantState();
}

class _ResturantState extends State<Resturant> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              ImageAssets.mcdonalds,
              height: 70.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.store.name,
                  style: getBoldStyle(
                    color: ColorManager.black,
                  ).copyWith(
                    fontSize: FontSize.s18,
                  ),
                ),
                Text(
                  widget.store.tagline,
                  style: getRegularStyle(
                    color: ColorManager.black,
                  ).copyWith(
                    fontSize: FontSize.s16,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Insets.s8),
                      width: 70.w,
                      decoration: BoxDecoration(
                        color: ColorManager.lightpurple,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: ColorManager.starRate,
                          ),
                          Text(
                            '4.5',
                            style: getMediumStyle(color: ColorManager.starRate)
                                .copyWith(fontSize: FontSize.s16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Insets.s8),
                      width: 120.w,
                      decoration: BoxDecoration(
                        color: ColorManager.lightpurple,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            IconsAssets.delivery,
                            height: 18.h,
                            color: ColorManager.starRate,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'EGP ${widget.store.minimumOrderCost}',
                            style: getMediumStyle(color: ColorManager.starRate)
                                .copyWith(fontSize: FontSize.s16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.store,
                  arguments: widget.store,
                );
              },
              child: Text(
                'See all',
                style: getRegularStyle(
                  color: ColorManager.starRate,
                ).copyWith(
                  fontSize: FontSize.s16,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
          height: 170.h,
          child: BlocBuilder<FetchAllProductsCubit, FetchAllProductsStates>(
            builder: (context, state) {
              if (state is FetchAllProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchAllProductsError) {
                return Center(child: Text(state.message));
              } else if (state is FetchAllProductsSuccess) {
                final products = state.products;

                return ListView.builder(
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ResturantProduct(
                    product: products[index],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
