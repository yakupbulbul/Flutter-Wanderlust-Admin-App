import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust/theme/theme.dart';

class CheckinAddPage extends StatefulWidget {
  final String flight_id;
  final String baggage_id;

  const CheckinAddPage(
      {Key? key, required this.flight_id, required this.baggage_id})
      : super(key: key);

  @override
  _CheckinAddPageState createState() => _CheckinAddPageState();
}

bool finish = true;
TextEditingController checkinController = TextEditingController();
TextEditingController timeController = TextEditingController();
bool _validatecheckin = false;
bool _validatetime = false;

class _CheckinAddPageState extends State<CheckinAddPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          centerTitle: true,
          title: const Text(
            "Kontrol Noktası Ekle",
            style: TextStyle(color: textColor),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 30, 12, 20),
          child: Column(
            children: [
              TextField(
                controller: checkinController,
                decoration: InputDecoration(
                    errorText:
                        _validatecheckin ? 'Kontrol Noktası Boş Olamaz' : null,
                    labelText: 'Bulunduğu Kontrol Noktası Örn: VIP Gate',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3, color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: timeController,
                decoration: InputDecoration(
                    errorText: _validatetime ? 'Saat Boş Bırakılmaz' : null,
                    labelText: 'Bulunduğu Kontrol Noktasına Ulaşım Saati',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 3, color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    checkinController.text.isEmpty
                        ? _validatecheckin = true
                        : _validatecheckin = false;
                    timeController.text.isEmpty
                        ? _validatetime = true
                        : _validatetime = false;

                    //checkinController.text.isEmpty? _validatecheckin = true: _validatecheckin = false;
                  });
                  if (checkinController.text.isNotEmpty &&
                          timeController.text.isNotEmpty
                      //&& checkinController.text.isNotEmpty
                      ) {
                    FirebaseFirestore.instance
                        .collection('Flights')
                        .doc("${widget.flight_id}")
                        .collection("Baggages")
                      ..doc("${widget.baggage_id}").collection("Checkin").add({
                        'where': checkinController.text,
                        'time': timeController.text,
                      });
                  }
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  primary: appBarColor, //backgroundColor: Colors.amber
                ),
                icon: Icon(Icons.airplane_ticket),
                label: Text("OLUŞTUR"),
              )
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('Flights')
                .doc("${widget.flight_id}")
                .collection("Baggages")
                .doc("${widget.baggage_id}")
                .update({
              'stuation': true,
              //'checkin': checkinController.text,
            });
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.add),
          label: const Text('Süreç Tamamlandı'),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
