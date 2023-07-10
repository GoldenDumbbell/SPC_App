import 'package:flutter/material.dart';
import 'package:webspc/Api_service/payment_service.dart';
import 'package:webspc/Api_service/spot_service.dart';
import 'package:webspc/DTO/cars.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/DTO/spot.dart';
import 'package:webspc/DTO/user.dart';
import 'package:webspc/resource/Profile/spc_wallet_page.dart';
import 'package:webspc/styles/button.dart';
import 'spot_screen.dart';

class SelectSpotDialog extends StatefulWidget {
  const SelectSpotDialog({
    super.key,
    required this.spotId,
    required this.showButton,
    required this.title,
    this.plan,
    required this.context,
    this.selectedCar,
  });
  final String spotId;
  final bool showButton;
  final String title;
  final Plan? plan;
  final BuildContext context;
  final Car? selectedCar;
  @override
  State<SelectSpotDialog> createState() => _SelectSpotDialogState();
}

class _SelectSpotDialogState extends State<SelectSpotDialog> {
  bool isLoading = true;
  List<Spot> listSpot = [];
  Spot? detailSpot;
  String currentPassword = Session.loggedInUser.pass!;
  String password = "";
  void getAllListSpot() {
    SpotDetailService.getAllListSpot().then((response) {
      for (var i = 0; i < response.length; i++) {
        if (response[i].spotId == widget.spotId) {
          response[i].available = false;
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
                  Container(
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
                              listSpot[3].available == true
                                  ? buildAvailableSpot(listSpot[3].spotId)
                                  : buildUnavailableSpot(listSpot[3].spotId),
                              SizedBox(
                                height: 16,
                                width: 20,
                              ),
                              listSpot[5].available == true
                                  ? buildAvailableSpot(listSpot[5].spotId)
                                  : buildUnavailableSpot(listSpot[5].spotId),
                              SizedBox(
                                height: 16,
                                width: 20,
                              ),
                              listSpot[9].available == true
                                  ? buildAvailableSpot(listSpot[9].spotId)
                                  : buildUnavailableSpot(listSpot[9].spotId),
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
                              listSpot[2].available == true
                                  ? buildAvailableSpot(listSpot[2].spotId)
                                  : buildUnavailableSpot(listSpot[2].spotId),
                              SizedBox(
                                width: 90,
                              ),
                              listSpot[8].available == true
                                  ? buildAvailableSpot(listSpot[8].spotId)
                                  : buildUnavailableSpot(listSpot[8].spotId),
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
                              listSpot[1].available == true
                                  ? buildAvailableSpot(listSpot[1].spotId)
                                  : buildUnavailableSpot(listSpot[1].spotId),
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
                                  borderRadius: BorderRadius.circular(10.0),
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
                              listSpot[7].available == true
                                  ? buildAvailableSpot(listSpot[7].spotId)
                                  : buildUnavailableSpot(listSpot[7].spotId),
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
                              listSpot[0].available == true
                                  ? buildAvailableSpot(listSpot[0].spotId)
                                  : buildUnavailableSpot(listSpot[0].spotId),
                              SizedBox(
                                height: 16,
                                width: 20,
                              ),
                              listSpot[4].available == true
                                  ? buildAvailableSpot(listSpot[4].spotId)
                                  : buildUnavailableSpot(listSpot[4].spotId),
                              SizedBox(
                                width: 20,
                              ),
                              listSpot[6].available == true
                                  ? buildAvailableSpot(listSpot[6].spotId)
                                  : buildUnavailableSpot(listSpot[6].spotId),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                                      title: Text("Buy Spot"),
                                      content: Text(
                                          "Are you sure you want to buy this spot?"),
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
                              "Buy Spot Now",
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

  Container buildUnavailableSpot(String? spotId) {
    return Container(
      width: 50,
      height: 25,
      decoration: BoxDecoration(
        color: spotId == widget.spotId ? Colors.green : Colors.red,
        shape: BoxShape.rectangle,
      ),
      child: Align(
        alignment: Alignment(-0.1, 0.0),
        child: TextButton(
          onPressed: () {},
          child: Text(
            spotId ?? "",
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

  Container buildAvailableSpot(String? spotId) {
    return Container(
      width: 50,
      height: 25,
      decoration: BoxDecoration(
        color: Color(0x1f000000),
        shape: BoxShape.rectangle,
      ),
      child: Align(
        alignment: Alignment(-0.1, 0.0),
        child: TextButton(
          onPressed: () {},
          child: Text(
            spotId ?? "",
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
        title: Text("Enter you password to confirm"),
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
                if (widget.plan!.price > Session.loggedInUser.wallet!) {
                  showDialog(
                      context: context,
                      builder: (context) => _dialogTopUp(context));
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
                  // Update spot
                  List<Spot> listSpot = await SpotDetailService.getListSpot();
                  Spot spot = listSpot
                      .firstWhere((element) => element.spotId == widget.spotId);

                  spot.available = false;
                  if (widget.selectedCar != null) {
                    spot.carId = widget.selectedCar!.carId;
                  }
                  await SpotDetailService.updateSpot(spot);
                  await PaymentService.addPayment(
                      amount: -widget.plan!.price, purpose: "Buy spot");
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  _showMyDialog(
                    context,
                    "Success",
                    "You buy spot successfully",
                  );
                }
              } else {
                _showMyDialog(context, "Wrong password", "Please try again");
              }
            },
            child: Text("Ok"),
          ),
        ]);
  }

  AlertDialog _dialogTopUp(BuildContext context) {
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
                    builder: (context) => SPCWalletScreen(context)));
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
