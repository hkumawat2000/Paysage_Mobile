import 'package:lms/approved_securities/ApprovedSecuritiesBloc.dart';
import 'package:lms/network/requestbean/ApprovedSecuritiesRequestBean.dart';
import 'package:lms/network/responsebean/ApprovedSecurityResponseBean.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/widgets/ErrorMessageWidget.dart';
import 'package:lms/widgets/LoadingWidget.dart';
import 'package:lms/widgets/NoDataWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ApprovedSecuritiesScreen extends StatefulWidget {
  @override
  ApprovedSecuritiesScreenState createState() => ApprovedSecuritiesScreenState();
}

class ApprovedSecuritiesScreenState extends State<ApprovedSecuritiesScreen> {
  final approvedSecuritiesBloc = ApprovedSecuritiesBloc();
  ScrollController _scrollController = new ScrollController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ApprovedSecuritiesList> approvedSecurityList = [];
  List<String> filterList = [];
  List<String> securityCategoryList = [];
  bool isComingFromFilter = false;
  bool isComingFromSearch = false;
  String filterName = '';
  String searchName = '';
  bool isLoading = false;
  int start = 0;
  int searchStart = 0;
  String? pdfURL;
  bool isMoreData = false;
  Preferences preferences = new Preferences();
  String? _currentInstrument;
  List<DropdownMenuItem<String>>? _dropDownInstrument;
  List instrumentTypeList = ["Equity", "Mutual Fund - Equity", "Mutual Fund - Debt"];
  bool isAPICalling = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    _dropDownInstrument = getDropDownFormatMenuItems();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        setState(() {
          isMoreData = true;
        });
        Utility.isNetworkConnection().then((isNetwork) {
          if (isNetwork) {
            searchStart = searchStart + 20;
            approvedSecuritiesBloc.getDirectApprovedSecurityValue(ApprovedSecuritiesRequestBean(
                lender: "Choice Finserv", start: searchStart, perPage: 20, search: searchName,
                category: filterName, isDownload: 0, loanType: _currentInstrument)).then((value) {
              if (value.isSuccessFull!) {
                setState(() {
                  if (value.data!.approvedSecuritiesList!.length != 0) {
                    approvedSecurityList.addAll(value.data!.approvedSecuritiesList!);
                  }
                  if (value.data!.approvedSecuritiesList!.length < 20) {
                    isMoreData = false;
                  } else {
                    isMoreData = true;
                  }
                });
              }
            });
          } else {
            Utility.showToastMessage(Strings.no_internet_message);
          }
        });
      }
    });
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownFormatMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String status in instrumentTypeList) {
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
  void dispose() {
    approvedSecuritiesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorBg,
      appBar: AppBar(
        backgroundColor: colorBg,
        elevation: 0.0,
        title: appBarTitle,
        leading: IconButton(
          icon: ArrowToolbarBackwardNavigation(),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              if(_currentInstrument == null){
                commonDialog(context, Strings.instrument_selection, 0);
              } else {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = Icon(Icons.close, color: colorGrey);
                    this.appBarTitle = TextFormField(
                      onChanged: (value) {
                        isComingFromSearch = true;
                        isMoreData = true;
                        searchName = searchController.text.trim().toString();
                        filterSearchResults();
                      },
                      controller: searchController,
                      focusNode: focusNode,
                      style: TextStyle(
                        color: appTheme,
                      ),
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          hintText: Strings.search,
                          hintStyle: TextStyle(color: colorGrey)),
                    );
                    focusNode.requestFocus();
                  } else {
                    focusNode.unfocus();
                    start = 0;
                    searchStart = 0;
                    searchController.clear();
                    searchName = '';
                    filterSearchResults();
                    this.actionIcon = Icon(
                      Icons.search,
                      color: colorGrey,
                    );
                    this.appBarTitle = Text("");
                  }
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          detailsWidget(),
          SizedBox(height: 10),
          Expanded(
            child: _currentInstrument != null
                ? getApprovalSecuritiesList()
            : Container(),
          ),
        ],
      ),
    );
  }

  Widget appBarTitle = Text("");
  Icon actionIcon = Icon(
    Icons.search,
    color: colorGrey,
  );

  Widget detailsWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              headingText(_currentInstrument == null || _currentInstrument == "Equity" ? Strings.approved_security : Strings.approved_scheme),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              instrumentType(),
              securityCategoryType(),
              SizedBox(width: 20),
              Visibility(
                visible: _currentInstrument != null ? true : false,
                child: GestureDetector(
                  onTap: () async {
                    String? mobile = await preferences.getMobile();
                    String? email = await preferences.getEmail();
                    Utility.isNetworkConnection().then((isNetwork) {
                      if (isNetwork) {
                        printLog('PDF url ==> $pdfURL');
                        if(!isAPICalling){
                          if (pdfURL != null) {
                            if(pdfURL!.isNotEmpty) {
                              // Firebase Event
                              Map<String, dynamic> parameter = new Map<
                                  String,
                                  dynamic>();
                              parameter[Strings.mobile_no] = mobile;
                              parameter[Strings.email] = email;
                              parameter[Strings.pdf_url] = pdfURL;
                              parameter[Strings.date_time] =
                                  getCurrentDateAndTime();
                              firebaseEvent(
                                  Strings.approved_securities_pdf, parameter);
                              _launchURL(pdfURL);
                            } else {
                              Utility.showToastMessage(Strings.no_data_available);
                            }
                          } else {
                            Utility.showToastMessage(Strings.loading);
                          }
                        }else{
                          Utility.showToastMessage(Strings.loading);
                        }
                      } else {
                        Utility.showToastMessage(Strings.no_internet_message);
                      }
                    });
                  },
                  child: CircleAvatar(radius: 15.0,backgroundColor:red,
                    child: Image.asset(
                      AssetsImagePath.pdf_white_icon,height: 20,width: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  instrumentType(){ //get instrument type
    return Expanded(
      child: Container(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _currentInstrument,
          hint: Text(
            'Instrument Type',
            style: regularTextStyle_14_gray,
          ),
          icon: Image.asset(AssetsImagePath.down_arrow, height: 15, width: 15),
          elevation: 16,
          onChanged: onChangeOfInstrumentType,
          items: _dropDownInstrument,
        ),
      ),
    );
  }

  onChangeOfInstrumentType(String? selected){ // from drop down instrument type changed
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if(_currentInstrument != selected!){
          setState(() {
            _currentInstrument = selected;
            filterName = '';
            start = 0;
            searchStart = 0;
            searchName = '';
            searchController.clear();
            this.actionIcon = Icon(
              Icons.search,
              color: colorGrey,
            );
            this.appBarTitle = Text("");
          });
          if(approvedSecurityList.length != 0) {
            _scrollController.animateTo(_scrollController.position.minScrollExtent,
                duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
          }
          setState(() {
            isAPICalling = true;
            isMoreData = false;
          });
          approvedSecuritiesBloc
              .getDirectApprovedSecurityValue(ApprovedSecuritiesRequestBean(
              lender: "Choice Finserv", start: 0, perPage: 20, search: "", isDownload: 1, loanType: _currentInstrument, category: filterName))
              .then((value) {
            if (value.isSuccessFull!) {
              setState(() {
                pdfURL = value.data!.pdfFileUrl;
                filterList.clear();
                filterList.add(Strings.clear_filter);
                filterList.addAll(value.data!.securityCategoryList!);
                isAPICalling = false;
              });
            } else if(value.errorCode == 403){
              setState(() {
                isAPICalling = false;
              });
              commonDialog(context, Strings.session_timeout, 4);
            } else {
              setState(() {
                pdfURL = "";
                isAPICalling = false;
              });
              // Utility.showToastMessage(value.errorMessage!);
            }
          });

          approvedSecuritiesBloc.getApprovedSecurities(ApprovedSecuritiesRequestBean(
              lender: "Choice Finserv", start: start, perPage: 20, search: "", isDownload: 0, loanType: _currentInstrument, category: filterName)).then((value) {
            if(value.isSuccessFull!){
              setState(() {
                // searchedShareList.clear();
                approvedSecurityList.clear();
                approvedSecurityList.addAll(value.data!.approvedSecuritiesList!);
                if(value.data!.approvedSecuritiesList!.length < 20){
                  isMoreData = false;
                } else {
                  isMoreData = true;
                }
              });
            }
          });
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }


  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget getApprovalSecuritiesList() {
    return StreamBuilder(
      stream: approvedSecuritiesBloc.listSecurityCategory,
      builder: (context, AsyncSnapshot<ApprovedSecuritiesData> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return _buildNoDataWidget();
          } else {
            return getAllApprovedList(approvedSecurityList);
          }
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget getAllApprovedList(List<ApprovedSecuritiesList> snapshot) {
    return snapshot.length == 0
        ? Center(child: Text(Strings.no_result_found))
        : ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.length + 1,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return index == snapshot.length
                  ? isMoreData
                      ? _buildLoadingWidget()
                      : Text('')
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, left: 16, right: 16),
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  snapshot[index].securityName!,
                                  style: TextStyle(
                                      color: appTheme, fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.beenhere,
                                        color: Colors.lightGreen,
                                        size: 15,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Text(
                                    "${snapshot[index].securityCategory} (LTV: ${snapshot[index].eligiblePercentage}%)",
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
            },
          );
  }

  Widget securityCategoryType() {
    return Visibility(
      visible: _currentInstrument != null ? true : false,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Container(
            width: 100,
            padding: EdgeInsets.only(right: 10),
            child: Text(
              filterName,
              textAlign: TextAlign.end,
              style: TextStyle(color: colorLightAppTheme),
            ),
          ),
          icon: Image.asset(
            AssetsImagePath.filter,
            height: 30,
            width: 30,
            color: colorLightAppTheme,
          ),
          items: filterList
                  .map(
                    (leave) => DropdownMenuItem<String>(
                      child: Text(leave),
                      value: leave,
                    ),
                  )
                  .toList(),
          onChanged: (newValue) async {
            String? mobile = await preferences.getMobile();
            String email = await preferences.getEmail();
            Utility.isNetworkConnection().then((isNetwork) {
              if (isNetwork) {
                if(newValue == Strings.clear_filter){
                  filterName = '';
                } else {
                  filterName = newValue!;
                }
                isComingFromFilter = true;
                // searchedShareList.clear();
                searchName = searchController.text.trim().toString();
                filterCategoryResults();
                // Firebase Event
                Map<String, dynamic> parameter = new Map<String, dynamic>();
                parameter[Strings.mobile_no] = mobile;
                parameter[Strings.email] = email;
                parameter[Strings.filter_name] = newValue;
                parameter[Strings.date_time] = getCurrentDateAndTime();
                firebaseEvent(Strings.approved_securities_filter, parameter);
              } else {
                Utility.showToastMessage(Strings.no_internet_message);
              }
            });
          },
        ),
      ),
    );
  }

  void filterCategoryResults() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        setState(() {
          start = 0;
          searchStart = 0;
          searchName = '';
          searchController.clear();
          this.actionIcon = Icon(
            Icons.search,
            color: colorGrey,
          );
          this.appBarTitle = Text("");
        });
        if(approvedSecurityList.length != 0) {
          _scrollController.animateTo(_scrollController.position.minScrollExtent,
              duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        }
        setState(() {
          isAPICalling = true;
          isMoreData = false;
        });
        approvedSecuritiesBloc
            .getDirectApprovedSecurityValue(ApprovedSecuritiesRequestBean(
            lender: "Choice Finserv", start: 0, perPage: 20, search: "", isDownload: 1, loanType: _currentInstrument, category: filterName))
            .then((value) {
          if (value.isSuccessFull!) {
            setState(() {
              pdfURL = value.data!.pdfFileUrl;
              filterList.clear();
              filterList.add(Strings.clear_filter);
              filterList.addAll(value.data!.securityCategoryList!);
              isAPICalling = false;
            });
          } else if(value.errorCode == 403){
            setState(() {
              isAPICalling = false;
            });
            commonDialog(context, Strings.session_timeout, 4);
          } else {
            setState(() {
              pdfURL = "";
              isAPICalling = false;            });
          }
        });

        approvedSecuritiesBloc
            .getDirectApprovedSecurityValue(ApprovedSecuritiesRequestBean(
                lender: "Choice Finserv",
                start: 0,
                perPage: 20,
                search: searchName,
                category: filterName,
                isDownload: 0,
            loanType: _currentInstrument))
            .then((value) {
          if (value.isSuccessFull!) {
            setState(() {
              approvedSecurityList.clear();
              approvedSecurityList.addAll(value.data!.approvedSecuritiesList!);
              if (value.data!.approvedSecuritiesList!.length < 20) {
                isMoreData = false;
              } else {
                isMoreData = true;
              }
            });
          }
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }


  void filterSearchResults() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        approvedSecuritiesBloc
            .getDirectApprovedSecurityValue(ApprovedSecuritiesRequestBean(
                lender: "Choice Finserv",
                start: 0,
                perPage: 20,
                search: searchName,
                category: filterName,
                isDownload: 0,
            loanType: _currentInstrument))
            .then((value) {
          if (value.isSuccessFull!) {
            setState(() {
              approvedSecurityList.clear();
              approvedSecurityList.addAll(value.data!.approvedSecuritiesList!);
              if (value.data!.approvedSecuritiesList!.length < 20) {
                isMoreData = false;
              } else {
                isMoreData = true;
              }
            });
          }
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Widget _buildLoadingWidget() {
    return LoadingWidget();
  }

  Widget _buildErrorWidget(String error) {
    return ErrorMessageWidget(error: error);
  }

  Widget _buildNoDataWidget() {
    return NoDataWidget();
  }
}
