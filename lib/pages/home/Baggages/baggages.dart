import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust/pages/home/Baggages/baggage_add.dart';
import 'package:wanderlust/theme/theme.dart';

import '../Checkin/checkin.dart';

class BaggagesPage extends StatefulWidget {
  final String id;
  const BaggagesPage({Key? key, required this.id}) : super(key: key);

  @override
  _BaggagesPageState createState() => _BaggagesPageState();
}

class _BaggagesPageState extends State<BaggagesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          centerTitle: true,
          title: const Text(
            "Bağaj",
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
                      .doc("${widget.id}")
                      .collection("Baggages")
                      .snapshots(),
                  builder: (context, snapshot) {
                    print(widget.id);
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
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CheckinPage(
                                          id: "${data.id}",
                                          flight_id: widget.id,
                                          name: "${data["name"]}",
                                          surname: "${data["surname"]}",
                                        )));
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Expanded(
                                        flex: 1, child: Text("${data.id}")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Expanded(
                                        flex: 1,
                                        child: Text(
                                            "${data["name"]} ${data["surname"]}")),
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
                builder: (context) => BaggageAddPage(id: widget.id)));
          },
          icon: const Icon(Icons.add),
          label: const Text('Bağaj Ekle'),
          backgroundColor: appBarColor,
        ),
      ),
    );
  }
}
