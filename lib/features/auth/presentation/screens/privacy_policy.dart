import 'package:flutter/material.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style:
              getBoldStyle(color: ColorManager.black, fontSize: FontSize.s20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                '''Lorem ipsum dolor sit amet consectetur.
Condimentum penatibus rhoncus ut sem orci mattis augue. Viverra varius aliquet nulla cras quis et purus mattis. Vulputate imperdiet tincidunt turpis purus nascetur vestibulum odio lectus interdum. Sit lorem lacus massa arcu cursus tristique purus risus. Non diam pretium vulputate proin cursus sagittis tellus. Imperdiet turpis egestas facilisi sit semper arcu lobortis. Amet lorem sit egestas sed. Nunc bibendum venenatis senectus integer in tortor. Eu nec massa a vivamus pellentesque. Curabitur quam tincidunt laoreet ante felis ut malesuada sapien. Amet quisque velit posuere enim duis aliquam a euismod nunc. Commodo donec vitae pellentesque posuere. Proin nisl blandit odio sit amet. Fringilla pellentesque senectus euismod enim tortor massa massa. At neque enim nisl sed. Consequat sit et id proin in cursus. Sapien eleifend non tristique elementum semper ut magna aliquet enim. Facilisis rhoncus massa a nunc adipiscing. Odio sed faucibus cras dignissim congue adipiscing nulla. Vitae porttitor viverra sem enim ac viverra at ut. Proin leo pharetra et pellentesque porttitor in eleifend in. Diam aliquam vitae ornare massa. Consectetur urna molestie lectus tristique purus sollicitudin mus ut tristique. Nulla elit rhoncus malesuada libero interdum proin.

''',
                style: getSemiBoldStyle(color: ColorManager.black).copyWith(
                  fontSize: FontSize.s16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
