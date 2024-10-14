import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/contact_us/presentation/controllers/contact_us_controller.dart';

import '../../../../core/assets/assets_image_path.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/utils/common_widgets.dart';
import '../../../../core/utils/style.dart';
import '../../../../core/utils/utility.dart';

class ContactUsView extends GetView<ContactUsController>{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorBg,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: colorBg,
          leading: IconButton(
            icon: ArrowToolbarBackwardNavigation(),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      headingText(Strings.contact_us),
                      SizedBoxHeightWidget(20.0),
                      Text(
                        Strings.contact_us_msg,
                        style: TextStyle(color: colorBlack, fontSize: 18),
                      ),
                      SizedBox(height: 30),
                      Text(Strings.write_us,style: boldTextStyle_24.copyWith(color: colorBlack)),
                      SizedBox(height: 10),
                      messageField(),
                      SizedBox(height: 30),
                      Center(
                        child: Container(
                          height: 50,
                          width: 140,
                          alignment: Alignment.center,
                          child: Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            elevation: 4.0,
                            color: controller.messageController!.text.length < 10? colorGrey : appTheme,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: controller.messageController!.text.length < 10 ? null :() {
                                Utility.isNetworkConnection().then((isNetwork) {
                                  if (isNetwork) {
                                    // contactUsAPI();
                                  } else {
                                    Utility.showToastMessage(Strings.no_internet_message);
                                  }
                                });
                              },
                              child: Text(
                                Strings.submit,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      advertiseCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget messageField() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      obscureText: false,
      controller: controller.messageController,
      style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
      decoration: new InputDecoration(
        counterText: "",
        hintText: Strings.message,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
        focusColor: Colors.grey,
        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: colorBlack),
        ),
      ),
      maxLines: 10,
      minLines: 3,
      keyboardType: TextInputType.multiline,
      onChanged: (value){

      },
    );
  }

  Widget advertiseCard() {
    return Center(
      child: Card(
        elevation: 2.0,
        color: colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Container(
          width: 300,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                // height: 80,
                // width: 80,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: new BoxDecoration(
                  color: colorBg,
                  borderRadius: new BorderRadius.all(Radius.circular(60.0)),
                ),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    AssetsImagePath.lms_logo,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                Strings.lms,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: appTheme),
              ),
              SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }

}