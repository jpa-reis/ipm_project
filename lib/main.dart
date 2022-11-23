import 'package:flutter/material.dart';
import 'package:ipm_project/panel_widget.dart';
import 'white_theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


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




const double buttonSize = 50.0;

class _HomePageState extends State<HomePage> {
  double buttonPosition = 10.0;
  Color transparencyLvl = Colors.white.withOpacity(0.7);
  static const Color iconColor = Color(0xFF383838);
  static const double elevation = 0.7;
  static const double buttonHeightClosed = buttonSize + 25.0;
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.09;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.9;

    return SafeArea(
      child: Scaffold(
        body: CustomMultiChildLayout(
          delegate: LayoutDelegate(
            position: Offset.zero,
            controller: panelController,
            buttonPosition: buttonPosition,
          ),
          children: <Widget>[
            LayoutId(
                id: LayoutObjects.map,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('lib/help.png'),
                    ),
                  ),
                ),
            ),

            // WIDGET A COPIAR PARA TER ACESSO AO DRAWER
            LayoutId(
              id: LayoutObjects.drawer,
              child: SlidingUpPanel(
                controller: panelController,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15)
                ),
                maxHeight: panelHeightOpen,
                minHeight: panelHeightClosed,
                panelBuilder: (controller) => PanelWidget(
                  controller: controller,
                  panelController: panelController,
                ),
                onPanelSlide: (position) => setState(() {
                  final panelVariation = panelHeightOpen - panelHeightClosed;
                  buttonPosition = position * panelVariation + buttonHeightClosed;
                }),
              ),
            ),
            // -----------------------------------

            LayoutId(
              id: LayoutObjects.marker,
              child: markerButton(context),
            ),

            LayoutId(
              id: LayoutObjects.settings,
              child: generalButton(context, Icons.settings)
            ),

            LayoutId(
              id: LayoutObjects.help,
              child: generalButton(context, Icons.question_mark)
            ),

            LayoutId(
              id: LayoutObjects.profile,
              child: generalButton(context, Icons.person)
            ),
          ]
        )
      ),
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.9;

    return Scaffold( // will be removed
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('lib/help.png'),
              ),
            ),
          ),

          // WIDGET A COPIAR PARA TER ACESSO AO DRAWER
          SlidingUpPanel(
            controller: panelController,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15)
            ),
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
          // -----------------------------------

          Positioned(
            right: 15,
            bottom: buttonHeight,
            child: markerButton(context),
          ),
          Positioned(
            left: 15,
            bottom: buttonHeight,
            child: generalButton(context, Icons.add),
          ),
          

        ],
      )
    );
  }
  */

  Widget generalButton(BuildContext context, IconData icon) {
    return SizedBox(
      height: buttonSize,
      width: buttonSize,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: transparencyLvl,
        foregroundColor: iconColor,
        elevation: elevation,
        child: Icon(icon),
      ),
    );
  }

  Widget markerButton(BuildContext context) {
    return SpeedDial(
      overlayOpacity: 0,
      icon: Icons.location_on,
      backgroundColor: transparencyLvl,
      foregroundColor: iconColor,
      elevation: elevation,
      buttonSize: const Size(buttonSize, buttonSize),
      spacing: 7,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.search),
          backgroundColor: transparencyLvl,
          foregroundColor: iconColor,
          elevation: elevation,
          onTap: () {}
        ),
        SpeedDialChild(
          child: const Icon(Icons.add),
          backgroundColor: transparencyLvl,
          foregroundColor: iconColor,
          elevation: elevation,
          onTap: () {}
        ),
      ],
    );
  }

}

enum LayoutObjects {
  map,
  drawer,
  marker,
  help,
  settings,
  profile
}


class LayoutDelegate extends MultiChildLayoutDelegate {
  final Offset position;
  final PanelController controller;
  final double buttonPosition;

  LayoutDelegate({
    required this.position,
    required this.controller,
    required this.buttonPosition,
  });

  @override
  void performLayout(Size size) {
    const double padding = 15.0;
    const BoxConstraints buttonConstraints = BoxConstraints(
      maxWidth: buttonSize,
      maxHeight: buttonSize
    );

    if (hasChild(LayoutObjects.map)) {
      layoutChild(
        LayoutObjects.map,
        BoxConstraints.loose(size),
      );
    }

    if (hasChild(LayoutObjects.drawer)) {
      layoutChild(
        LayoutObjects.drawer,
        BoxConstraints.loose(size),
      );
    }

    if (hasChild(LayoutObjects.marker)) {
      layoutChild(
        LayoutObjects.marker,
        buttonConstraints
      );
      positionChild(
        LayoutObjects.marker,
        Offset(
          size.width - buttonSize - padding,
          size.height - buttonPosition - buttonSize - padding,
        )
      );
    }

    if (hasChild(LayoutObjects.settings)) {
      layoutChild(
        LayoutObjects.settings,
        buttonConstraints
      );
      positionChild(
        LayoutObjects.settings,
        Offset(
          padding,
          size.height - buttonPosition - buttonSize - padding,
        )
      );
    }

    if (hasChild(LayoutObjects.help)) {
      layoutChild(
        LayoutObjects.help,
        buttonConstraints
      );
      positionChild(
        LayoutObjects.help,
        Offset(
          padding,
          size.height - buttonPosition - buttonSize*2 - padding*2,
        )
      );
    }

    if (hasChild(LayoutObjects.profile)) {
      layoutChild(
          LayoutObjects.profile,
          buttonConstraints
      );
      positionChild(
        LayoutObjects.profile,
        Offset(
          padding,
          controller.isPanelClosed?
            padding :
            padding + buttonSize - buttonPosition,
        )
      );
    }
  }

  @override
  bool shouldRelayout(LayoutDelegate oldDelegate) {
    return oldDelegate.position != position;
  }

}


