// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:utscrud/owner.dart';
import 'database.dart';
import 'owner.dart';

class OwnerForm extends StatefulWidget {
  final Ownerdata? owner;

  OwnerForm({this.owner});

  @override
  OwnerFormState createState() => OwnerFormState();
}

class OwnerFormState extends State<OwnerForm> {
  AppDatabase db = AppDatabase();

  TextEditingController? ownerName;
  TextEditingController? phoneNum;
  TextEditingController? petName;
  TextEditingController? address;
  TextEditingController? services;

  String? servType; // dropdown thingy
  List servTypes = [
    "Grooming - Cat",
    "Grooming - Dog",
    "Vaccine - Cat",
    "Vaccine - Dog",
    "Medical Check Up"
  ];

  @override
  void initState() {
    ownerName = TextEditingController(
        text: widget.owner == null ? '' : widget.owner!.ownerName);

    phoneNum = TextEditingController(
        text: widget.owner == null ? '' : widget.owner!.phoneNum);

    petName = TextEditingController(
        text: widget.owner == null ? '' : widget.owner!.petName);

    address = TextEditingController(
        text: widget.owner == null ? '' : widget.owner!.address);

    services = TextEditingController(
        text: widget.owner == null ? '' : widget.owner!.services);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: petName,
              decoration: InputDecoration(
                  labelText: 'Pet Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(30),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: ownerName,
              decoration: InputDecoration(
                  labelText: 'Owner Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(30),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: phoneNum,
              decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(30),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: address,
              decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(30),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: DropdownButton(
              hint: Text('Choose our Services'),
              value: servType,
              items: servTypes
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  servType = value as String;
                  services?.text = servType!;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.owner == null)
                  ? Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)))),
              onPressed: () {
                updateOwner();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateOwner() async {
    if (widget.owner != null) {
      //update
      await db.updateOwner(Ownerdata.fromMap({
        'id': widget.owner!.id,
        'ownerName': ownerName!.text,
        'phoneNum': phoneNum!.text,
        'petName': petName!.text,
        'address': address!.text,
        'services': services!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.insertOwner(Ownerdata(
        ownerName: ownerName!.text,
        phoneNum: phoneNum!.text,
        petName: petName!.text,
        address: address!.text,
        services: services!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
