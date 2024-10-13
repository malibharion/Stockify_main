import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerledgerBtn extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const CustomerledgerBtn({
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: Center(
            child: Text(
              "${text}",
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
            ),
          )),
    );
  }
}
