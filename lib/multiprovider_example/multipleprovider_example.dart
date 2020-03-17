import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// use this if you want to get model from multiple providers

class MultiProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirstMultiProvider>(
            create: (context) => FirstMultiProvider()),
        ChangeNotifierProvider<SecondMultiProvider>(
            create: (context) => SecondMultiProvider()),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("MultiProvider Example"),
          ),
          body: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.green[200],
                    child: Builder(builder: (context) {
                      return RaisedButton(
                          child: Text("Do something"),
                          onPressed: () {
                            Provider.of<FirstMultiProvider>(context,
                                    listen: false)
                                .dosomething();
                          });
                    }),
                  ),
                  Container(
                    padding: const EdgeInsets.all(35),
                    color: Colors.blue[200],
                    child:
                        Consumer<FirstMultiProvider>(builder: (_, myModel, __) {
                      return Text(myModel.someValue1);
                    }),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.red[200],
                    child: Builder(
                        builder: (context) => RaisedButton(
                            child: Text("Do something"),
                            onPressed: () {
                              Provider.of<SecondMultiProvider>(context,
                                      listen: false)
                                  .doSomething();
                            })),
                  ),
                  Container(
                      padding: const EdgeInsets.all(35),
                      color: Colors.yellow[200],
                      child: Consumer<SecondMultiProvider>(
                        builder: (_, myModel, __) {
                          return Text('${myModel.someValue2}');
                        },
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FirstMultiProvider with ChangeNotifier {
  String someValue1 = 'Hello';

  dosomething() {
    someValue1 = 'Goodbye';
    print(someValue1);
    notifyListeners();
  }
}

class SecondMultiProvider with ChangeNotifier {
  int someValue2 = 0;

  doSomething() {
    someValue2 = 5;
    print(someValue2);
    notifyListeners();
  }
}
