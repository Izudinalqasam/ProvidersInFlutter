import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// StreamProvider is basically a wrapper around a StreamBuilder;
// you provide a stream and then the Consumers get rebuilt when there is an event in the stream
// StreamProvider doesn't listen for changes in the model itself, it only listen for new event in the streamBuilder
// it is like FutureProvider which doesn't listen fro any changes from provider

class StreamProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<StreamModel>(
      initialData: StreamModel(someValue: 'Default value'),
      create: (context) => getStreamOfModel(),
      child: MaterialApp(
          home: Scaffold(
        appBar: AppBar(
          title: Text("StreamProvider Example"),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(20),
                color: Colors.green[200],
                child: Builder(
                    builder: (context) => RaisedButton(
                        child: Text("Do something"),
                        onPressed: () {
                          Provider.of<StreamModel>(context).doSomething();
                        }))),
            Container(
                padding: const EdgeInsets.all(35),
                color: Colors.blue[200],
                child: Consumer<StreamModel>(
                    builder: (context, myModel, child) =>
                        Text(myModel.someValue)))
          ],
        ),
      )),
    );
  }
}

Stream<StreamModel> getStreamOfModel() {
  return Stream<StreamModel>.periodic(
      Duration(seconds: 1), (x) => StreamModel(someValue: "$x")).take(10);
}

class StreamModel {
  String someValue = 'Hello';

  StreamModel({this.someValue});

  doSomething() {
    someValue = 'Goodbye';
    print(someValue);
  }
}
