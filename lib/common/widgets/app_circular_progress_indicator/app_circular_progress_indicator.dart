import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 2.r,
          ),
        ],
      ),
    );
  }
}
