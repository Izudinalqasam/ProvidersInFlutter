import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// it is like ChangeNotifierProvider but more complicated
// you can listen to any changes in ValueListenableProvider three
// to call method on the model from the UI then you need to provide the model (you can use provider to provide it)
// It would probably be better to use Provider.of<MyModel>(context, listen: false) rather than a Consumer at the top of the widget tree
// 

class ValueListenableProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<ValueListenableModel>(
      create: (context) => ValueListenableModel(),
      child: Consumer<ValueListenableModel>(
        builder: (_, myModel, __) {
          return ValueListenableProvider<String>.value(
              value: myModel.someValue,
              child: MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    title: Text("ValueListenableProvider"),
                  ),
                  body: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.green[200],
                        child: Builder(
                            builder: (context) => RaisedButton(
                                child: Text("Do Something"),
                                onPressed: () {
                                      myModel.doSomething();
                                })),
                      ),

                      Container(
                        padding: const EdgeInsets.all(35),
                        color: Colors.blue[200],
                        child: Consumer<String>(
                          builder: (_, myValue, child) {
                            return Text(myValue);
                          }),
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}

class ValueListenableModel {
  ValueNotifier<String> someValue = ValueNotifier('Hello');

  doSomething() {
    someValue.value = 'Goodbye';
  }
}
