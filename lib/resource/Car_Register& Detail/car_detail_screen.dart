import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:webspc/styles/button.dart';
import '../../Api_service/car_detail_service.dart';
import '../../DTO/cars.dart';
// ignore: depend_on_referenced_packages

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({super.key});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  List<Car> listCar = [];
  Car? carDetail;

  @override
  void initState() {
    getListCar();
    super.initState();
  }

  void getListCar() {
    CarDetailService.getListCar().then((response) => setState(() {
          listCar = response;
          if (listCar.isNotEmpty) {
            carDetail = listCar.first;
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/bga.png'),
                fit: BoxFit.cover,
              )),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _headerWidget(),
                  const SizedBox(height: 15),
                  carGalleryWidget(sizingInformation),
                  const SizedBox(height: 15),
                  _infoWidget(sizingInformation),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _headerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "User's Car",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(
                'images/chat.png',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _profileRowDataWidget(),
      ],
    );
  }

  Widget _profileRowDataWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: const [
            Icon(
              Icons.star,
              color: Color.fromARGB(195, 221, 215, 33),
            ),
            Text(
              "4.5",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }

  Widget carGalleryWidget(SizingInformation sizingInformation) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: <Widget>[
          Container(
            width: sizingInformation.localWidgetSize.width,
            height: 180,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: carDetail == null ||
                        carDetail?.carPaperFront == null ||
                        carDetail?.carId == ""
                    ? Image.asset(
                        "images/carrr.png",
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        carDetail!.carPaperFront!,
                        fit: BoxFit.cover,
                      )),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 80,
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listCar.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      carDetail = listCar[index];
                    });
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: listCar[index].carPaperFront == null ||
                              listCar[index].carId == ""
                          ? Image.asset(
                              "images/carrr.png",
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              listCar[index].carPaperFront!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _infoWidget(SizingInformation sizingInformation) {
    return Column(
      children: <Widget>[
        Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Car Information:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.red),
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Car's Name:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(carDetail == null || carDetail?.carName == null
                        ? ""
                        : carDetail!.carName!),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Plate Number:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(carDetail == null || carDetail?.carPlate == null
                        ? ""
                        : carDetail!.carPlate!),
                  ],
                ),
                const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Text(
                //       "Car Type:",
                //       style:
                //           TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                //     ),
                //     Text(
                //       "SUV",
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Color:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(carDetail == null || carDetail?.carColor == null
                        ? ""
                        : carDetail!.carColor!),
                  ],
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Car Paper (Front)",
                      ),
                      Text(
                        "ADD",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Car Paper (Back)",
                      ),
                      Text(
                        "ADD",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        const SizedBox(height: 20),
        TextButton(
            onPressed: () {},
            style: buttonPrimary,
            child: const Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 0.5,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            )),
        const SizedBox(height: 20),
        TextButton(
            onPressed: () {},
            style: buttonPrimary,
            child: const Text(
              "Remove Car Details",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 0.5,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    );
  }
}
