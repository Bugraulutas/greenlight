import 'package:flutter/material.dart';
import 'package:flutter_time_range/flutter_time_range.dart';
class Timer extends StatefulWidget {

  const Timer({super.key});

  @override

  // ignore: library_private_types_in_public_api
  _TimerState createState() => _TimerState();

}

class _TimerState extends State<Timer> {
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  final _navigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        navigatorKey: _navigatorKey,
        scaffoldMessengerKey: _messangerKey,
        title: 'Greenlight',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Greenlight"),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    child: Text("-Zamanlayıcı-"),
                    onPressed: () {
                      showTimeRangePicker(
                          _navigatorKey.currentState!.overlay!.context);
                    },
                  ),

                ],
              ),
            )));
  }

  Future<void> showTimeRangePicker(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Zaman aralığı seç"),
            content: TimeRangePicker(
              initialFromHour: DateTime.now().hour,
              initialFromMinutes: DateTime.now().minute,
              initialToHour: DateTime.now().hour,
              initialToMinutes: DateTime.now().minute,
              backText: "geri",
              nextText: "ileri",
              cancelText: "iptal",
              selectText: "seç",
              editable: true,
              is24Format: true,
              disableTabInteraction: true,
              iconCancel: Icon(Icons.cancel_presentation, size: 12),
              iconNext: Icon(Icons.arrow_forward, size: 12),
              iconBack: Icon(Icons.arrow_back, size: 12),
              iconSelect: Icon(Icons.check, size: 12),
              separatorStyle: TextStyle(color: Colors.grey[900], fontSize: 30),
              onSelect: (from, to) {


                _messangerKey.currentState!.showSnackBar(
                    SnackBar(content: Text("From : $from, To : $to")));
                Navigator.pop(context);

              },

              onCancel: () => Navigator.pop(context),


            ),
          );
        });
  }
}
