import 'dart:developer';

import 'package:cardprofile/ApiController.dart';
import 'package:cardprofile/api_model.dart';
import 'package:flutter/material.dart';

class SearchPerson extends StatefulWidget {
  const SearchPerson({super.key});

  @override
  State<SearchPerson> createState() => _SearchPersonState();
}

class _SearchPersonState extends State<SearchPerson> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon:const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context, context);
              }),
          centerTitle: true,
          title: const Text(
            'SearchPerson',
            style:  TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
          ),
        ),
        backgroundColor: Colors.cyan,
        body: Column(children: [
          Expanded(
              child: FutureBuilder<List<Details>>(
            future: getData(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return screens(
                      snapshot.data![index].name.toString(),
                      snapshot.data![index].id.toString(),
                      snapshot.data![index].age.toString(),
                      snapshot.data![1].height.toString(),
                      snapshot.data![index].sex.toString(),
                      snapshot.data![index].missingFrom.toString(),
                      snapshot.data![index].description.toString(),
                      snapshot.data![index].matchesFound.toString(),
                      snapshot.data![index].addressRecord!.city.toString(),
                      snapshot.data![index].addressRecord!.country.toString(),
                      snapshot.data![index].addressRecord!.streetAddress
                          .toString(),
                      snapshot.data![index].addressRecord!.zip.toString(),
                    );
                  });
            },
          ))
        ]));
  }

  Widget screens(
    String name,
    String id,
    String age,
    String height,
    String six,
    String missingfrom,
    String description,
    String matchesfound,
    String city,
    String country,
    String street,
    String zip,
  ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.only(
            top: height * 0.03,
            left: width * 0.03,
            right: width * 0.03,
            bottom: height * 0.03),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 20,
            color: Colors.white,
            child: Container(
              height: height * 0.5,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name : ${name}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                      Text(
                        'ID: ${id}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Age: ${age}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Height: ${height}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Sex: ${six}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Missing_From : ${missingfrom}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'MatchesFound : ${matchesfound}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Deescription : ${description}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'City: ${city}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Country: ${country}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'street_Address: ${street}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Zip: ${zip}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12),
                      ),
                    ]),
              ),
            )));
  }
}
