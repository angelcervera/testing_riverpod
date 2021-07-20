import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final toUppercaseFutureProvider = FutureProvider.autoDispose.family<String, String>((ref, str) {
  return Future.delayed(Duration(seconds: 5), () => str.toUpperCase());
});

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: MyHomeFuture(),
      home: Scaffold(
        body: Column(children: [MyHomeAsyncValue(), MyHomeFuture()],),
      ),
    );
  }
}

class MyHomeAsyncValue extends ConsumerWidget {
  MyHomeAsyncValue({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final AsyncValue<String> toUppercase = watch(toUppercaseFutureProvider("Hello!!!"));
    return Center(child: toUppercase.when(
        data: (value) => Text("Output is for AsyncValue is [$value]"),
        loading: () =>  Text("Loading...."),
        error: (error, stackTrace) => Text("Error $error"),
      ));
  }
}

class MyHomeFuture extends ConsumerWidget {
  MyHomeFuture({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Future<String> toUppercase = watch(toUppercaseFutureProvider("Hello!!!").future);
    return Center(
          child: FutureBuilder(
            future: toUppercase,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("Output for Future is [${snapshot.data}]");
              }
              if (snapshot.hasError) {
                Text("Error ${snapshot.error}");
              }
              return Text("Loading....");
            },
          )
    );
  }
}
