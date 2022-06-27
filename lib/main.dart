// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unnecessary_this

import 'dart:io';
import 'package:book_revenue/resources/widgets/inputWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  TextEditingController guestNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool isVIP = false;
  double totalBill = 0;
  double discount = 0;

  int? totalGuest;
  int? totalVipGuest;
  double? revenue;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.totalGuest = prefs.getInt('totalGuest') ?? 0;
    this.totalVipGuest = prefs.getInt('totalVipGuest') ?? 0;
    this.revenue = prefs.getDouble('revenue') ?? 0;
  }

  void exitApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalGuest', this.totalGuest ?? 0);
    await prefs.setInt('totalVipGuest', this.totalVipGuest ?? 0);
    await prefs.setDouble('revenue', this.revenue ?? 0);

    exit(0);
  }

  void updateData() async {}

  void calculateTotal() async {
    this.discount = this.isVIP == true ? 0.1 : 0;
    int amount = int.tryParse(amountController.text) ?? 0;
    setState(() {
      if (amount > 0) {
        this.totalBill = 20000 * amount * (1 - this.discount);
        this.totalGuest = this.totalGuest ?? 0 + 1;
        this.revenue = this.revenue ?? 0 + this.totalBill;
      }
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalGuest', this.totalGuest ?? 0);
    await prefs.setInt('totalVipGuest', this.totalVipGuest ?? 0);
    await prefs.setDouble('revenue', this.revenue ?? 0);
  }

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
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            color: Colors.green,
            child: const Text('Thông tin hoá đơn',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text('Tên khách hàng:'),
                    )),
                Expanded(
                  flex: 2,
                  child: inputTextWidget(
                      controller: guestNameController, hintText: 'Nhập tên khách hàng'),
                ),
              ]),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text('Số lượng sách:'),
                    )),
                Expanded(
                  flex: 2,
                  child: inputNumberWidget(
                      controller: amountController, hintText: 'Nhập số lượng sách'),
                ),
              ]),
          SizedBox(height: 16),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                    )),
                Expanded(
                  flex: 2,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: this.isVIP,
                          activeColor: Colors.orange,
                          onChanged: (bool? value) {
                            setState(() {
                              this.isVIP = value!;
                              if (this.isVIP) {
                                this.totalVipGuest = this.totalVipGuest ?? 0 + 1;
                              }
                            });
                          },
                        ),
                        SizedBox(width: 4),
                        Text('Khách hàng VIP')
                      ]),
                ),
              ]),
          SizedBox(height: 16),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text('Thành tiền:'),
                    )),
                Expanded(
                  flex: 2,
                  child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: 16),
                      alignment: Alignment.center,
                      color: Color.fromARGB(255, 203, 206, 223),
                      child: Text(this.totalBill.toString())),
                ),
              ]),
          SizedBox(height: 16),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: calculateTotal,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.deepOrange.shade900)),
                      child: const Text('Tính TT')),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      guestNameController.clear();
                      amountController.clear();
                      setState(() {
                        this.totalBill = 0;
                        this.isVIP = false;
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.deepOrange.shade900)),
                    child: const Text('Tiếp'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Thống kê'),
                        content: Text('Tổng doanh thu là ${this.revenue.toString()}'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.deepOrange.shade900)),
                    child: const Text('Thống kê'),
                  ),
                ),
                SizedBox(width: 16),
              ]),
          SizedBox(height: 16),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            color: Colors.green,
            child: const Text('Thông tin thống kê',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 16),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text('Tổng số khách:'),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(this.totalGuest.toString()),
                    )),
              ]),
          SizedBox(height: 16),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text('Tổng số khách VIP:'),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(this.totalVipGuest.toString()),
                    )),
              ]),
          SizedBox(height: 16),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text('Tổng doanh thu:'),
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(this.revenue.toString()),
                    )),
              ]),
          SizedBox(height: 16),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            color: Colors.green,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Image.asset('assets/img/logout.png', width: 20),
                iconSize: 40,
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Thông báo'),
                    content: const Text('Bạn có chắc chắn muốn thoát app?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Huỷ bỏ'),
                        child: const Text('Huỷ bỏ'),
                      ),
                      TextButton(
                        onPressed: exitApp,
                        child: const Text('Xác nhận'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
