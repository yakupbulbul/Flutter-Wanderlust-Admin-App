import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust/theme/theme.dart';

import 'checkinAdd.dart';

class CheckinPage extends StatefulWidget {
  final String id;
  final String flight_id;
  final String name;
  final String surname;

  const CheckinPage(
      {Key? key,
      required this.id,
      required this.flight_id,
      required this.name,
      required this.surname})
      : super(key: key);

  @override
  _CheckinPageState createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          centerTitle: true,
          title: const Text(
            "Kontrol Noktasi",
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
                      .doc("${widget.flight_id}")
                      .collection("Baggages")
                      .doc("${widget.id}")
                      .collection("Checkin")
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
                        print(
                            "snapshot.data!.docs.lengthsnapshot.data!.docs.lengthsnapshot.data!.docs.length: ${snapshot.data!.docs.length}");
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(8)),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Expanded(
                                        flex: 4,
                                        child: Text("${data["where"]}")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Expanded(
                                        flex: 1,
                                        child: Text("${data["time"]}")),
                                  ),
                                ],
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CheckinAddPage(
                      flight_id: widget.flight_id,
                      baggage_id: widget.id,
                    )));
          },
          icon: const Icon(Icons.add),
          label: const Text('Kontrol Noktasi Ekle'),
          backgroundColor: appBarColor,
        ),
      ),
    );
  }
}
