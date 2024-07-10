import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../utils/size/size_utils.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({
    super.key,
    required this.title,
    required this.imgPath,
    required this.voidCallback,
    required this.activeIndex,
  });

  final String title;
  final String imgPath;
  final bool activeIndex;
  final VoidCallback voidCallback;

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return ZoomTapAnimation(
      onTap: widget.voidCallback,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.w),
          color: widget.activeIndex ? Colors.amber : Colors.white,
        ),
        child: Row(
          children: [
            Image.asset(
              widget.imgPath,
              width: 26.w,
              color: widget.activeIndex ? Colors.white : Colors.black,
            ),
            5.getW(),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 22.w,
                color: widget.activeIndex ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
