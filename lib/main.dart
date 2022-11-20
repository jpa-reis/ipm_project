import 'package:flutter/material.dart';
import 'white_theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'garden_drawer.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Garden',
      theme: ThemeData(
        primarySwatch: myWhite,
      ),
      home: const HomePage(title: 'Time Garden')
    );
  }
}


// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that
// affect how it looks.

// This class is the configuration for the state. It holds the values (in
// this case the title) provided by the parent (in this case the App widget)
// and used by the build method of the State. Fields in a Widget subclass are
// always marked "final".
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not
      // be called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
            onPressed: () => {
              showBarModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Colors.white,
                builder: (context) => const GardenDrawer()
              ),
            },
            child: const Text('SHOW GARDENS!'),
          ),
      ),
    );
  }

}



/** Scaffold
 * return Scaffold(
    appBar: AppBar(
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
    title: Text(widget.title),
    ),
    body: Center(
    // Center is a layout widget. It takes a single child and positions it
    // in the middle of the parent.
    child: Column(
    // Column is also a layout widget. It takes a list of children and
    // arranges them vertically. By default, it sizes itself to fit its
    // children horizontally, and tries to be as tall as its parent.
    //
    // Invoke "debug painting" (press "p" in the console, choose the
    // "Toggle Debug Paint" action from the Flutter Inspector in Android
    // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
    // to see the wireframe for each widget.
    //
    // Column has various properties to control how it sizes itself and
    // how it positions its children. Here we use mainAxisAlignment to
    // center the children vertically; the main axis here is the vertical
    // axis because Columns are vertical (the cross axis would be
    // horizontal).
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    const Text(
    'You have pushed the button this many times:',
    ),
    Text(
    '$_counter',
    style: Theme.of(context).textTheme.headline4,
    ),
    ],
    ),
    ),
    floatingActionButton: FloatingActionButton(
    onPressed: _incrementCounter,
    tooltip: 'Increment',
    child: const Icon(Icons.add),
    ), // This trailing comma makes auto-formatting nicer for build methods.
    );
 */
