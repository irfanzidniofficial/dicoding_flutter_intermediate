import 'package:flutter/material.dart';
import 'package:media_upload/data/api/api_service.dart';
import 'package:media_upload/provider/upload_provider.dart';
import 'package:provider/provider.dart';
import 'provider/home_provider.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UploadProvider(
            ApiService(),
          ),
        ),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}
