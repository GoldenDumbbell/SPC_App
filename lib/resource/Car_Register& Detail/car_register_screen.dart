// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../Api_service/car_register_service.dart';
import '../../DTO/cars.dart';
import '../../DTO/section.dart';
import '../../styles/fadeanimation.dart';

enum FormData { Name, Plate, Color, PpFront, PpBack }

class CarRegisterScreen extends StatefulWidget {
  const CarRegisterScreen({super.key});

  @override
  State<CarRegisterScreen> createState() => _CarRegisterScreenState();
}

class _CarRegisterScreenState extends State<CarRegisterScreen> {
  final RoundedLoadingButtonController _btnRegisterCar =
      RoundedLoadingButtonController();

  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);

  FormData? selected;

  TextEditingController nameController = TextEditingController();
  TextEditingController plateController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController carIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/bga.png'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color:
                      const Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Image.asset('images/logo.png'),
                        const SizedBox(
                          height: 15,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Text(
                            "Register your car",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white.withOpacity(0.9),
                                letterSpacing: 0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Name
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: nameController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.Name;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.title,
                                  color: selected == FormData.Name
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Car Name',
                                hintStyle: TextStyle(
                                    color: selected == FormData.Name
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.Name
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Plate
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: plateController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.Plate;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.numbers,
                                  color: selected == FormData.Plate
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Plate Number',
                                hintStyle: TextStyle(
                                    color: selected == FormData.Plate
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.Plate
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Color
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: colorController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.Color;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.color_lens,
                                  color: selected == FormData.Color
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Color',
                                hintStyle: TextStyle(
                                    color: selected == FormData.Color
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.Color
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 20),
                        // FadeAnimation(
                        //   delay: 1,
                        //   child: Container(
                        //     width: 300,
                        //     height: 40,
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(12.0),
                        //         color: selected == FormData.PpBack
                        //             ? enabled
                        //             : backgroundColor),
                        //     padding: const EdgeInsets.all(5.0),
                        //     child: TextField(
                        //       controller: carIdController,
                        //       onTap: () {
                        //         setState(() {
                        //           selected = FormData.PpBack;
                        //         });
                        //       },
                        //       decoration: InputDecoration(
                        //           enabledBorder: InputBorder.none,
                        //           border: InputBorder.none,
                        //           prefixIcon: Icon(
                        //             Icons.abc,
                        //             color: selected == FormData.PpBack
                        //                 ? enabledtxt
                        //                 : deaible,
                        //             size: 20,
                        //           ),
                        //           hintText: 'Car Id',
                        //           hintStyle: TextStyle(
                        //               color: selected == FormData.PpBack
                        //                   ? enabledtxt
                        //                   : deaible,
                        //               fontSize: 12)),
                        //       textAlignVertical: TextAlignVertical.center,
                        //       style: TextStyle(
                        //           color: selected == FormData.PpBack
                        //               ? enabledtxt
                        //               : deaible,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 12),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 25),
                        FadeAnimation(
                          delay: 1,
                          child: RoundedLoadingButton(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.055,
                            color: const Color.fromRGBO(20, 160, 240, 1.0),
                            controller: _btnRegisterCar,
                            onPressed: () {
                              Car newCar = Car(
                                  carId: null,
                                  carName: nameController.text,
                                  carPlate: plateController.text,
                                  carColor: colorController.text,
                                  carPaperFront: null,
                                  carPaperBack: "",
                                  verifyState1: null,
                                  verifyState2: null,
                                  securityCode: "",
                                  familyId: Session.loggedInUser.familyId);
                              CarRegisterService.registerCar(newCar)
                                  .then((value) {
                                carIdController.clear();
                                nameController.clear();
                                plateController.clear();
                                colorController.clear();
                                _btnRegisterCar.reset();
                              });
                            },
                            child: const Text("SIGN IN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )),
                            // borderRadius: MediaQuery.of(context).size.height * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //End of Center Card
                //Start of outer card
                const SizedBox(height: 20),

                // FadeAnimation(
                //   delay: 1,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       const Text("If you already have registered a car:",
                //           style: TextStyle(
                //             color: Color.fromARGB(255, 60, 243, 99),
                //             letterSpacing: 0.5,
                //             fontSize: 15.0,
                //           )),
                //       Padding(
                //         padding: const EdgeInsets.all(10.0),
                //         child: ElevatedButton(
                //           onPressed: () {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) =>
                //                         const CarDetailScreen()));
                //           },
                //           child: const Text('Car Detail'),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
