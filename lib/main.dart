import 'package:flutter/material.dart';
import 'package:kriptan/app.dart';
import 'package:kriptan/common/network/dio_client.dart';

void main() {
  runApp(App(dio: DioClient.create()));
}
