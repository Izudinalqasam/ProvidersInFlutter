import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// you can use ProxyProvider when you one of the models depends on the other one,
// it takes the value from one provider and lets it be injected into another provider
// The first type is what the second type depends on.
class ProxyProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirstProxyModel>(
            create: (context) => FirstProxyModel()),
        ProxyProvider<FirstProxyModel, SecondProxyModel>(
            update: (context, myModel, anotherModel) =>
                SecondProxyModel(myModel))
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("ProxyProviderExample"),
          ),
          body: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.green[200],
                    child: Builder(
                        builder: (context) => RaisedButton(
                            child: Text("Do Something"),
                            onPressed: () {
                              Provider.of<FirstProxyModel>(context,
                                      listen: false)
                                  .doSomething('Goodbye');
                            })),
                  ),
                  Container(
                      padding: const EdgeInsets.all(35),
                      color: Colors.blue[200],
                      child: Consumer<FirstProxyModel>(
                        builder: (_, myModel, __) {
                          return Text(myModel.someValue);
                        },
                      ))
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.red[200],
                child: Builder(builder: (context) {
                  return RaisedButton(
                    child: Text("Do something else"),
                    onPressed: () {
                      Provider.of<SecondProxyModel>(context, listen: false)
                          .doSomethingElse();
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FirstProxyModel with ChangeNotifier {
  String someValue = 'Hello';

  doSomething(String value) {
    someValue = value;
    print(someValue);
    notifyListeners();
  }
}

class SecondProxyModel {
  FirstProxyModel _myModel;

  SecondProxyModel(this._myModel);

  doSomethingElse() {
    _myModel.doSomething('See you later');
    print('doing something else');
  }
}
