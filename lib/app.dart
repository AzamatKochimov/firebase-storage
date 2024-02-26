import 'package:flutter/material.dart';
// import 'package:real_time_firebase/pages/upload_image.dart';

import 'pages/upload_files.dart';

// import 'pages/real_time_databse.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      // home: const RealTimeCRUDEdatabase(),
      // home: const UploadImageAndMoreState(),
      home: const UploadFiles(),

    );
  }
}