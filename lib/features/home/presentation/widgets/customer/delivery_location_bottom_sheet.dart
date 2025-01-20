import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryLocationBottomSheet extends StatelessWidget {
  const DeliveryLocationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose delivery location",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ListView(
            shrinkWrap: true,
            children: List.generate(5, (index) {
              return ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: Text(
                  "My Apartment",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Street name, District, city",
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
                trailing: index == 1
                    ? const Icon(Icons.check_circle, color: Colors.black)
                    : null,
                onTap: () {
                  Navigator.pop(context);
                },
              );
            })
              ..add(
                ListTile(
                  leading: const Icon(Icons.my_location_outlined),
                  title: Text(
                    "Deliver to current location",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "current street, district, city",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
              ..add(
                ListTile(
                  leading: const Icon(Icons.add_location_alt_outlined),
                  title: Text(
                    "Deliver to a new address",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Go to address book",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
          ),
        ],
      ),
    );
  }
}
