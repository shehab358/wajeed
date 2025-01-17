import 'package:flutter/material.dart';
import 'package:wajeed/core/resources/color_manager.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorManager.primary,
      ),
    );
  }
}
