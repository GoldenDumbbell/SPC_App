import 'package:flutter/material.dart';
import 'package:webspc/Api_service/payment_service.dart';
import 'package:webspc/Api_service/spot_service.dart';
import 'package:webspc/DTO/cars.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/DTO/spot.dart';
import 'package:webspc/resource/Profile/spc_wallet_page.dart';
import 'package:webspc/styles/button.dart';
import '../../Api_service/car_service.dart';
import '../../Api_service/local_notification_service.dart';
import '../../DTO/bundle.dart';
import 'spot_screen.dart';

class SelectSpotDialog extends StatefulWidget {
  const SelectSpotDialog({
    super.key,
    required this.spotId,
    required this.showButton,
    required this.title,
    this.bundle,
    required this.context,
    this.selectedCar,
    required this.fee,
  });
  final String? spotId;
  final bool showButton;
  final String title;
  final Bundle? bundle;
  final BuildContext context;
  final Car? selectedCar;
  final int fee;
  @override
  State<SelectSpotDialog> createState() => _SelectSpotDialogState();
}

class _SelectSpotDialogState extends State<SelectSpotDialog> {
  bool isLoading = true;
  List<Spot> listSpot = [];
  Spot? detailSpot;
  String currentPassword = Session.loggedInUser.pass!;
  String password = "";
  Spot? selectedSpot;
  void getAllListSpot() {
    SpotDetailService.getAllListSpot().then((response) {
      for (var i = 0; i < response.length; i++) {
        if (response[i].location == widget.spotId) {
          response[i].available = false;
        }
        if (response[i].spotId == widget.spotId) {
          if (mounted) {
            setState(() {
              selectedSpot = response[i];
            });
          }
        }
      }
      setState(() {
        isLoading = false;
        listSpot = response;
        if (listSpot.isNotEmpty) {
          detailSpot = listSpot.first;
        }
      });
    });
  }

  @override
  void initState() {
    getAllListSpot();
    super.initState();
  }

