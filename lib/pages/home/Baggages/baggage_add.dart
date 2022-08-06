import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanderlust/theme/theme.dart';

class BaggageAddPage extends StatefulWidget {
  final String id;
  const BaggageAddPage({Key? key, required this.id}) : super(key: key);

  @override
  _BaggageAddPageState createState() => _BaggageAddPageState();
}

TextEditingController nameController = TextEditingController();
TextEditingController surnameController = TextEditingController();
TextEditingController checkinController = TextEditingController();
//TextEditingController toWhereController = TextEditingController();
bool _validatename = false;
bool _validatesurname = false;
bool _validatecheckin = false;

class _BaggageAddPageState extends State<BaggageAddPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          centerTitle: true,
          title: const Text(
            "Bağajlar",
            style: TextStyle(color: textColor),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 30, 12, 20),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    errorText: _validatename ? 'İsim Boş Olamaz' : null,
                    labelText: 'İsim Örn: Ezgi',
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
                controller: surnameController,
                decoration: InputDecoration(
                    errorText: _validatesurname ? 'Soyisim Boş Olamaz' : null,
                    labelText: 'Soyisim Örn: Yılmaz',
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
                    nameController.text.isEmpty
                        ? _validatename = true
                        : _validatename = false;
                    surnameController.text.isEmpty
                        ? _validatesurname = true
                        : _validatesurname = false;

                    //checkinController.text.isEmpty? _validatecheckin = true: _validatecheckin = false;
                  });
                  if (nameController.text.isNotEmpty &&
                          surnameController.text.isNotEmpty
                      //&& checkinController.text.isNotEmpty
                      ) {
                    FirebaseFirestore.instance
                        .collection('Flights')
                        .doc("${widget.id}")
                        .collection("Baggages")
                        .add({
                      'name': nameController.text,
                      'surname': surnameController.text,
                      'stuation': false,
                      //'checkin': checkinController.text,
                    });
                  }
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  primary: appBarColor,
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
