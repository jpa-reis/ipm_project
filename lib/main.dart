import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ipm_project/panel_widget.dart';
import 'white_theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'timeline.dart';


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
  static const double buttonHeightClosed = 75.0;
  double buttonHeight = buttonHeightClosed;

  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.9;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,  // will be removed
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[

            // WIDGET A COPIAR PARA TER ACESSO AO DRAWER
            SlidingUpPanel(
              controller: panelController,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              maxHeight: panelHeightOpen,
              minHeight: panelHeightClosed,
              panelBuilder: (controller) => PanelWidget(
                controller: controller,
                panelController: panelController,
              ),
              onPanelSlide: (position) => setState(() {
                final buttonPosition = panelHeightOpen - panelHeightClosed;
                buttonHeight = position * buttonPosition + buttonHeightClosed;
              }),
            ),
            // ----------------------------------------

            Positioned(
              right: 15,
              bottom: buttonHeight,
              child: markerButton(context),
            ),
            Positioned(
              left: 15,
              bottom: buttonHeight,
              child: FloatingActionButton(onPressed: () {}),
            ),
          ],
        )
      ),
    );
  }

  Widget markerButton(BuildContext context) {
    Color transparencyLvl = Colors.white.withOpacity(0.7);

    return SpeedDial(
      overlayOpacity: 0,
      icon: Icons.location_on,
      backgroundColor: transparencyLvl,
      foregroundColor: const Color(0xFF383838),
      elevation: 0.4,
      buttonSize: const Size(50.0, 50.0),
      spacing: 7,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.search),
          backgroundColor: transparencyLvl,
          foregroundColor: const Color(0xFF383838),
          elevation: 0.4,
          onTap: () {}
        ),
        SpeedDialChild(
          child: const Icon(Icons.add),
          backgroundColor: transparencyLvl,
          foregroundColor: const Color(0xFF383838),
          elevation: 0.4,
          onTap: () {}
        ),
      ],
    );
  }


}
