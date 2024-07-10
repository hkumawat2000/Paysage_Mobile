// Import libraries
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/controllers/walkthrough_controller.dart';

import '../../../../core/utils/app_button.dart';


class WalkthroughScreen extends GetView<WalkthroughController> {
  WalkthroughScreen({super.key});

  final walkthroughController = Get.put(WalkthroughController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:30.0,top: 20),
            child: TextButton(
              onPressed: () => walkthroughController.skipWalkthrough(),
              child: Text(Strings.skip,
              style: regularTextStyle_14_gray
               // style: blue14TextStyle(),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: walkthroughController.pageController,
                onPageChanged: walkthroughController.updatePageIndex,
                itemCount: walkthroughController.walkthroughPages.length,
                itemBuilder: (context, index) => walkthroughController.walkthroughPages[index],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                walkthroughController.walkthroughPages.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AnimatedContainer(
                    margin: const EdgeInsets.all(7),
                    padding: const EdgeInsets.all(2),
                    height: 14,
                    width: 15,
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color:
                          walkthroughController.selectedPageIndex.value == index
                              ? colorWhite
                              : Colors.transparent,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                          color:
                              walkthroughController.selectedPageIndex.value ==
                                      index
                                  ? colorBlue
                                  : Colors.transparent,
                          width: 1),
                    ),
                    child: Container(
                      color: colorBlue,
                      padding: const EdgeInsets.all(2),
                    ),
                  ),
                ),
              ),
            ),
             SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            AppButton(
              buttonHeight: 52,
              buttonWidth: 170,
              onClick: walkthroughController.isLastPage
                  ? () =>
                      controller.skipWalkthrough() // Replace with your home route
                  : () => walkthroughController.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    walkthroughController.isLastPage ? Strings.getStartedTxt : Strings.nextTxt,
                    style: white14TextStyle().copyWith(fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.navigate_next, color: colorWhite)
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
