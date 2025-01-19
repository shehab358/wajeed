import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wajeed/core/constants.dart';
import 'package:wajeed/core/di/service_locator.dart';
import 'package:wajeed/core/resources/assets_manager.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/routes/routes.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({super.key});

  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildPage(
                  imagePath: ImageAssets.firstWalkthrough,
                ),
                _buildPage(
                  imagePath: ImageAssets.secondWalkthrough,
                ),
                _buildPage(
                  imagePath: ImageAssets.thirdWalkthrough,
                ),
              ],
            ),
          ),
          Container(
            height: 400.h,
            decoration: BoxDecoration(
              color: ColorManager.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  30.r,
                ),
                topRight: Radius.circular(
                  30.r,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    _currentPage == 0
                        ? '    Search Your\n Favourite Food'
                        : _currentPage == 1
                            ? 'Browse Your\n       Menu'
                            : 'Get Fastest \n    Delivery',
                    style: getSemiBoldStyle(
                      color: ColorManager.white,
                      fontSize: FontSize.s24,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        width: _currentPage == index ? 12.w : 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? ColorManager.white
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 4,
                  ),
                  CustomElevatedButton(
                    label: _currentPage < 2 ? "Next" : "Get Started",
                    textStyle: getBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s18),
                    onTap: () async {
                      if (_currentPage < 2) {
                        _pageController.nextPage(
                          duration: Duration(
                            milliseconds: 100,
                          ),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.select,
                        );
                        final sharedPref =
                            serviceLocator.get<SharedPreferences>();
                        await sharedPref.setBool('isWalkedthrough', true);
                      }
                    },
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String imagePath,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 16.w, top: 50.h),
          child: Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () async {
                  Navigator.pushReplacementNamed(
                    context,
                    Routes.select,
                  );
                  final sharedPref = serviceLocator.get<SharedPreferences>();
                  await sharedPref.setBool(
                    SharedPrefKeys.isWalkedthrough,
                    true,
                  );
                },
                child: CircleAvatar(
                  backgroundColor: ColorManager.grey.withOpacity(0.2),
                  radius: 20.r,
                  child: Icon(Icons.close, color: ColorManager.black),
                ),
              ),
            ],
          ),
        ),
        Image.asset(
          imagePath,
          height: 350.h,
        ),
        Spacer(),
      ],
    );
  }
}
