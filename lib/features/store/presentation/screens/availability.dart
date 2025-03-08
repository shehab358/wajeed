import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/widgets/custom_elevated_button.dart';
import 'package:wajeed/core/widgets/custom_text_field.dart';

class AvailabilityPage extends StatefulWidget {
  const AvailabilityPage({super.key});

  @override
  _AvailabilityPageState createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  final List<Map<String, dynamic>> _days = [
    {
      'day': 'Monday',
      'startTime': '09:00 AM',
      'endTime': '10:00 PM',
      'isAvailable': true
    },
    {
      'day': 'Tuesday',
      'startTime': '09:00 AM',
      'endTime': '10:00 PM',
      'isAvailable': true
    },
    {
      'day': 'Wednesday',
      'startTime': '09:00 AM',
      'endTime': '10:00 PM',
      'isAvailable': true
    },
    {
      'day': 'Thursday',
      'startTime': '09:00 AM',
      'endTime': '10:00 PM',
      'isAvailable': true
    },
    {
      'day': 'Friday',
      'startTime': '09:00 AM',
      'endTime': '10:00 PM',
      'isAvailable': true
    },
    {
      'day': 'Saturday',
      'startTime': '09:00 AM',
      'endTime': '10:00 PM',
      'isAvailable': true
    },
    {
      'day': 'Sunday',
      'startTime': '09:00 AM',
      'endTime': '10:00 PM',
      'isAvailable': true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        centerTitle: true,
        title: Text(
          'Availability',
          style: getBoldStyle(
            color: ColorManager.black,
            fontSize: FontSize.s16,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _days.length,
                itemBuilder: (context, index) {
                  final day = _days[index];
                  return Column(
                    children: [
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              day['day'],
                              style: getRegularStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s18,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        label: 'Start time',
                                        readOnly: true,
                                        controller: TextEditingController(
                                            text: day['startTime']),
                                        onChanged: (value) =>
                                            day['startTime'] = value,
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomTextField(
                                        readOnly: true,
                                        label: 'End time',
                                        controller: TextEditingController(
                                            text: day['endTime']),
                                        onChanged: (value) =>
                                            day['endTime'] = value,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 26.h),
                                child: Switch(
                                  activeColor: ColorManager.white,
                                  activeTrackColor: ColorManager.green,
                                  value: day['isAvailable'],
                                  onChanged: (value) {
                                    setState(() {
                                      day['isAvailable'] = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0.h,
                      ),
                    ],
                  );
                },
              ),
            ),
            CustomElevatedButton(
              backgroundColor: ColorManager.starRate,
              label: 'Save',
              textStyle: getBoldStyle(
                  color: ColorManager.white, fontSize: FontSize.s18),
              onTap: () {
                log('Availability saved: $_days');
              },
            ),
          ],
        ),
      ),
    );
  }
}
