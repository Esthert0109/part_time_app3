import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Constants/textStyleConstant.dart';
import '../../Model/Category/categoryModel.dart';

class CategoryItem extends StatelessWidget {
  final List<CategoryListData> list;
  final List<Widget Function()> onTapCallbacks;

  CategoryItem({
    required this.list,
    required this.onTapCallbacks,
  });
  Widget _buildCategoryComponent(
    CategoryListData category,
    VoidCallback onTapCallback,
  ) {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: onTapCallback,
        child: Column(
          children: [
            SvgPicture.network(category.categoryAvatar),
            SizedBox(height: 10),
            Text(
              category.categoryName,
              style: messageText1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 17),
      child: Row(
        children: List.generate(
          list.length,
          (index) {
            return _buildCategoryComponent(
              list[index],
              () {
                Get.to(onTapCallbacks[index],
                    transition: Transition.rightToLeft);
              },
            );
          },
        ),
      ),
    );
  }
}
