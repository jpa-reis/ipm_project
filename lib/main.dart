import 'package:flutter/material.dart';
import 'package:ipm_project/panel_widget.dart';
import 'white_theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


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

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.12;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.9;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            controller: panelController,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            maxHeight: panelHeightOpen,
            minHeight: panelHeightClosed,
            panelBuilder: (scrollcontroller) => PanelWidget(
              scrollController: scrollcontroller,
              panelController: panelController,
            ),
          ),
        ],
      )
    );
  }

}
