import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';

class Rating extends StatelessWidget {
  const Rating({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Insets.s16),
      height: 140.h,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: ColorManager.containerGray,
                child: Text('J'),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John',
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: Sizes.s20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '05/05/2021',
                    style: getRegularStyle(
                      color: ColorManager.grey,
                      fontSize: Sizes.s12.sp,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: ColorManager.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: ColorManager.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: ColorManager.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: ColorManager.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: ColorManager.yellow,
                      ),
                    ],
                  ),
                  Text(
                    '4.5 rating',
                    style: getRegularStyle(
                      color: ColorManager.black,
                      fontSize: Sizes.s12.sp,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'The food was delicious and the service was great The food was delicious and the service was greatThe food was delicious and the service was greatThe food was delicious and the service was great',
            style: getRegularStyle(
              color: ColorManager.black,
              fontSize: Sizes.s14.sp,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
