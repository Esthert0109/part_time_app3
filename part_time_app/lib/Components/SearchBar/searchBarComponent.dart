import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:part_time_app/Pages/Search/sortPage.dart';

import '../../Constants/textStyleConstant.dart';
import '../../Pages/Search/searchResultPage.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({super.key});

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  final TextEditingController searchController = TextEditingController();
  String searchText = "";
  FocusNode focusNode = FocusNode();
  bool isSearching = false;
  Color buttonColor = kMainBlackColor;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        isSearching = focusNode.hasFocus;
        if (!isSearching) {
          searchController.clear();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 85,
          child: Container(
            height: 34,
            margin: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
                color: kMainWhiteColor,
                borderRadius: BorderRadius.circular(17),
                border: Border.all(width: 1.6, color: kMainBlackColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 90,
                  child: Container(
                    height: 34,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: TextField(
                      controller: searchController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        hintText: "根据职位关键词搜索",
                        hintStyle: searchBarHintTextStyle,
                        border: InputBorder.none,
                        counterText: "",
                      ),
                      style: searchBarTextStyle,
                      cursorHeight: 20,
                      cursorColor: kMainYellowColor,
                      maxLength: 20,
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                          isSearching = true;
                        });
                      },
                      onSubmitted: (searchText) {
                        if (searchText.isNotEmpty && searchText != "") {
                          searchController.clear();
                          searchText = "";
                          isSearching = false;
                        }
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 18,
                  child: GestureDetector(
                    onTapDown: (_) {
                      String searchText = searchController.text;
                      setState(() {
                        buttonColor = kSearchBarPressedColor;
                        if (searchText.isNotEmpty && searchText != "") {
                          print(searchText);
                          Get.to(
                              () => SearchResultPage(
                                    searchKeyword: searchText,
                                    byTag: false,
                                  ),
                              transition: Transition.rightToLeft);
                          setState(() {
                            searchController.clear();
                            focusNode.unfocus();
                            isSearching = false;
                          });
                        }
                        focusNode.unfocus();
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        buttonColor = kMainBlackColor;
                      });
                    },
                    child: Container(
                      width: 41,
                      height: 26,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(13.5)),
                      child: Center(
                        child: SvgPicture.asset(
                            "assets/recommendation/searchButton.svg"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Flexible(
          flex: 14,
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: isSearching
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isSearching = false;
                          if (searchText.isNotEmpty && searchText != "") {
                            searchController.clear();
                            searchText = "";
                          }
                          focusNode.unfocus();
                        });
                      },
                      child: const Text(
                        "取消",
                        style: searchBarCancelTextStyle,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => SortPage(),
                              transition: Transition.rightToLeft);
                        },
                        child: SvgPicture.asset(
                          "assets/recommendation/category.svg",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    )),
        )
      ],
    );
  }
}
