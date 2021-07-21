import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: Scaffold(body: Center(child: MyHomeAsyncValue()),))));
}

final voidFutureProvider = FutureProvider.autoDispose.family<void, String>((ref, str) {
  return Future.delayed(Duration(seconds: 5), () { print(str); return str; });
});

class MyHomeAsyncValue extends StatelessWidget {
  const MyHomeAsyncValue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) => ElevatedButton(
        child: Text('Call'),
        onPressed: () {
          final value = context.read(voidFutureProvider("From the onPress").future);
          value
              .then((value) =>  print("Done from the button!!!"))
              .onError((error, stackTrace) => print("Error $error"));
        },
      ),
    );
  }
}
