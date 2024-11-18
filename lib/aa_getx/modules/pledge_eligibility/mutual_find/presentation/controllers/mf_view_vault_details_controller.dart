import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/atrina_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/mf_scheme_response_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/my_cart_response_entity.dart';
import 'package:lms/util/Utility.dart';

class MfViewVaultDetailsController extends GetxController {
  final ConnectionInfo connectionInfo;
  MfViewVaultDetailsController(this.connectionInfo);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget appBarTitle = new Text("", style: mediumTextStyle_18_gray_dark);
  Icon actionIcon = new Icon(
    Icons.search,
    color: appTheme,
    size: 25,
  );
  TextEditingController textController = TextEditingController();
  PageController controller = PageController();
  RxBool isToggleSelect = false.obs;
  RxBool isDefaultBottomDialog = true.obs;
  RxBool isEligibleBottomDialog = false.obs;
  RxList<DropdownMenuItem<String>>? dropDownSortBy;
  List<String> sortingList = [
    Strings.sorting_list_item_1,
    Strings.sorting_list_item_2,
    Strings.sorting_list_item_3,
    Strings.sorting_list_item_4
  ];
  RxString currentLenderSortBy = "".obs;
  RxList<AtrinaEntity> cartViewList = <AtrinaEntity>[].obs;
  RxList<CartItemsResponseEntity> catAList = <CartItemsResponseEntity>[].obs;
  RxList<CartItemsResponseEntity> catBList = <CartItemsResponseEntity>[].obs;
  RxList<CartItemsResponseEntity> catCList = <CartItemsResponseEntity>[].obs;
  RxList<CartItemsResponseEntity> catDList = <CartItemsResponseEntity>[].obs;
  RxList<CartItemsResponseEntity> superCatAList =
      <CartItemsResponseEntity>[].obs;
  RxList<CategoryWiseListEntity> categoryWiseList =
      <CategoryWiseListEntity>[].obs;
  List<TextEditingController> schemeTextControllerList = [];
  RxString cartName = "".obs;
  RxList<CartItemsResponseEntity> schemesList = <CartItemsResponseEntity>[].obs;
  RxDouble schemeValue = 0.0.obs;
  RxDouble eligibleLoanAmount = 0.0.obs;
  RxList<bool> pledgeControllerEnable = <bool>[].obs;
  RxList<FocusNode> focusNode = <FocusNode>[].obs;
  RxList<SchemesListEntity>? schemesList2 = <SchemesListEntity>[].obs;

  Future<void> changedSortByItem(String selectedStatus) async {
    if (await connectionInfo.isConnected) {
      currentLenderSortBy.value = selectedStatus;

      switch (currentLenderSortBy.value) {
        case Strings.sorting_list_item_1:
          cartViewList.sort((a, b) => a.roi!.compareTo(b.roi!));
          break;
        case Strings.sorting_list_item_2:
          cartViewList.sort((b, a) => a.roi!.compareTo(b.roi!));
          break;
        case Strings.sorting_list_item_3:
          cartViewList.sort((a, b) => a.minLimit!.compareTo(b.minLimit!));
          break;
        case Strings.sorting_list_item_4:
          cartViewList.sort((a, b) => a.maxLimit!.compareTo(b.maxLimit!));
          break;
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  RxList<DropdownMenuItem<String>> getSortByItems() {
    RxList<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[].obs;
    for (String status in sortingList) {
      items.add(
        DropdownMenuItem(
          value: status,
          child: Text(
            status,
            style: regularTextStyle_14_gray,
          ),
        ),
      );
    }
    return items;
  }

  @override
  void onInit() {
    super.onInit();
    appBarTitle = Text(
      Strings.eligibility,
      style: mediumTextStyle_18_gray_dark,
    );
    //To initialize dropdown items
    dropDownSortBy = getSortByItems();
  }
}
