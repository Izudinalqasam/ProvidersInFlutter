import 'package:flutter/material.dart';
import 'package:provider_example/changeNotifProvider_example/changeNotifProvider_example.dart';
import 'package:provider_example/future_provider/futureProvider_example.dart';
import 'package:provider_example/multiprovider_example/multipleprovider_example.dart';
import 'package:provider_example/provider_example/provider_example.dart';
import 'package:provider_example/proxyprovider_example/proxyprovider_example.dart';
import 'package:provider_example/stream_provider/streamprovider_example.dart';
import 'package:provider_example/valuelistenableprovider_example/valuelistenableprovider_example.dart';

void main() => runApp(MyApp());

// ChangeNotifProviderExample
/// the basic constructor takes a "create "function to create your module objec
/// Provider<MyModel>(
//   create: (context) => MyModel(),
//   child: ...
// )

/// if your object has already been created and you just want to provide a reference to it
/// then you can use the name constructor called "value"
/// final myModel = MyModel();
// ...
// Provider<MyModel>.value(
//     value: myModel, 
//     child: ...
// )

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProxyProviderExample(),
    );
  }
}
