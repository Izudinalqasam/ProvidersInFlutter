// the provider will not help update the widget tree when that value changes/\
// you can use it to provide a value

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProviderExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider<MyModel>(
      create: (context) => MyModel(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('My App'),),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.green[200],
                child: RaisedButton(
                  child: Text('Do something'),
                  onPressed: () {
                  Provider.of<MyModel>(context, listen: false).doSomething();
                }),
              ),
              Container(
                padding: const EdgeInsets.all(35),
                color: Colors.blue[200],
                child: Consumer<MyModel>(
                  builder: (_, myModel, __) {
                    return Text(myModel.someValue);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyModel {
  String someValue = "Hello";

  doSomething(){
    someValue = "Goodbye";
    print(someValue);
  }
}