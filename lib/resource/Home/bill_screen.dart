import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:webspc/Api_service/car_detail_service.dart';
import 'package:webspc/Api_service/spot_service.dart';
import 'package:webspc/DTO/cars.dart';
import 'package:webspc/DTO/payment.dart';
import 'package:webspc/DTO/section.dart';
import 'package:webspc/DTO/spot.dart';

import '../../Api_service/payment_service.dart';

class BillInfoScreen extends StatefulWidget {
  final BuildContext? context;
  //final Car car;
  const BillInfoScreen(this.context, {Key? key}) : super(key: key);

  @override
  _BillInfoScreenState createState() => _BillInfoScreenState();
}

class _BillInfoScreenState extends State<BillInfoScreen> {
  BuildContext? dialogContext;
  bool isLoading = true;
  String spotId = "No spot";
  List<Car> listCar = [];
  // Get list of spot
  List<Spot> listSpot = [];
  List<Payment> listPayment = [];

  void getListSpot() async {
    SpotDetailService.getAllListSpot().then((value) {
      setState(() {
        listSpot = value;
        isLoading = false;
      });
    });
  }

  void getListCar() async {
    await CarDetailService.getListCar().then((res) {
      setState(() {
        listCar = res;
      });
    });
  }

  void getListPayment() {
    List<Payment> tmpListPayment = [];
    PaymentService.getAllPayment().then((value) {
      value.sort((a, b) => DateTime.parse(b.paymentdate ?? '')
          .compareTo(DateTime.parse(a.paymentdate ?? '')));
      // Check if payment is belong to user and not expired
      for (var payment in value) {
        if (payment.expiredDay != null) {
          if (payment.userId == Session.loggedInUser.userId &&
              payment.expiredDay!.isAfter(DateTime.now())) {
            tmpListPayment.add(payment);
          }
        }
      }
      setState(() {
        listPayment = tmpListPayment;
      });
    });
  }

  @override
  void initState() {
    getListSpot();
    getListCar();
    getListPayment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: Container(
          width: double.infinity, height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/bga1png.png'),
            fit: BoxFit.cover,
          )),
          // padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Your Bill",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listPayment.length,
                  itemBuilder: (context, index) {
                    return buildCarButton(listPayment[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget buildCarButton(Payment payment) {
    if (payment.expiredDay == null) {
      return Container();
    }
    String spotName = "No spot";
    int dayRemain = 0;
    if (payment.expiredDay != null) {
      dayRemain = DateTime.parse(payment.expiredDay.toString())
          .difference(DateTime.now())
          .inDays;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Text(
        payment.purpose! +
            "\n" +
            "Bundle - " +
            payment.bundleId! +
            " : " +
            "\n" +
            dayRemain.toString() +
            " days remain",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
