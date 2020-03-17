import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ChangeNotifierProvider listen for changes in the model object. when there are changes,
// it will rebuild any widgets under the Consumer, remember to call notifyListeners() to dispatch the changes of the value
// in your own ChangeNotifier class
class ChangeNotifProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotifierModel>(
      create: (context) => NotifierModel(),
      child: MaterialApp(
          home: Scaffold(
        appBar: AppBar(title: Text("ChageNotifierProvider Example")),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.green,
              child: Builder(builder: (context) {
                return RaisedButton(
                    child: Text("Do Something"),
                    onPressed: () {
                      Provider.of<NotifierModel>(context, listen: false).doSomething();
                    });
              }),
            ),
            Container(
                padding: EdgeInsets.all(35),
                color: Colors.blue[200],
                child: Consumer<NotifierModel>(builder: (_, myModel, child) {
                  return Text(myModel.someValue);
                }))
          ],
        ),
      )),
    );
  }
}

class NotifierModel with ChangeNotifier {
  String someValue = "Hello";

  doSomething() {
    someValue = "Goodbye";
    print(someValue);
    notifyListeners();
  }
}
