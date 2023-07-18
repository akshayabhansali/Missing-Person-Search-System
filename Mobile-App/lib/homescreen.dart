// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cardprofile/ApiController.dart';
import 'package:cardprofile/api_model.dart';
import 'package:cardprofile/load_missing_people.dart';
import 'package:cardprofile/search_missing_person.dart';
import 'package:flutter/material.dart';
import 'package:cardprofile/screens/scan_photo.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    //getData();
    //Get.put(Mycontroller());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: FutureBuilder<List<Details>>(
                future: getData(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: height,
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: height * 0.25,
                              width: width * 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.circular(120)),
                              child: Center(
                                child: Text(
                                  'Welcome',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                            ),
                            // Image(
                            //     image: NetworkImage(
                            //         'https://d073-2409-40c2-1037-da64-29e6-e64d-6279-ba6d.in.ngrok.io/getimage?id=${snapshot.data![index].id}')),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (contex) =>
                                                LoadMissingPeople()));
                                  },
                                  // ignore: prefer_const_constructors
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text(
                                        'Load Missing People',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      backgroundColor: Colors.cyan,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScanPhotoPage()));
                                  },
                                  // ignore: prefer_const_constructors
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text(
                                        'Search Missing Person',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      backgroundColor: Colors.cyan,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                })),
      ]),
    );
  }
}
