import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/services.dart' show rootBundle;

Future<dynamic> reportSightingAPI(Map data) async {
  var baseUrl = 'https://d073-2409-40c2-1037-da64-29e6-e64d-6279-ba6d.in.ngrok.io';

  //encode Map to JSON
  var body = json.encode(data);

  var response = await http.post(Uri.parse('$baseUrl/report_sighting'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: body);
  // print("${response.statusCode}");
  return response;
}
