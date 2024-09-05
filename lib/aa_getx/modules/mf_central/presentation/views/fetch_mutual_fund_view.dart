import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/controllers/fetch_mutual_fund_controller.dart';

import '../../../../core/constants/colors.dart';

class FetchMutualFundView extends GetView<FetchMutualFundController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(backgroundColor: colorBg),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Text("Mutual Funds",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.fetchMutualFundResponseData.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  color: colorWhite,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${index + 1}) ${controller.fetchMutualFundResponseData[index].schemeName} [${controller.fetchMutualFundResponseData[index].isin}]",
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
                                  Text("Broker Name : ${controller.fetchMutualFundResponseData[index].brokerName}"),
                                  Text("Asset Type : ${controller.fetchMutualFundResponseData[index].assetType}"),
                                  Text("Nav : ${controller.fetchMutualFundResponseData[index].nav}"),
                                  Text("Units : ${controller.fetchMutualFundResponseData[index].closingBalance}"),
                                  Text("Value : ${controller.fetchMutualFundResponseData[index].marketValue}"),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}