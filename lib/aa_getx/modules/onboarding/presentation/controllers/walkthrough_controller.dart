import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/arguments/tutotrials_arguments.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/views/widgets/walkthrough_widget.dart';
import 'package:lms/util/Preferences.dart';

class WalkthroughController extends GetxController {
  RxList<WalkthroughPage> walkthroughPages = <WalkthroughPage>[].obs;
  Preferences _preferences = Preferences();
  final pageController = PageController();
  var selectedPageIndex = 0.obs;

  void updatePageIndex(int index) => selectedPageIndex.value = index;

  bool get isLastPage => selectedPageIndex.value == walkthroughPages.length - 1;

  void skipWalkthrough() async {
    await _preferences.setIsVisitTutorial("true");
    Get.offNamed(loginView);
  }

  @override
  void onInit() {
    final TutotrialsArguments _tutorialsArguments = Get.arguments;

    for(int i=0; i< _tutorialsArguments.onboardingDataEntity.length; i++){
      walkthroughPages.add(
          WalkthroughPage(
            title: _tutorialsArguments.onboardingDataEntity[i].title!,
            description:_tutorialsArguments.onboardingDataEntity[0].description!,
            imageAsset: i == 0 ? AssetsImagePath.tutorial_1 :
            i == 1 ? AssetsImagePath.updateKyc :
            i == 2 ? AssetsImagePath.tutorial_3 :
            i == 3 ? AssetsImagePath.tutorial_4 :
            i == 4 ? AssetsImagePath.tutorial_5 :
            AssetsImagePath.tutorial_1,
          )
      );
    }
    super.onInit();
  }
}
