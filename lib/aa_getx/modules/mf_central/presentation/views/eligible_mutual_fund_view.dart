import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/controllers/eligible_mutual_fund_controller.dart';

class EligibleMutualFundView extends GetView<EligibleMutualFundController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(backgroundColor: colorBg),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Allowed Mutual Funds",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            Text("Total Value : ${controller.totalValueOfAllowedMf}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            SizedBox(height: 20),
            controller.approvedMutualFundList.length == 0
                ? Center(child: Text("No Eligible Mutual Fund")) :
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.approvedMutualFundList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return controller.approvedMutualFundList[index].isAllowed == 1 ? Card(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  color: colorWhite,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${index + 1}) ${controller.approvedMutualFundList[index].schemeName} [${controller.approvedMutualFundList[index].isin}]",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Broker Name : ${controller.approvedMutualFundList[index].brokerName}"),
                                  Text("Asset Type : ${controller.approvedMutualFundList[index].assetType}"),
                                  Text("Nav : ${controller.approvedMutualFundList[index].nav}"),
                                  Text("Units : ${controller.approvedMutualFundList[index].closingBalance}"),
                                  Text("Value : ${controller.approvedMutualFundList[index].marketValue}"),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: colorRed,
                              minRadius: 32,
                              child: Text("G"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ) : SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

}