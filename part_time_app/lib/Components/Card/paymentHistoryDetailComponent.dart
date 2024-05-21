import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

import '../../Constants/colorConstant.dart';
import '../../Constants/textStyleConstant.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentHistoryDetailComponent extends StatefulWidget {
  String? condition;
  String? missionTitle;
  String? missionID;
  String? receiverName;
  String? date;
  String? walletNetwork;
  String? walletAddress;
  String? image;
  String? receiptURL;
  double? amount;
  double? fee;
  double? totalAmount;

  PaymentHistoryDetailComponent(
      {this.condition,
      this.missionTitle,
      this.missionID,
      this.receiverName,
      this.date,
      this.walletNetwork,
      this.walletAddress,
      this.image,
      this.receiptURL,
      this.amount,
      this.fee,
      this.totalAmount});

  @override
  State<PaymentHistoryDetailComponent> createState() =>
      _PaymentHistoryDetailComponentState();
}

class _PaymentHistoryDetailComponentState
    extends State<PaymentHistoryDetailComponent> {
  XFile? receiptImage;

  Widget _buildTitle(String text) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style: dialogText2,
      ),
    );
  }

  Widget _buildPurpose(String text) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        style: userProfileMenuTextStyle,
      ),
    );
  }

  Widget _buildCalculationRow(String leftText, String rightText) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            leftText,
            style: forgotPassSubmitTextStyle,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            rightText + " USDT",
            style: forgotPassSubmitTextStyle,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildText1(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 8, 0, 5),
      child: Text(
        text,
        style: userProfileMenuTextStyle,
      ),
    );
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.missionID!));
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    try {
      if (!await canLaunch(_url.toString())) {
        throw Exception('Could not launch $_url');
      }
      await launch(_url.toString());
    } catch (e) {
      // If url_launcher fails, try to open the URL using dart:io
      try {
        await launch(url);
      } catch (e) {
        throw Exception('Could not launch $_url: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // A方支付押金：000
    // A方押金退还：001
    // A方悬赏退还：110
    // A方悬赏支付：010
    // B方悬赏收款：011
    Widget title = Container();
    Widget purpose = Container();
    Widget calculation = Container();

    switch (widget.condition) {
      //A方支付悬赏
      case "010":
        title = _buildTitle('支付成功');
        purpose = _buildPurpose('支付悬赏金额');
        //this is different style.
        calculation = Container(
          child: Row(
            children: [
              Container(
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "押金预付",
                        style: messageTitleTextStyle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: Text(
                          "手续费 1%",
                          style: messageTitleTextStyle,
                        ),
                      ),
                      Text(
                        "预付共计",
                        style: forgotPassSubmitTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "共记 ${widget.amount.toString()}",
                        style: depositTextStyle3,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Text(
                            "${widget.fee}",
                            style: messageTitleTextStyle,
                          )),
                      Text(
                        "${widget.totalAmount}",
                        style: forgotPassSubmitTextStyle,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
        break;
      //A方悬赏退还
      case "110":
        title = _buildTitle('退款成功');
        purpose = _buildPurpose('退还悬赏金额');
        calculation = _buildCalculationRow("共记", widget.amount.toString());
        break;
      //B方悬赏收款
      case "011":
        title = _buildTitle('收款成功');
        purpose = _buildPurpose('支付悬赏金额');
        calculation = _buildCalculationRow("共记", widget.amount.toString());
        break;
      //A方支付押金
      case "000":
        title = _buildTitle('支付成功');
        purpose = _buildPurpose('押金支付');
        calculation = _buildCalculationRow("共记", widget.amount.toString());
        break;
      //A方押金退还
      case "100":
        title = _buildTitle('退款成功');
        purpose = _buildPurpose('押金退还');
        calculation = _buildCalculationRow("共记", widget.amount.toString());
        break;
      //unknow condition
      default:
        title = _buildTitle('未知');
        widget.receiverName = "未知";
        purpose = _buildPurpose('未知');
        calculation = _buildCalculationRow("共记", "0");
        break;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: kMainWhiteColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  Text("交易用途", style: depositTextStyle2),
                  purpose,
                  SizedBox(height: 8),
                  Text("悬赏标题", style: depositTextStyle2),
                  _buildText1(widget.missionTitle ?? ""),
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            "悬赏ID: ",
                            style: missionDetailImgNumTextStyle,
                          ),
                          Text(
                            widget.missionID ?? "",
                            style: missionDetailImgNumTextStyle,
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                              onTap: _copyToClipboard,
                              child: SvgPicture.asset("assets/common/copy.svg",
                                  width: 15))
                        ],
                      )),
                  SizedBox(height: 18),
                  Text("收款人姓名", style: depositTextStyle2),
                  _buildText1(widget.receiverName ?? ""),
                  SizedBox(height: 18),
                  Text("日期", style: depositTextStyle2),
                  _buildText1(widget.date ?? ""),
                  SizedBox(height: 18),
                  Text("收款信息", style: depositTextStyle2),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "USDT 链名称：",
                          style: inputCounterTextStyle,
                        ),
                        SizedBox(height: 5),
                        Text(widget.walletNetwork ?? "",
                            style: userProfileMenuTextStyle),
                        SizedBox(height: 12),
                        Text(
                          "USDT 链地址：",
                          style: inputCounterTextStyle,
                        ),
                        SizedBox(height: 5),
                        Text(widget.walletAddress ?? "",
                            style: userProfileMenuTextStyle),
                        SizedBox(height: 20),
                        Container(
                          height: 300,
                          width: 310,
                          child: GestureDetector(
                            onTap: () {
                              // Add code to show enlarged image in a dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Container(
                                      width: double.infinity,
                                      height: 300,
                                      child: PhotoView(
                                        imageProvider: widget.image != null
                                            ? NetworkImage(widget.image ?? "")
                                            : AssetImage(
                                                    "assets/common/demophoto.svg")
                                                as ImageProvider,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          // If an error occurs while loading the image, display the placeholder image
                                          return Center(
                                            child: SvgPicture.asset(
                                              "assets/common/demophoto.svg",
                                              height: 300,
                                              width: 300,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: widget.image != null
                                ? Image.network(
                                    widget.image ??
                                        "assets/common/demophoto.svg",
                                    fit: BoxFit.cover,
                                  )
                                : Center(
                                    child: SvgPicture.asset(
                                      "assets/common/demophoto.svg",
                                      height: 300,
                                      width: 300,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 18),
                        Text("交易链接", style: depositTextStyle2),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 5),
                            child: GestureDetector(
                              onTap: () => _launchUrl(widget.receiptURL!),
                              child: Text(
                                widget.receiptURL ?? "",
                                style: depositURLTextStyle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                        SizedBox(height: 18),
                        calculation
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void launchURL(String s) {}
}
