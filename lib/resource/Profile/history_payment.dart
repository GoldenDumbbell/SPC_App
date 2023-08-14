import 'package:flutter/material.dart';
import 'package:webspc/Api_service/history_services.dart';
import 'package:webspc/Api_service/payment_service.dart';
import 'package:webspc/DTO/history.dart';
import 'package:webspc/DTO/payment.dart';

import '../../DTO/section.dart';

class ViewHistoryPaymentPage extends StatefulWidget {
  const ViewHistoryPaymentPage({super.key});
  static const routeName = 'viewHistoryPaymentPage';

  @override
  State<ViewHistoryPaymentPage> createState() => _ViewHistoryPaymentPageState();
}

class _ViewHistoryPaymentPageState extends State<ViewHistoryPaymentPage> {
  bool isLoading = true;
  List<History> listHistory = [];
  List<History> filteredHistory = [];
  List<Payment> listPayment = [];
  List<Payment> listSelectedPayment = [];
  TextEditingController searchController = TextEditingController();
  DateTime? selectedDate;
  String? searchQuery;
  int selectedIndex = 0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void resetFilters() {
    searchController.clear();
    setState(() {
      searchQuery = null;
      selectedDate = null;
    });
  }

  void getListPayment() {
    isLoading = false;
    PaymentService.getAllPayment().then((value) {
      // Only get payment of logged in user
      value = value
          .where((payment) => payment.userId == Session.loggedInUser.userId)
          .toList();
      value.sort((a, b) => DateTime.parse(b.paymentdate ?? '')
          .compareTo(DateTime.parse(a.paymentdate ?? '')));
      setState(() {
        listPayment = value;
      });
    });
  }

  List<Payment> getSelectedPayment() {
    List<Payment> listSelectedPayment = [];
    switch (selectedIndex) {
      case 0:
        listSelectedPayment = listPayment;
        break;
      case 1:
        listSelectedPayment = listSelectedPayment = listPayment
            .where((payment) => payment.purpose == 'Top up')
            .toList();
        break;
      case 2:
        listSelectedPayment = listSelectedPayment =
            listPayment.where((payment) => payment.amount! < 0).toList();
        break;
      default:
        listSelectedPayment = listPayment;
    }
    // Filter by selected date
    if (selectedDate != null) {
      listSelectedPayment = listSelectedPayment.where((payment) {
        final paymentDate = DateTime.parse(payment.paymentdate ?? '').toLocal();
        return paymentDate.year == selectedDate!.year &&
            paymentDate.month == selectedDate!.month &&
            paymentDate.day == selectedDate!.day;
      }).toList();
    }
    return listSelectedPayment;
  }

  @override
  void initState() {
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bga1png.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Your History Payment",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              // Add search bar
              SizedBox(
                height: 20,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.3),
              //         spreadRadius: 2,
              //         blurRadius: 5,
              //         offset: Offset(0, 3),
              //       ),
              //     ],
              //   ),
              //   child: TextField(
              //     controller: searchController,
              //     style: TextStyle(
              //       fontSize: 18,
              //       color: Colors.black,
              //     ),
              //     decoration: InputDecoration(
              //       contentPadding:
              //           EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              //       hintText: 'Enter car plate to search',
              //       hintStyle: TextStyle(
              //         fontSize: 18,
              //         color: Colors.grey.withOpacity(0.6),
              //       ),
              //       border: InputBorder.none,
              //       enabledBorder: InputBorder.none,
              //       focusedBorder: InputBorder.none,
              //       errorBorder: InputBorder.none,
              //       disabledBorder: InputBorder.none,
              //     ),
              //     onChanged: (query) {
              //       setState(() {
              //         searchQuery = query;
              //       });
              //     },
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      selectedDate == null
                          ? 'Select Date'
                          : 'Selected Date: ${selectedDate!.toString().substring(0, 10)}',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: resetFilters,
                    child: Text('Reset Filters'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width * 0.9 / 3,
                            child: Center(
                              child: Text(
                                "All",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width * 0.9 / 3,
                            child: Center(
                              child: Text(
                                "Cash in",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width * 0.9 / 3,
                            child: Center(
                              child: Text(
                                "Cash out",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AnimatedPositioned(
                      left: MediaQuery.of(context).size.width *
                          0.9 /
                          3 *
                          selectedIndex,
                      bottom: 0,
                      child: Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width * 0.9 / 3,
                        color: Colors.white,
                      ),
                      duration: Duration(milliseconds: 200),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: getSelectedPayment().length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          if (selectedIndex == 2) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Join day: ${getSelectedPayment()[index].joinDay == null ? '' : getSelectedPayment()[index].joinDay!.toString().substring(0, 10)}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Expired day: ${getSelectedPayment()[index].expiredDay == null ? '' : getSelectedPayment()[index].expiredDay!.toString().substring(0, 10)}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }
                        },
                        title: Text(
                          getSelectedPayment()[index].paymentdate == null
                              ? ''
                              : getSelectedPayment()[index]
                                  .paymentdate!
                                  .toString()
                                  .substring(0, 10),
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${getSelectedPayment()[index].purpose}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            // Text(
                            //   'Amount: ${getSelectedPayment()[index].amount!.ceil()}',
                            //   style: TextStyle(
                            //     fontSize: 18,
                            //     color: Colors.black,
                            //     decoration: TextDecoration.none,
                            //   ),
                            // ),
                          ],
                        ),
                        trailing: Text(
                          formatAmount(getSelectedPayment()[index].amount!),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  String formatAmount(double amount) {
    String amountString = "";
    // Check if amount is negative
    if (amount < 0) {
      // Remove negative sign
      amount = amount.abs();
      amountString = amount.ceil().toString();
      // Add , every 3 digits
      amountString = "- " + amountString;
    } else {
      amountString = amount.ceil().toString();
      amountString = "+ " + amountString;
    }
    for (int i = amountString.length - 3; i > 2; i -= 3) {
      amountString = amountString.substring(0, i) +
          ',' +
          amountString.substring(i, amountString.length);
    }
    return amountString;
  }
}
