import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class ChooseLocationPage extends StatefulWidget {
  // final String title;
  // const ChooseLocationPage({Key? key, required this.title}) : super(key: key);
  const ChooseLocationPage({Key? key}) : super(key: key);

  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
GoogleMapController? _controller;
  Location currentLocation = Location();
  Set<Marker> _markers={};
 
 
  void getLocation() async{
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc){
 
      _controller?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0,loc.longitude?? 0.0),
        zoom: 12.0,
      )));
      print(loc.latitude);
      print(loc.longitude);
      setState(() {
        _markers.add(Marker(markerId: MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)
        ));
      });
       });
  }
 
  @override
  void initState(){
    super.initState();
    setState(() {
      getLocation();
    });
  }
 


  List<Marker> myMarker = [
    Marker(
        markerId: MarkerId(LatLng(19.0735, 72.8995).toString()),
        position: LatLng(19.0735, 72.8995),
        draggable: true),
  ];



  _handleTap(LatLng tappedPoint) {
    print("Tapped point: $tappedPoint");

   
    setState(() {
      myMarker = [];
      myMarker.add(
        Marker(
            markerId: MarkerId(tappedPoint.toString()),
            position: tappedPoint,
            draggable: true),
      );
    });
  }



// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Map"),
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child:GoogleMap(
//           zoomControlsEnabled: false,
//           initialCameraPosition:CameraPosition(
//             target: LatLng(48.8561, 2.2930),
//             zoom: 12.0,
//           ),
//           onMapCreated: (GoogleMapController controller){
//             _controller = controller;
//           },
//           markers: _markers,
//         ) ,
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.location_searching,color: Colors.white,),
//         onPressed: (){
//           getLocation();
//         },

        
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(19.0735, 72.8995), zoom: 10),
              markers: Set.from(myMarker),
              onMapCreated: (GoogleMapController controller){
            _controller = controller;
          },
            onTap: _handleTap,
            
              mapType: MapType.hybrid,

              
            ),
          ),
          Container(
            // color: Color(0xffea4335),
            color: Color(0xff34a853),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // print(myMarker[0].position);
                    Navigator.pop(context, myMarker[0].position);
                  },
                  child: Text(
                    "Confirm Location",
                    // style: TextStyle(color: Color(0xfffbbc04), fontSize: 20),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(primary: Color(0xff4285f4)),
                )
              ],
            ),
            
          )
          ,
          
        ],
      ),
    );
  }
}
