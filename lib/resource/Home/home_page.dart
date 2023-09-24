// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:webspc/Api_service/familyshare_service.dart';
import 'package:webspc/DTO/spot.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:webspc/Api_service/car_service.dart';
import 'package:webspc/Api_service/user_infor_service.dart';
import 'package:webspc/DTO/Qr.dart';
import 'package:webspc/navigationbar.dart';
import 'package:webspc/resource/Home/BookingScreen.dart';
import 'package:webspc/resource/Home/View_hisbooking.dart';
import 'package:webspc/resource/Home/use_car_in_family.dart';
import 'package:webspc/styles/button.dart';
import 'package:webspc/widget/sizer.dart';
import '../../Api_service/car_detail_service.dart';
import '../../Api_service/local_notification_service.dart';
import '../../Api_service/payment_service.dart';
import '../../Api_service/spot_service.dart';
import '../../DTO/cars.dart';
import '../../DTO/familycar.dart';
import '../../DTO/payment.dart';
import '../../DTO/section.dart';
import 'dart:math';

import '../../widget/colors.dart';
import '../Profile/family_screen.dart';
import 'bill_screen.dart';
import 'car_info.dart';
import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomePageState();
}

class MenuTile {
  String? title;
  String? subtitle;
  IconData iconData;
  Function onTap;
  MenuTile(this.title, this.subtitle, this.iconData, this.onTap);
}

