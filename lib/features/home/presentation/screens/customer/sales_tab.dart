import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/widgets/error_indicator.dart';
import 'package:wajeed/core/widgets/loading_indicator.dart';
import 'package:wajeed/features/home/presentation/widgets/customer/resturant.dart';

import 'package:wajeed/features/store/presentation/cubit/all_stores_get_cubit/all_stores_get_cubit.dart';
import 'package:wajeed/features/store/presentation/cubit/all_stores_get_cubit/all_stores_get_states.dart';

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
              BlocBuilder<AllStoresGetCubit, AllStoresGetStates>(
                builder: (context, state) {
                  if (state is AllStoresGetLoading) {
                    return LoadingIndicator();
                  } else if (state is AllStoresGetError) {
                    return ErrorIndicator(state.message);
                  } else if (state is AllStoresGetSuccess) {
                    final salesStore = state.stores
                        .where((store) => store.isSales == 'Yes')
                        .toList();
                    log(salesStore.length.toString());
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => Resturant(
                          store: salesStore[index],
                        ),
                        itemCount: salesStore.length,
                        separatorBuilder: (context, index) => Divider(),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
