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
    final AsyncValue<void> toUppercase = watch(voidFutureProvider("Hello!!!"));
    return Center(child: toUppercase.when(
        data: (value) => Text("AsyncValue done."),
        loading: () =>  Text("Loading...."),
        error: (error, stackTrace) => Text("Error $error"),
      ));
  }
}