class HomePageState extends State<HomeScreen> {
  String? Codesecurity;
  String? code = '';
  int selectedIndex = 0;
  int selectedCatIndex = 0;
  List<Car> listCar = [];
  Car? carDetail;
  Car? dropdownValue;
  Car? dropdownValuecarfam;
  String? Carplate;
  BuildContext? dialogContext;
  List<familyshare> listfamcar = [];
  List<familyshare> listfamcar1 = [];
  List<Car> listCarinfam = [];
  List<String> localNotifications = [];
  List<Payment> nearExpirePayment = [];
  FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // Initialize the local notification plugin
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    notificationPlugin.initialize(
      initializationSettings,
    );
    getListCar();
    getListLocalNotification();
    getNearExpirePayment();
    super.initState();
  }

  String formatCurrency(double n) {
    // Add comma to separate thousands
    var currency = NumberFormat("#,##0", "vi_VN");
    return currency.format(n);
  }

  // void getCarUserInfor() {
  //   CarInforofUserService.carUserInfor().then((value) => setState(() {}));
  //   // Carplate = Session.carUserInfor.carPlate;
  // }

  void getListCar() {
    CarDetailService.getListCar().then(
      (response) => setState(() {
        listCar = response;
      }),
    );
  }

  void getListLocalNotification() async {
    LocalNotificationService.getNotifications().then((value) {
      setState(() {
        localNotifications = value;
      });
    });
  }

  void getNearExpirePayment() {
    PaymentService.getAllPayment().then((response) {
      for (Payment payment in response) {
        if (payment.userId == Session.loggedInUser.userId &&
            payment.expiredDay != null) {
          // if expiring in 2 days or less
          if (payment.expiredDay!.difference(DateTime.now()).inDays <= 2) {
            setState(() {
              nearExpirePayment.add(payment);
            });
          }
        }
      }
      // if (nearExpirePayment.isNotEmpty) {
      //   tz.initializeTimeZones(); // Initialize timezone data

      //   final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      //     'your_channel_id',
      //     'your_channel_name',
      //     importance: Importance.max,
      //     priority: Priority.high,
      //   );
      //   final platformChannelSpecifics =
      //       NotificationDetails(android: androidPlatformChannelSpecifics);

      //   final title = 'Payment Expiring Soon';
      //   final body =
      //       'Your payment is about to expire in less than 2 days. Please renew your payment.';

      //   // Get the current timezone
      //   final currentTimeZone = tz.getLocation(DateTime.now().timeZoneName);

      //   // Loop through nearExpirePayment to schedule notifications
      //   for (Payment payment in nearExpirePayment) {
      //     // Calculate the difference between the expiration date and the current date
      //     final diff = payment.expiredDay!.difference(DateTime.now());

      //     // If the difference is less than 2 days
      //     if (diff.inDays < 2) {
      //       // Calculate the scheduled date and time for the notification
      //       final scheduledDateTime =
      //           tz.TZDateTime.from(payment.expiredDay!, currentTimeZone)
      //               .subtract(Duration(days: 1));

      //       // Schedule the notification
      //       notificationPlugin.zonedSchedule(
      //         0, // Use a unique ID for each notification
      //         title,
      //         body,
      //         scheduledDateTime,
      //         platformChannelSpecifics,
      //         uiLocalNotificationDateInterpretation:
      //             UILocalNotificationDateInterpretation.absoluteTime,
      //         payload: 'near_payment',
      //         matchDateTimeComponents: DateTimeComponents.time,
      //       );
      //     }
      //   }
      // }
    });
  }

  // void getListfamCar() {
  //   familyShareservice.getListfamilyCar().then((response) => setState(() {
  //         listfamcar1 = response;
  //         if (listfamcar1.isNotEmpty) {
  //           for (int i = 0; i < listfamcar1.length; i++) {
  //             if (Session.loggedInUser.familyId == listfamcar1[i].familyID) {
  //               CarDetailService.getListCarbyID(listfamcar1[i].CarID!)
  //                   .then((value) => setState(() {
  //                         listCarinfam += value;
  //                       }));
  //             }
  //           }
  //         }
  //       }));
  // }

  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentTime = DateFormat('yyyy-MM-dd  kk:mm').format(now);
    List<MenuTile> menu = [
      MenuTile('QR BY CAR IN FAMILY', 'Use car in family', Icons.qr_code, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Usecarinshare()));
      }),
      MenuTile('CHECK SPOT', 'check spot', Icons.location_on_outlined, () {
        if (dropdownValue == null) {
          _showMyDialog(context, "Error", "Please select a car to check spot");
          return;
        }
        SpotDetailService.getAllListSpot().then((response) {
          Spot? boughtSpot = null;
          Car? ca = null;
          // Find which spot has carId in listCar
          for (var spot in response) {
            if (spot.carId == dropdownValue!.carPlate) {
              boughtSpot = spot;
            }
          }
          CarDetailService.getListCar().then((value) {
            for (var c in value) {
              if (c.carPlate == dropdownValue!.carPlate) {
                ca = c;
              }
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(
                  listSpot: response,
                  boughtSpot: boughtSpot,
                  car: ca,
                ),
              ),
            );
          });
        });
      }),
      MenuTile('CHECK YOUR CAR', 'check your car', Icons.car_rental_rounded,
          () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CarInfoScreen(context)));
      }),
      MenuTile('BILL', 'bill', Icons.call_to_action_rounded, () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BillInfoScreen(context)));
      }),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              nearExpirePayment.length > 0
                  ? Icons.notifications_active
                  : Icons.notifications_none,
            ),
            onPressed: () {
              if (nearExpirePayment.length == 0 &&
                  localNotifications.length == 0) {
                return;
              }
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        Text(
                          'Notification',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () async {
                            // Add code here to clear notifications
                            // For example, you can call a function to clear notifications.
                            setState(() {
                              localNotifications = [];
                            });
                            await LocalNotificationService.clearNotifications();
                            Navigator.of(context).pop();
                          },
                          child: Text('Clear All'),
                        )
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (nearExpirePayment.length > 0)
                          for (Payment payment in nearExpirePayment) ...[
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                  '${payment.purpose} is about to expire in less than 2 days. Please renew your payment.'),
                            )
                          ],
                        // If there are local notifications, show them
                        if (localNotifications.length > 0)
                          for (String notification in localNotifications) ...[
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(notification),
                            )
                          ],
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/bga1png.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Image(image: AssetImage('images/iconn.png')),
            ),
            Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '----------------------------------------------------------------------------------------------------',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(100, 161, 125, 17)),
                )),
            Container(
              // decoration: BoxDecoration(
              //   color: Colors.cyanAccent,
              // ),
              height: 50,
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.favorite_sharp,
                        color: Color.fromARGB(100, 161, 125, 17),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Hello, ${Session.loggedInUser.fullname ?? ""}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  // SizedBox(
                  //   width: 110,
                  // ),
                  // GestureDetector(
                  //     onTap: () {
                  //       Navigator.pushNamed(
                  //           context, ViewHistoryPage.routerName);
                  //     },
                  //     child: Icon(
                  //       Icons.book_online_sharp,
                  //       size: 40,
                  //       color: Color.fromARGB(255, 165, 110, 7),
                  //     )),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: 390,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 37, 38, 47),
                border: Border.all(color: Colors.black38, width: 3),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                            padding: EdgeInsets.only(left: 50),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Car>(
                                alignment: Alignment.center,
                                dropdownColor: Color.fromARGB(255, 37, 38, 47),
                                underline: Container(),
                                borderRadius: BorderRadius.circular(30),
                                hint: const Text(
                                  'Today, What car you use?',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                // icon: Image.asset('images/carrr.png'),
                                // iconSize: 45,
                                onChanged: (Car? newvalue) {
                                  setState(() {
                                    dropdownValue = newvalue!;
                                  });
                                },
                                value: dropdownValue,
                                items: listCar
                                    .map<DropdownMenuItem<Car>>((Car value) {
                                  return DropdownMenuItem<Car>(
                                      value: value,
                                      // child: Text('${value.carPlate}'),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            WidgetSpan(
                                                child: Icon(
                                              Icons.directions_car_sharp,
                                              size: 30,
                                            )),
                                            TextSpan(
                                                text:
                                                    '          ${value.carPlate}'),
                                          ],
                                        ),
                                      ));
                                }).toList(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                                elevation: 8,
                                isExpanded: true,
                              ),
                            )),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: 100,
                  width: 420,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 37, 38, 47).withOpacity(0.09),
                      border: Border.all(
                          width: 2.0, color: Color.fromARGB(100, 161, 125, 17)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Icon(
                          Icons.home,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Session.loggedInUser.familyId == null
                              ? TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'None',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ))
                              : TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, FamilyScreen.routerName);
                                  },
                                  child: Text(
                                    '${Session.loggedInUser.familyId}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                          Text(
                            'Amagazing home',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            Container(
              color: Colors.transparent,
              child: GridView.builder(
                  itemCount: menu.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.6,
                      crossAxisCount: 2,
                      mainAxisExtent: 102),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: menu[index].onTap as void Function()?,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 6),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: kButtonBorderColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadedScaleAnimation(
                              scaleDuration: const Duration(milliseconds: 400),
                              fadeDuration: const Duration(milliseconds: 400),
                              child: Text(
                                menu[index].title!,
                                // style: Theme.of(context)
                                //     .textTheme
                                //     .bodyLarge!
                                //     .copyWith(fontWeight: FontWeight.bold),
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    menu[index].subtitle!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            fontSize: 12,
                                            color: lightGreyColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  menu[index].iconData,
                                  size: 30.sp,
                                  color: kContainerTextColor.withOpacity(0.8),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: ElevatedButton(
            //     style: buttonPrimary,
            //     onPressed: () {
            //       Navigator.pushNamed(context, Booking1Screen.routerName);
            //     },
            //     child: Text(
            //       'Booking',
            //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: ElevatedButton.icon(
            //     style: buttonPrimary,
            //     onPressed: () {
            //       Session.loggedInUser.familyId == null
            //           ? _showMyDialog(context, "Error",
            //               "Sorry for the inconvenience, you must join a family group to use this funtion")
            //           : Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => const Usecarinshare()));
            //     },
            //     icon: Icon(
            //       Icons.directions_car_outlined,
            //       size: 50,
            //     ),
            //     label: Text(
            //       'GENERATE QR BY CAR IN FAMILY',
            //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: ElevatedButton.icon(
            //     style: buttonPrimary,
            //     onPressed: () async {
            //       if (dropdownValue == null) {
            //         _showMyDialog(
            //             context, "Error", "Please select a car to check spot");
            //         return;
            //       }
            //       SpotDetailService.getAllListSpot().then((response) {
            //         Spot? boughtSpot = null;
            //         Car? ca = null;
            //         // Find which spot has carId in listCar
            //         for (var spot in response) {
            //           if (spot.carId == dropdownValue!.carPlate) {
            //             boughtSpot = spot;
            //           }
            //         }
            //         CarDetailService.getListCar().then((value) {
            //           for (var c in value) {
            //             if (c.carPlate == dropdownValue!.carPlate) {
            //               ca = c;
            //             }
            //           }

            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => MapScreen(
            //                 listSpot: response,
            //                 boughtSpot: boughtSpot,
            //                 car: ca,
            //               ),
            //             ),
            //           );
            //         });
            //       });
            //       // Navigator.pushNamed(context, viewSpotPage.routerName);
            //     },
            //     icon: Icon(
            //       Icons.directions_car_outlined,
            //       size: 50,
            //     ),
            //     label: Text(
            //       'CHECK SPOT',
            //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: ElevatedButton.icon(
            //     style: buttonPrimary,
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => CarInfoScreen(
            //             context,
            //           ),
            //         ),
            //       );
            //     },
            //     icon: Icon(
            //       Icons.directions_car_outlined,
            //       size: 50,
            //     ),
            //     label: Text(
            //       'CHECK YOUR CAR',
            //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: ElevatedButton.icon(
            //     style: buttonPrimary,
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => BillInfoScreen(
            //             context,
            //           ),
            //         ),
            //       );
            //     },
            //     icon: Icon(
            //       Icons.payment,
            //       size: 50,
            //     ),
            //     label: Text(
            //       'BILL',
            //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(color: Colors.white, spreadRadius: 7, blurRadius: 1)
        ]),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              code = dropdownValue?.carPlate;
              var rng = Random();
              for (var i = 100000; i < 1000000; i++) {
                Codesecurity = rng.nextInt(1000000).toString();
                break;
              }

              DateTime now = DateTime.now();
              String formattedDate =
                  DateFormat('yyyy-MM-dd – kk:mm').format(now);

              Map<String, dynamic> toJson() => {
                    "carID": dropdownValue?.carPlate,
                    "time": currentTime,
                    "securityCode": Codesecurity,
                    "fullname": Session.loggedInUser.fullname,
                  };
            });
            if (dropdownValue?.carPlate == null) {
              showDialog(
                  context: context,
                  builder: (context) => Form(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 60, right: 60, top: 350, bottom: 400),
                        child: Container(
                          padding: EdgeInsets.only(left: 9, top: 30),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              border: Border.all(
                                  width: 2.0,
                                  color: Color.fromARGB(100, 161, 125, 17)),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "Please choose your car!",
                            style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.none,
                                color: Colors.black),
                          ),
                        ),
                      )));
            } else if (dropdownValue?.verifyState1 == null ||
                dropdownValue?.verifyState1 == false) {
              showDialog(
                  context: context,
                  builder: (context) => Form(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 350, bottom: 390),
                        child: Container(
                          padding: EdgeInsets.only(left: 9),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              border: Border.all(
                                  width: 2.0,
                                  color: Color.fromARGB(100, 161, 125, 17)),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "*Your car is not authenticated state 1!\n*Please waiting for admin to authenticated state 1",
                            style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.none,
                                color: Colors.black),
                          ),
                        ),
                      )));
            } else if (dropdownValue?.verifyState2 == null ||
                dropdownValue?.verifyState2 == false) {
              showDialog(
                  context: context,
                  builder: (context) => Form(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 350, bottom: 330),
                        child: Container(
                          padding: EdgeInsets.only(left: 9),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              border: Border.all(
                                  width: 2.0,
                                  color: Color.fromARGB(100, 161, 125, 17)),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "*Your car has not registered for the apartment's parking package \n*Please subscribe to the package and try again",
                            style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.none,
                                color: Colors.black),
                          ),
                        ),
                      )));
            } else {
              Car car = Car(
                  carId: dropdownValue!.carId,
                  carName: dropdownValue!.carName,
                  carPlate: dropdownValue!.carPlate,
                  carColor: dropdownValue!.carColor,
                  carPaperFront: dropdownValue!.carPaperFront,
                  carPaperBack: dropdownValue!.carPaperBack,
                  verifyState1: dropdownValue!.verifyState1,
                  verifyState2: dropdownValue!.verifyState2,
                  securityCode: Codesecurity,
                  historyID: dropdownValue!.historyID,
                  userId: dropdownValue!.userId);
              CarService.updateCar(car, dropdownValue!.carId!);
              // .then((value) => Timer(const Duration(seconds: 120), () {
              //           // Navigator.pushAndRemoveUntil(
              //           //   context,
              //           //   MaterialPageRoute(builder: (context) => HomeScreen()),
              //           //   (route) => false,
              //           // );
              //         })

              //       Car car = Car(
              //           carId: dropdownValue!.carId,
              //           carName: dropdownValue!.carName,
              //           carPlate: dropdownValue!.carPlate,
              //           carColor: dropdownValue!.carColor,
              //           carPaperFront: dropdownValue!.carPaperFront,
              //           carPaperBack: dropdownValue!.carPaperBack,
              //           verifyState1: dropdownValue!.verifyState1,
              //           verifyState2: dropdownValue!.verifyState2,
              //           securityCode: null,
              //           familyId: dropdownValue!.familyId);
              //       CarService.updateCar(car, dropdownValue!.carId!)
              //           .then((value) => Navigator.pop(context));
              //     })

              // );

              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Form(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 60, right: 60, top: 150, bottom: 150),
                        child: Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 2.0,
                                    color: Color.fromARGB(100, 161, 125, 17)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                const Text('Your QR Code',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Text(
                                      'Please present your QR code to the parking lot',
                                      style: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.grey,
                                        fontSize: 8,
                                      )),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                code == ''
                                    ? Text('')
                                    : BarcodeWidget(
                                        barcode: Barcode.qrCode(
                                          errorCorrectLevel:
                                              BarcodeQRCorrectionLevel.high,
                                        ),

                                        data: QrToJson(Qrcode(
                                            carplate: dropdownValue?.carPlate,
                                            datetime: currentTime,
                                            securityCode: Codesecurity,
                                            username:
                                                Session.loggedInUser.fullname)),
                                        // 'carplate: ${dropdownValue?.carPlate} \ntime: $currentTime \nHint code: $Codesecurity\n user: ${Session.loggedInUser.fullname}',
                                        width: 200,
                                        height: 200,
                                      ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 60,
                                    // right: 60,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'images/carrr.png',
                                        fit: BoxFit.cover,
                                        width: 30,
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('${dropdownValue?.carPlate}',
                                          style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 50,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 3.0, color: Colors.blue),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Time In',
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "${now}",
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 26, 145, 243)),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    height: 50,
                                    width: 250,
                                    child: ElevatedButton(
                                      child: Text(
                                        "Exit",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                          (route) => false,
                                        );
                                      },
                                    )),
                              ],
                            )),
                      )));
            }
            ;
          },
          child: const Icon(
            Icons.qr_code,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationBar(selectedCatIndex, context),
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
