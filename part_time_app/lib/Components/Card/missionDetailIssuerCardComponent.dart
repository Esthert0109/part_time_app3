import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';

class MissionDetailIssuerCardComponent extends StatefulWidget {
  final String image;
  final String title;
  final String? detail;
  final String action;
  final Function() onTap;
  const MissionDetailIssuerCardComponent({
    super.key,
    required this.image,
    required this.title,
    this.detail,
    required this.action,
    required this.onTap,
  });

  @override
  State<MissionDetailIssuerCardComponent> createState() =>
      _MissionDetailIssuerCardComponentState();
}

class _MissionDetailIssuerCardComponentState
    extends State<MissionDetailIssuerCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: kMainWhiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: kThirdGreyColor,
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(
                    widget.image!), // Provide a default image asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: missionDetailText6,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        widget.action,
                        style: missionDetailText2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
