import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// it is basically just a wrapper aroung the FutureBuilder
// you give it some initial data to show in the UI and also provide it a future of the value that you want to provide.
// it listens for when the furute completes and then notifies then consumers to rebuild their widgets
// remeber FutureProvider doesn't listen for any changes within the model itself.
// My opinion FutureBuilder is better than FutureProvider

class FutureProvideExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      initialData: FutureModel(someValue: 'Default value'),
      create: (context) => someAsyncFunctionToGetMyModel(),
      child: MaterialApp(
          home: Scaffold(
        appBar: AppBar(
          title: Text("FutureProvider Example"),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.green[200],
              child: Builder(
                  builder: (context) => RaisedButton(
                    child: Text("Do Something"),
                    onPressed: () {
                        Provider.of<FutureModel>(context).doSomething();
                      })),
            ),
            Container(
              padding: const EdgeInsets.all(35),
              color: Colors.blue[200],
              child: Consumer<FutureModel>(
                builder: (context, myModule, child) {
                  return Text(myModule.someValue);
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}

Future<FutureModel> someAsyncFunctionToGetMyModel() async {
  await Future.delayed(Duration(seconds: 3));
  return FutureModel(someValue: 'new data');
}

class FutureModel {
  String someValue = 'Hello';

  FutureModel({this.someValue});

  Future<void> doSomething() async {
    await Future.delayed(Duration(seconds: 2));
    someValue = 'Goodbye';
    print(someValue);
  }
}
