// ignore_for_file: public_member_api_docs, sort_constructors_first
///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:webspc/Api_service/bundle_services.dart';

import 'package:webspc/Api_service/spot_service.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/resource/Profile/spot_select.dart';
import 'package:webspc/styles/button.dart';

import '../../../DTO/spot.dart';
import '../../Api_service/car_detail_service.dart';
import '../../DTO/bundle.dart';
import '../../DTO/cars.dart';

class SpotScreen extends StatefulWidget {
  final BuildContext? context;
  const SpotScreen(this.context, {Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SpotScreenState createState() => _SpotScreenState();
}

class _SpotScreenState extends State<SpotScreen> {
  bool isLoading = true;
  bool isBuyMode = true;
  List<Spot> listSpot = [];
  List<Bundle> listBundle = [];
  Spot? detailSpot;
  Spot? dropdownValue;
  List<Car> listCar = [];
  Car? carDetail;
  Car? dropdownValueCar;
  bool acceptTerm = false;
  List<Bundle> listBundleDropdown = [];

  Bundle? dropdownValueBundle;
  String formatCurrency(double n) {
    // Add comma to separate thousands
    var currency = NumberFormat("#,##0", "vi_VN");
    return currency.format(n);
  }

  @override
  void initState() {
    getListSpot();
    getListCar();
    getListBundle();
    super.initState();
  }

  void toggleListBundleDropdown() {
    dropdownValueBundle = null;
    // if isBuyMode = true add Bundle id start with A..
    // else add Bundle id start with B..
    if (isBuyMode) {
      setState(() {
        listBundleDropdown = listBundle
            .where((element) => element.bundleId!.startsWith("B"))
            .toList();
      });
    } else {
      setState(() {
        listBundleDropdown = listBundle
            .where((element) => element.bundleId!.startsWith("A"))
            .toList();
      });
    }
  }

  void getListBundle() {
    BundleServices.getAllBundle().then((response) {
      setState(() {
        listBundle = response;
      });
      toggleListBundleDropdown();
    });
  }

  void getListCar() {
    CarDetailService.getListCar().then(
      (response) => setState(() {
        listCar = response;
        if (listCar.isNotEmpty) {
          carDetail = listCar.first;
        }
      }),
    );
  }

  void getListSpot() {
    SpotDetailService.getListSpot().then(
      (response) => setState(
        () {
          // isLoading = false;
          // Only get spot with owned is false
          listSpot =
              response.where((element) => element.owned == false).toList();
          if (listSpot.isNotEmpty) {
            detailSpot = listSpot.first;
            // for (int i = 0; i < listSpot.length; i++) {}
          }
        },
      ),
    );
  }

  int selectedIndex = 0;
  int selectedCatIndex = 0;

  @override
  Widget build(BuildContext context) {
    final RoundedLoadingButtonController _btnLogin =
        RoundedLoadingButtonController();
    DateTime now = DateTime.now();
    String currentTime = DateFormat('yyyy-MM-dd').format(now);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     Switch(
      //       value: isBuyMode,
      //       onChanged: (value) {
      //         setState(() {
      //           isBuyMode = value;
      //           toggleListBundleDropdown();
      //         });
      //       },
      //     ),
      //   ],
      // ),
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xffffffff),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.zero,
              border: Border.all(color: Color(0xfff7f2f2), width: 0),
              image: DecorationImage(
                image: AssetImage('images/bga1png.png'),
                fit: BoxFit.cover,
              )),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  isBuyMode ? "Buy Spot" : "Park",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 50,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // A rect with width is 50% of container width
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        top: 0,
                        left: isBuyMode
                            ? 0
                            : MediaQuery.of(context).size.width * 0.4,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      // Make a gesture detector to detect tap on the rect
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isBuyMode = !isBuyMode;
                            dropdownValue = null;
                            toggleListBundleDropdown();
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Center(
                                  child: Text(
                                    "Buy Spot",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: isBuyMode
                                          ? Colors.white
                                          : Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Center(
                                  child: Text(
                                    "Park",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: isBuyMode
                                          ? Colors.black
                                          : Colors.white,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: isBuyMode,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      color: Color(0x1f000000),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Spot:",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                  border: Border.all(
                                      color: Color(0xfff2ebeb), width: 1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Spot>(
                                    borderRadius: BorderRadius.circular(30),
                                    hint: Text(
                                      'Select available spot',
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    onChanged: (Spot? newvalue) {
                                      if (newvalue != null &&
                                          newvalue.available!) {
                                        _showMyDialog(context, "Failed booking",
                                            "This spot has been parked by someone else. Please select another spot.");
                                        return;
                                      } else if (newvalue != null &&
                                          !newvalue.available!) {
                                        setState(() {
                                          dropdownValue = newvalue;
                                        });
                                      }
                                    },
                                    value: dropdownValue,
                                    items: listSpot.map<DropdownMenuItem<Spot>>(
                                        (Spot value) {
                                      return DropdownMenuItem<Spot>(
                                        value: value,
                                        child: Text('${value.location}'),
                                      );
                                    }).toList(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    elevation: 8,
                                    isExpanded: true,
                                  ),
                                )),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => SelectSpotDialog(
                                  title: "Spot map",
                                  showButton: false,
                                  spotId: dropdownValue?.spotId!,
                                  context: context,
                                  fee: 0,
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.map,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Color(0x1f000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: Alignment(-0.9, 0.0),
                        child: Text(
                          "Date Time:",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              '$currentTime',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Color(0x1f000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Name:",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          Session.loggedInUser.fullname!,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    color: Color(0x1f000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "License Plate:",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.07,
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              border: Border.all(
                                  color: Color(0xfff2ebeb), width: 1),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Car>(
                                hint: Text('Select carplate'),
                                borderRadius: BorderRadius.circular(40),
                                onChanged: (Car? newvalue) {
                                  setState(() {
                                    dropdownValueCar = newvalue!;
                                  });
                                },
                                value: dropdownValueCar,
                                items: listCar
                                    .map<DropdownMenuItem<Car>>((Car value) {
                                  return DropdownMenuItem<Car>(
                                    value: value,
                                    child: Text('${value.carPlate}'),
                                  );
                                }).toList(),
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                                elevation: 8,
                                isExpanded: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Color(0x1f000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Phone:",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          Session.loggedInUser.phoneNumber!,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    color: Color(0x1f000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Spot Price:",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.07,
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              border: Border.all(
                                  color: Color(0xfff2ebeb), width: 1),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Object>(
                                value: dropdownValueBundle,
                                hint: Text('Select plan'),
                                borderRadius: BorderRadius.circular(40),
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                                elevation: 8,
                                isExpanded: true,
                                items: listBundleDropdown.map((Bundle bundle) {
                                  return DropdownMenuItem<Object>(
                                    value: bundle,
                                    child: Text(
                                      '${bundle.bundleId} ${bundle.bundleName}: ${formatCurrency(bundle.price!)} VND',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Object? value) {
                                  setState(() {
                                    dropdownValueBundle = value! as Bundle;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Button to show dialog
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Color(0x1f000000),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: buttonPrimary,
                      child: Text(
                        isBuyMode ? 'View Selected Spot' : "Buy Park",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (dropdownValueCar != null &&
                            dropdownValueCar!.verifyState2 != null &&
                            dropdownValueCar!.verifyState2! &&
                            !isBuyMode) {
                          _showMyDialog(context, "failed booking!",
                              "Your car already has a spot to park");
                          return;
                        }
                        if (isBuyMode && dropdownValue != null) {
                          if (!dropdownValue!.owned! &&
                              dropdownValue!.available!) {
                            _showMyDialog(context, "Failed",
                                "Please wait for the person to park out of the parking lot");
                            return;
                          }
                        }

                        // Check if carId exist in listSpot
                        SpotDetailService.getAllListSpot().then((spots) {
                          for (var spot in spots) {
                            if (spot.carId == dropdownValueCar?.carPlate &&
                                isBuyMode) {
                              _showMyDialog(context, "failed booking!",
                                  "Your car is already have a spot");
                              return;
                            }
                          }
                          if (dropdownValueCar?.verifyState2 == true) {
                            _showMyDialog(context, "failed booking!",
                                "Your car is already have a park");
                            return;
                          }

                          bool isBought1Spot = false;
                          // Check if user has bought 1 spot already
                          for (var spot in spots) {
                            for (var car in listCar) {
                              if (spot.carId == car.carPlate) {
                                isBought1Spot = true;
                                break;
                              }
                            }
                          }
                          int extraFee = 0;
                          if (dropdownValue?.spotId == null && isBuyMode) {
                            _showMyDialog(context, "failed booking!",
                                "Please choose spot");
                          } else if (dropdownValueCar?.carPlate == null) {
                            _showMyDialog(context, "failed booking!",
                                "Please choose your car");
                          } else if (dropdownValueBundle == null) {
                            _showMyDialog(context, "failed booking!",
                                "Please choose bundle");
                          } else if (isBought1Spot && isBuyMode) {
                            if (Session.loggedInUser.familyId == null) {
                              _showMyDialog(context, "failed booking!",
                                  "You have already bought 1 spot. Please join a family to buy more spots with extra fee 10%");
                              return;
                            } else {
                              extraFee = 10;
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Extra fee"),
                                      content: Text(
                                          "You have already bought 1 spot. Buy more spots with extra fee 10%"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  SelectSpotDialog(
                                                title: "Select spot",
                                                showButton: true,
                                                spotId: dropdownValue!.spotId!,
                                                bundle: dropdownValueBundle!,
                                                context: context,
                                                selectedCar: dropdownValueCar,
                                                fee: extraFee,
                                              ),
                                            );
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    );
                                  });
                            }
                          } else {
                            _showTermDialog(context).then((_) {
                              if (acceptTerm) {
                                showDialog(
                                  context: context,
                                  builder: (context) => SelectSpotDialog(
                                    title: "Select spot",
                                    showButton: true,
                                    spotId: dropdownValue?.spotId,
                                    bundle: dropdownValueBundle!,
                                    context: context,
                                    selectedCar: dropdownValueCar,
                                    fee: extraFee,
                                  ),
                                );
                              }
                            });
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _showMyDialog(
      BuildContext context, String title, String description) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future _showTermDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Term of service"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                "1. You will not be able to cancel the package you purchased until it expires, at which point you can choose other packages."),
            Text("2. Are you sure with this choice?"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                acceptTerm = false;
              });
              Navigator.pop(context);
            },
            child: Text("Decline"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                acceptTerm = true;
              });
              Navigator.pop(context);
            },
            child: Text("Accept"),
          )
        ],
      ),
    );
  }
}
