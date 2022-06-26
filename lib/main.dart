// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Book Selling',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Chương trình bán sách online'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController guestNameController  = TextEditingController();
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            color: Colors.green,
            child: const Text('Thông tin hoá đơn',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              textDirection: TextDirection.rtl,
              verticalDirection: VerticalDirection.down,
              children: [
                Expanded(
                  flex: 1,
                  child: Text('Tên khách hàng:'),
                ),
                Expanded(
                  flex: 1,
                  child: inputWidget(
                  labelText: 'Điểm Toán',
                  controller: guestNameController,
                  hintText: 'Nhập điểm Toán'),
                ),
              ]),
        ],
      ),
      
    );
  }
}


