import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePageDetailsWidget extends StatelessWidget {
  const HomePageDetailsWidget({
    this.image,
    this.value,
    this.onTap,
    this.fontSize,
    this.isActive = false,
    super.key,
  });

  final String? image;
  final String? value;
  final double? fontSize;
  final void Function()? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: AnimatedOpacity(
        opacity: isActive ? 1 : 0.5, // Dims if not active
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: 28.w, // Dynamic width
          height: 14.h, // Dynamic height
          padding: EdgeInsets.all(0.5.h),
          decoration: BoxDecoration(
            color: isActive ? Color(0xFFF2EACE) : Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.black26),
            boxShadow: isActive
                ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image!,
                height: 6.h, // Dynamic image size
                fit: BoxFit.contain,
              ),
              SizedBox(height: 1.h),
              Text(
                value!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize?.h ?? 1.5.h,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF7f6400),
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        )

      ),
    );
  }
}

