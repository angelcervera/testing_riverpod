import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final voidFutureProvider = FutureProvider.autoDispose.family<void, String>((ref, str) {
  return Future.delayed(Duration(seconds: 5), () { print(str); });
});

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: MyHomeFuture(),
      home: Scaffold(
        body: MyHomeAsyncValue(),
      ),
    );
  }
}

class MyHomeAsyncValue extends ConsumerWidget {
  MyHomeAsyncValue({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final AsyncValue<void> fromBuild = watch(voidFutureProvider("From the on Build"));
    fromBuild.when(
      data: (value) => print("Done from build!!!"),
      loading: () => print("Loading...."),
      error: (error, stackTrace) => print("Error $error"),
    );

    return Center(child: ElevatedButton(
      child: Text('Call'),
      onPressed: () {
        final AsyncValue<void> fromButton = watch(voidFutureProvider("From the on Press"));
        fromButton.when(
            data: (value) => print("Done from the button!!!"),
            loading: () => print("Loading...."),
            error: (error, stackTrace) => print("Error $error"),
        );
      },
    ),);

  }
}
