import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:part_time_app/Components/Button/PrimaryButtonComponent.dart';
import 'package:part_time_app/Constants/colorConstant.dart';
import 'package:shimmer/shimmer.dart';
import '../../Constants/textStyleConstant.dart';

class EditProfilePageLoadingComponent extends StatefulWidget {
  const EditProfilePageLoadingComponent({super.key});

  @override
  State<EditProfilePageLoadingComponent> createState() =>
      _EditProfilePageLoadingComponentState();
}

class _EditProfilePageLoadingComponentState
    extends State<EditProfilePageLoadingComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Shimmer.fromColors(
          baseColor: kMainLoadingColor,
          highlightColor: kSecondaryLoadingColor,
          enabled: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kMainWhiteColor,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 300),
                      child: _TextTitleLoading(),
                    ),
                    _TextFieldLoading(),
                    SizedBox(height: 15),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Container(
                                  margin: EdgeInsets.only(right: 80),
                                  child: _TextTitleLoading())),
                          SizedBox(width: 10),
                          Expanded(
                              flex: 4,
                              child: Container(
                                  margin: EdgeInsets.only(right: 70),
                                  child: _TextTitleLoading())),
                          SizedBox(width: 10),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: _TextTitleLoading())),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: _TextFieldLoading(),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: _TextFieldLoading(),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: _TextFieldLoading(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(right: 300),
                      child: _TextTitleLoading(),
                    ),
                    _TextFieldLoading(),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(right: 300),
                      child: _TextTitleLoading(),
                    ),
                    _TextFieldLoading(),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(right: 250),
                      child: _TextTitleLoading(),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 66,
                          child: _TextFieldLoading(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: _TextFieldLoading(),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(right: 250),
                      child: _TextTitleLoading(),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 66,
                          child: _TextFieldLoading(),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: _TextFieldLoading(),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(right: 300),
                      child: _TextTitleLoading(),
                    ),
                    _TextFieldLoading(),
                    SizedBox(height: 5),
                    _TextFieldLoading(),
                    SizedBox(height: 5),
                    _TextFieldLoading(),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(right: 280),
                      child: _TextTitleLoading(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      height: 46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: kMainWhiteColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _TextFieldLoading() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: kMainWhiteColor,
      ),
    );
  }

  Widget _TextTitleLoading() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: kMainWhiteColor,
      ),
    );
  }
}
