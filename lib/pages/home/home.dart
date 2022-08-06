import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust/pages/home/Baggages/baggages.dart';
import 'package:wanderlust/theme/theme.dart';

import 'flight_add.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          centerTitle: true,
          title: const Text(
            "Anasayfa",
            style: TextStyle(color: textColor),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Flights")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      primary: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, i) {
                        QueryDocumentSnapshot data = snapshot.data!.docs[i];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(8)),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          BaggagesPage(id: "${data.id}")));
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Expanded(
                                          flex: 4,
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            "${data.id}",
                                            style: TextStyle(fontSize: 12),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Expanded(
                                          flex: 3,
                                          child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              "${data["where"]} - ${data["to"]} ")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Expanded(
                                          flex: 1,
                                          child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              "${data["time"]}")),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FlightAddPage()));
          },
          icon: const Icon(Icons.add),
          label: const Text('Flight Ekle'),
          backgroundColor: appBarColor,
        ),
      ),
    );
  }
}
