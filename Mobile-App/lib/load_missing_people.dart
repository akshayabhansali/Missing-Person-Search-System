import 'package:cardprofile/ApiController.dart';
import 'package:cardprofile/api_model.dart';
import 'package:flutter/material.dart';

class LoadMissingPeople extends StatefulWidget {
  const LoadMissingPeople({super.key});

  @override
  State<LoadMissingPeople> createState() => _LoadMissingPeopleState();
}

class _LoadMissingPeopleState extends State<LoadMissingPeople> {
  final pageController = PageController(viewportFraction: 0.99, keepPage: true);
  var index = 0;
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context,) {
    return Scaffold(
        backgroundColor: Colors.cyan,
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
            'Load Missing People',  
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
          ),
        ),
        body: Column(children: [
          Expanded(
              child: FutureBuilder<List<Details>>(
                  future: getData(),
                  builder: (context, snapshot) {
                    return 
                    PageView.builder(
                      physics: new AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      allowImplicitScrolling: true,
                      itemCount: userList.length,
                      controller: pageController,
                      onPageChanged: (value) {
                        setState(() {
                          index= value +1;

                        });
                        print("index"+index.toString());
                      },
                      itemBuilder: (context, index){
                        print(
                            " Details ${snapshot.data![index].addressRecord!.city.toString()}");
                        return screens(
                          snapshot.data![index].name.toString(),
                          snapshot.data![index].id.toString(),
                          snapshot.data![index].age.toString(),
                          snapshot.data![index].height.toString(),
                          snapshot.data![index].sex.toString(),
                          snapshot.data![index].missingFrom.toString(),
                          snapshot.data![index].addressRecord!.streetAddress
                              .toString(),
                          snapshot.data![index].addressRecord!.city.toString(),
                          snapshot.data![index].addressRecord!.country
                              .toString(),
                          snapshot.data![index].addressRecord!.zip.toString(),
                          'https://d073-2409-40c2-1037-da64-29e6-e64d-6279-ba6d.in.ngrok.io/getimage?id=${snapshot.data![index].id}',
                        );
                      },
                    );
                  }))
        ]));
  }

  Widget screens(
      String name,
      String id,
      String age,
      String height,
      String six,
      String missingfrom,
      String addressRecord,
      String city,
      country,
      String zip,
      String image) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          top: height * 0.03,
          left: width * 0.1,
          right: width * 0.1,
          bottom: height * 0.1),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 20,
        color: Colors.black,
        child: Column(
          children: [
            Container(
              height: height * 0.1,
              width: width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Center(
                child: Text(
                  '${name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.only(
                  left: width * 0.05,
                  right: width * .02,
                  top: height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('${image}'),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text(
                      'ID: ${id}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Age: ${age}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Height: ${height}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Sex: ${six}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Missing_From: ${missingfrom}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    const Text(
                      'Address_record: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                    Text(
                      'city ${city}   ${country}    ${addressRecord}  ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Zip: ${zip}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
