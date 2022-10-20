// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, unused_element, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'form.dart';
import 'database.dart';
import 'owner.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  List<Ownerdata> dataList = [];
  AppDatabase db = AppDatabase();

  @override
  void initState() {
    //reading whats in the database 
    getOwnerall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('PetCare App'),
        leading: IconButton(
          icon: Image(image: AssetImage('assets/petcare.png')),
          onPressed: () {},
        )
      ),

      body: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            Ownerdata owner = dataList[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.pets_rounded,
                  color: Colors.green,
                  size: 54,
                ),
                title: Text('${owner.petName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                )),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 6,
                      ),
                      child: Text("Owner     : ${owner.ownerName}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 6,
                      ),
                      child: Text("Phone     : ${owner.phoneNum}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 6,
                      ),
                      child: Text("Address  : ${owner.address}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 6,
                      ),
                      child: Text("Services : ${owner.services}"),
                    )
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Column(
                    children: [
                      // Edit button
                      IconButton(
                          onPressed: () {
                            editForm(owner);
                          },
                          icon: Icon(
                            color: Colors.green, Icons.edit, size: 50,)),
                      // Delete button
                      IconButton(
                        padding: EdgeInsets.only(top: 50, left: 5,),
                        icon: Icon(
                          color: Colors.green, Icons.delete, size: 50,),
                        onPressed: () {
                          //Alert dialog 
                          AlertDialog del = AlertDialog(
                            title: Text("Are you sure?"),
                            content: Container(
                              height: 20,
                              child: Column(
                                children: [Text("Delete this data? ")],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                  onPressed: () {
                                    delOwnerdata(owner, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Yes")),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => del);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      //The + button thingy
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          openForm();
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> getOwnerall() async {
    //getting the data from the database when opening the apps for the first time
    var list = await db.getOwner();

    setState(() {
      dataList.clear();
      list!.forEach((owner) {
        //adding the data to the datalist
        dataList.add(Ownerdata.fromMap(owner));
      });
    });
  }

  //deleting the data
  Future<void> delOwnerdata(Ownerdata owner, int position) async {
    await db.delOwner(owner.id!);
    setState(() {
      dataList.removeAt(position);
    });
  }

  // open form
  Future<void> openForm() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => OwnerForm()));
    if (result == 'save') {
      await getOwnerall();
    }
  }

  //edit form page
  Future<void> editForm(Ownerdata owner) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => OwnerForm(owner: owner)));
    if (result == 'update') {
      await getOwnerall();
    }
  }
}
