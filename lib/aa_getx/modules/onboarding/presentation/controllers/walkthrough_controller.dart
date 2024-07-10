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
    final TutotrialsArguments _tutotrialsArguments = Get.arguments;
    walkthroughPages.addAll(
      [
        WalkthroughPage(
          title: _tutotrialsArguments.onboardingDataEntity[0].title ??
              'Strings.walkthroughTitle1',
          description:_tutotrialsArguments.onboardingDataEntity[0].description ??  'Strings.walkthroughDescription1',
          imageAsset: AssetsImagePath.tutorial_1,
        ), // Replace with your image path
         WalkthroughPage(
         title: _tutotrialsArguments.onboardingDataEntity[0].title ??
              'Strings.walkthroughTitle1',
          description:_tutotrialsArguments.onboardingDataEntity[0].description ??  'Strings.walkthroughDescription1',
          imageAsset: AssetsImagePath.updateKyc,
        ), // Replace with your image path
         WalkthroughPage(
         title: _tutotrialsArguments.onboardingDataEntity[0].title ??
              'Strings.walkthroughTitle1',
          description:_tutotrialsArguments.onboardingDataEntity[0].description ??  'Strings.walkthroughDescription1',
          imageAsset: AssetsImagePath.tutorial_3,
        ), // Replace with your image path
         WalkthroughPage(
          title: _tutotrialsArguments.onboardingDataEntity[0].title ??
              'Strings.walkthroughTitle1',
          description:_tutotrialsArguments.onboardingDataEntity[0].description ??  'Strings.walkthroughDescription1',
          imageAsset: AssetsImagePath.tutorial_4,
        ),
         WalkthroughPage(
         title: _tutotrialsArguments.onboardingDataEntity[0].title ??
              'Strings.walkthroughTitle1',
          description:_tutotrialsArguments.onboardingDataEntity[0].description ??  'Strings.walkthroughDescription1',
          imageAsset: AssetsImagePath.tutorial_5,
        ),
      ],
    );
    super.onInit();
  }
}
