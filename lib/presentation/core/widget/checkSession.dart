import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class CheckSessions extends StatelessWidget {
  const CheckSessions({super.key});

  bool checkTime(DateTime future) {
    // Mendapatkan waktu saat ini
    DateTime now = DateTime.now();

    // Membandingkan waktu saat ini dengan waktu di masa depan
    return now.isAfter(future);
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('userdata');
    DateTime? futureTime;
    if(box.get('session_timeout', defaultValue: null) != null){
      futureTime = DateTime.parse(box.get('session_timeout'));
      print(futureTime);
    }else{
      futureTime = DateTime.parse("3000-01-01");
      print("Gagal");
    }

    if(box.get('token', defaultValue: null) == null || checkTime(futureTime)){
      context.go('/login');
    }
    return Scaffold();
  }
}