  Widget handleBuildSpot(Spot spot) {
    if (spot.owned!) {
      return buildOwnedSpot(spot);
    } else {
      if (spot.available!) {
        return buildUnavailableSpot(spot);
      } else {
        return buildAvailableSpot(spot);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.spotId != null
                      ? Container(
                          decoration: BoxDecoration(
                            color: Color(0x1f000000),
                            // shape: BoxShape.rectangle,
                            // borderRadius: BorderRadius.zero,
                            // border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    handleBuildSpot(listSpot[7]),
                                    SizedBox(
                                      height: 16,
                                      width: 20,
                                    ),
                                    handleBuildSpot(listSpot[2]),
                                    SizedBox(
                                      height: 16,
                                      width: 20,
                                    ),
                                    handleBuildSpot(listSpot[3]),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25,
                                width: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    handleBuildSpot(listSpot[0]),
                                    SizedBox(
                                      width: 90,
                                    ),
                                    handleBuildSpot(listSpot[1]),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    handleBuildSpot(listSpot[6]),
                                    SizedBox(
                                      height: 16,
                                      width: 20,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0x1f000000),
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color: Color(0x4d9e9e9e), width: 1),
                                      ),
                                      child: Align(
                                        alignment: Alignment(-0.1, 0.0),
                                        child: Text(
                                          "Elevator",
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 10,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    handleBuildSpot(listSpot[9]),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25,
                                width: 50,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    handleBuildSpot(listSpot[5]),
                                    SizedBox(
                                      height: 16,
                                      width: 20,
                                    ),
                                    handleBuildSpot(listSpot[8]),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    handleBuildSpot(listSpot[4]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 25,
                  ),
                  widget.showButton
                      ? Container(
                          padding: EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            style: buttonPrimary,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      title: Text("Confirm"),
                                      content: Text(
                                          "Are you sure you want to confirm this spot?"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  _dialogCheckPassword(context),
                                            );
                                          },
                                          child: Text("Confirm"),
                                        ),
                                      ],
                                    );
                                  }));
                            },
                            child: Text(
                              "Confirm Now",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 20,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
      ),
    );
  }

  Container buildUnavailableSpot(Spot? spot) {
    return Container(
      width: 50,
      height: 25,
      decoration: BoxDecoration(
        color: spot!.spotId == widget.spotId ? Colors.green : Colors.yellow,
        shape: BoxShape.rectangle,
      ),
      child: Align(
        alignment: Alignment(-0.1, 0.0),
        child: TextButton(
          onPressed: () {},
          child: Text(
            spot.location ?? "",
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 10,
              color: Color(0xff000000),
            ),
          ),
        ),
      ),
    );
  }

  Container buildOwnedSpot(Spot? spot) {
    return Container(
      width: 50,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.rectangle,
      ),
      child: Align(
        alignment: Alignment(-0.1, 0.0),
        child: TextButton(
          onPressed: () {},
          child: Text(
            spot!.location ?? "",
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 10,
              color: Color(0xff000000),
            ),
          ),
        ),
      ),
    );
  }

  Container buildAvailableSpot(Spot? spot) {
    return Container(
      width: 50,
      height: 25,
      decoration: BoxDecoration(
        color: spot!.spotId == widget.spotId ? Colors.green : Color(0x1f000000),
        shape: BoxShape.rectangle,
      ),
      child: Align(
        alignment: Alignment(-0.1, 0.0),
        child: TextButton(
          onPressed: () {},
          child: Text(
            spot.location ?? "",
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 10,
              color: Color(0xff000000),
            ),
          ),
        ),
      ),
    );
  }

  AlertDialog _dialogCheckPassword(BuildContext context) {
    return AlertDialog(
        title: Text(
            'Enter you password to confirm ${widget.spotId != null ? 'Buy spot for ${widget.selectedCar!.carPlate}' : 'Buy park for ${widget.selectedCar!.carPlate}'}'),
        content: TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (password == currentPassword) {
                // Navigator.of(context).pop();
                // Navigator.of(context).pop();
                // Check if account has enough money
                if ((widget.bundle!.price! +
                        widget.bundle!.price! * widget.fee / 100) >
                    Session.loggedInUser.wallet!) {
                  // Calculate top up amount
                  String topUpAmount = ((widget.bundle!.price! +
                              widget.bundle!.price! * widget.fee / 100) -
                          Session.loggedInUser.wallet!)
                      .ceil()
                      .toString();
                  showDialog(
                      context: context,
                      builder: (context) => _dialogTopUp(context, topUpAmount));
                } else {
                  // Show loading
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      title: Text("Buying spot"),
                      content: Container(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  );
                  if (widget.spotId != null) {
                    // Update spot
                    List<Spot> listSpot = await SpotDetailService.getListSpot();
                    Spot spot = listSpot.firstWhere(
                        (element) => element.spotId == widget.spotId);

                    spot.owned = true;
                    if (widget.selectedCar != null) {
                      spot.carId = widget.selectedCar!.carPlate;
                    }
                    widget.selectedCar!.verifyState2 = true;
                    await CarService.updateCar(
                        widget.selectedCar!, widget.selectedCar!.carId!);
                    await SpotDetailService.updateSpot(spot);
                    await PaymentService.addPayment(
                      amount: -widget.bundle!.price!,
                      purpose:
                          'Buy spot ${spot.location} for ${widget.selectedCar!.carPlate}',
                      bundle: widget.bundle!,
                    );
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SpotScreen(context)),
                    );
                    await LocalNotificationService.saveNotification(
                        "You have bought spot ${spot.location} for ${widget.selectedCar!.carPlate}");
                    _showMyDialog(
                      context,
                      "Success",
                      "You buy spot successfully",
                    );
                  } else {
                    // If park mode
                    widget.selectedCar!.verifyState2 = true;
                    await CarService.updateCar(
                        widget.selectedCar!, widget.selectedCar!.carId!);
                    await PaymentService.addPayment(
                      amount: -widget.bundle!.price!,
                      purpose: 'Buy park for ${widget.selectedCar!.carPlate}',
                      bundle: widget.bundle!,
                    );
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SpotScreen(context)));
                    await LocalNotificationService.saveNotification(
                        "You have bought park for ${widget.selectedCar!.carPlate}");
                    _showMyDialog(
                      context,
                      "Success",
                      "You park successfully",
                    );
                  }
                }
              } else {
                _showMyDialog(context, "Wrong password", "Please try again");
              }
            },
            child: Text("Ok"),
          ),
        ]);
  }

  AlertDialog _dialogChooseBundle(BuildContext context) {
    return AlertDialog(
      title: Text("Choose bundle"),
      content: Container(
        height: 200,
        width: 200,
      ),
    );
  }

  AlertDialog _dialogTopUp(BuildContext context, String? topUpAmount) {
    return AlertDialog(
      title: Text("Not enough money"),
      content: Text("Do you want to top up your account?"),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("No"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SPCWalletScreen(context, topUpAmount)));
          },
          child: Text("Yes"),
        ),
      ],
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
}
