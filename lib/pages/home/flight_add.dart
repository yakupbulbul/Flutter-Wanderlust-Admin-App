import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust/theme/theme.dart';

class FlightAddPage extends StatefulWidget {
  @override
  _FlightAddPageState createState() => _FlightAddPageState();
}

TextEditingController timeController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController whereController = TextEditingController();
TextEditingController toWhereController = TextEditingController();
bool _validatetime = false;
bool _validatedate = false;
bool _validatewhere = false;
bool _validateto = false;

class _FlightAddPageState extends State<FlightAddPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          centerTitle: true,
          title: const Text(
            "Uçuş Ekle",
            style: TextStyle(color: textColor),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 30, 12, 20),
          child: Column(
            children: [
              TextField(
                controller: timeController,
                decoration: InputDecoration(
                    errorText: _validatetime ? 'Saat Değeri Boş Olamaz' : null,
                    labelText: 'Saat Örn: 13:45',
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
                controller: dateController,
                decoration: InputDecoration(
                    errorText: _validatedate ? 'Tarih Değeri Boş Olamaz' : null,
                    labelText: 'Tarih Örn: 15/04/2022',
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
                controller: whereController,
                decoration: InputDecoration(
                    errorText: _validatewhere ? 'Gidilen Yer Boş Olamaz' : null,
                    labelText: 'Gidilen Yer Örn: İstanbul',
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
                controller: toWhereController,
                decoration: InputDecoration(
                    errorText: _validateto ? 'Nereden Boş Olamaz' : null,
                    labelText: 'Nereden Örn: Kayseri',
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
                    timeController.text.isEmpty
                        ? _validatetime = true
                        : _validatetime = false;
                    dateController.text.isEmpty
                        ? _validatedate = true
                        : _validatedate = false;

                    whereController.text.isEmpty
                        ? _validatewhere = true
                        : _validatewhere = false;

                    toWhereController.text.isEmpty
                        ? _validateto = true
                        : _validateto = false;
                  });
                  if (timeController.text.isNotEmpty &&
                      dateController.text.isNotEmpty &&
                      whereController.text.isNotEmpty &&
                      toWhereController.text.isNotEmpty) {
                    FirebaseFirestore.instance.collection('Flights').add({
                      'time': timeController.text,
                      'date': dateController.text,
                      'where': whereController.text,
                      'to': toWhereController.text,
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
      ),
    );
  }
}
