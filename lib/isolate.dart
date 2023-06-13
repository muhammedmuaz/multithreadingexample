import 'dart:isolate';

import 'package:flutter/material.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Colors.green,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
               useIsoalte();

                // int s = heavTaskWithOutIsolate(1000000000);
                // print(s);
              },
              child: const Text('Start Task'),
            )
          ],
        ),
      ),
    );
  }
}

useIsoalte()async{
     final  receivePort = ReceivePort();
     await Isolate.spawn(heavTaskWithIsolate, receivePort.sendPort);
     receivePort.listen((sum) {
    print(sum);
   });

}

/// Function With Isolate
void heavTaskWithIsolate(SendPort sendPort) {
  print('Task Started with isolate');
  int sum = 0;
  for (var i = 0; i < 1000000000; i++) {
    sum += i;
  }
  print('Task Finished with isolate');
  sendPort.send('Total $sum');
}

/// Function With-Out Isolate
int heavTaskWithOutIsolate(int count) {
  print('Task Started');
  int sum = 0;
  for (var i = 0; i < count; i++) {
    sum += i;
  }
  print('Task Finished');
  return sum;
}
