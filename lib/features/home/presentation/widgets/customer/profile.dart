import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/core/utils/ui_utils.dart';
import 'package:wajeed/core/widgets/error_indicator.dart';
import 'package:wajeed/core/widgets/loading_indicator.dart';
import 'package:wajeed/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wajeed/features/auth/presentation/cubit/auth_states.dart';
import 'package:wajeed/features/home/presentation/widgets/customer/customer_order.dart';
import 'package:wajeed/features/orders/presentation/cubit/fetch_user_orders_cubit/fetch_user_orders_cubit.dart';
import 'package:wajeed/features/orders/presentation/cubit/fetch_user_orders_cubit/fetch_user_orders_states.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchUserOrdersCubit>(context).fetchUserOrders();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'My Orders'),
              Tab(text: 'Logout'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Orders Tab
            BlocBuilder<FetchUserOrdersCubit, FetchUserOrderStates>(
              builder: (context, state) {
                if (state is FetchUserOrderCubitLoading) {
                  return LoadingIndicator();
                } else if (state is FetchUserOrderCubitError) {
                  return ErrorIndicator(state.message);
                } else if (state is FetchUserOrderCubitSuccess) {
                  final orders = state.orders;

                  return Padding(
                    padding: const EdgeInsets.all(Insets.s16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Orders',
                              style: getMediumStyle(
                                color: ColorManager.black,
                              ).copyWith(
                                fontSize: FontSize.s18,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '(${orders.length})',
                              style: getMediumStyle(
                                color: ColorManager.black,
                              ).copyWith(
                                fontSize: FontSize.s14,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) => CustomerOrder(
                              order: orders[index],
                            ),
                            itemCount: orders.length,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
            // Logout Tab
            Center(
                child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) async {
                if (state is LogoutLoading) {
                  UIUtils.showLoading(context);
                } else if (state is LogoutError) {
                  UIUtils.hideLoading(context);
                  UIUtils.showMessage(
                    state.message,
                  );
                } else if (state is LogoutSuccess) {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.login,
                  );
                  final sharedPref = serviceLocator.get<SharedPreferences>();
                  await sharedPref.setBool(
                    SharedPrefKeys.isLogged,
                    false,
                  );
                }
              },
              child: InkWell(
                onTap: () {
                  serviceLocator.get<AuthCubit>().logout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: ColorManager.error,
                    ),
                    Text(
                      'Logout',
                      style: getMediumStyle(
                        color: ColorManager.error,
                      ).copyWith(
                        fontSize: FontSize.s18,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
