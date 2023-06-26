import 'package:flutter/material.dart';
import 'package:webspc/Api_service/history_services.dart';
import 'package:webspc/DTO/history.dart';

class ViewUserHistoryPage extends StatefulWidget {
  const ViewUserHistoryPage({super.key});
  static const routeName = 'viewUserHistoryPage';

  @override
  State<ViewUserHistoryPage> createState() => _ViewUserHistoryPageState();
}

class _ViewUserHistoryPageState extends State<ViewUserHistoryPage> {
  bool isLoading = true;
  List<History> listHistory = [];

  void getListHistory() {
    isLoading = false;
    HistoryService.getListHistory().then((value) {
      setState(() {
        listHistory = value;
      });
    });
  }

  @override
  void initState() {
    getListHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/bga1png.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Your History",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listHistory.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          listHistory[index].carPlate ?? '',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Name: ${DateTime.parse(listHistory[index].userId ?? '').toString().substring(0, 19)}',
                            //   style: TextStyle(
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.black,
                            //     decoration: TextDecoration.none,
                            //   ),
                            // ),
                            Text(
                              'Time in: ${DateTime.parse(listHistory[index].timeIn ?? '').toString().substring(0, 19)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Text(
                              'Time out: ${DateTime.parse(listHistory[index].timeOut ?? '').toString().substring(0, 19)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                        trailing: Text(
                          'Amount',
                          semanticsLabel: listHistory[index].amount ?? '',
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
          ));
    }
  }
}
