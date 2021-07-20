import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: Scaffold(body: Center(child: MyHomeAsyncValue()),))));
}

final voidFutureProvider = FutureProvider.autoDispose.family<String, String>((ref, str) {
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
          watch(voidFutureProvider("From the onPress")).when(
            data: (value) => print("Done from the button!!!"),
            loading: () => print("Loading...."),
            error: (error, stackTrace) => print("Error $error"),
          );
        },
      ),
    );
  }
}
