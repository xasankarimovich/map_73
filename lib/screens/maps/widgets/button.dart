import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/images/app_images.dart';
import 'category_button.dart';

buttons({
  required ValueChanged<String> image
}){
  List<String> list = ["Home", "Work", "Other"];
  List<String> listImage = [
    AppImages.home,
    AppImages.work,
    AppImages.other,
  ];
  int activeIndex = -1;
  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          list.length,
              (index) => CategoryButton(
            title: list[index],
            imgPath: listImage[index],
            voidCallback: () {
              activeIndex = index;
              setState(() {});
              image.call(
                listImage[index],
              );
            },
            activeIndex: activeIndex == index,
          ),
        ),
      );
    },
  );
}

