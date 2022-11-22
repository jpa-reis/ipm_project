import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:ipm_project/panel_widget.dart';
import 'globals.dart' as globals;

class ShowPhoto extends StatefulWidget {
  const ShowPhoto({super.key});

  @override
  State<ShowPhoto> createState() => _ShowPhotoState();
}

class _ShowPhotoState extends State<ShowPhoto> {
  final panelController = PanelController();

  static final mode = globals.mode;

  Widget getTimelinePhoto(BuildContext context) {
    final buttonHeight = MediaQuery.of(context).size.height * 0.5;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 46, 163, 81), // not final
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            const Text("22/06/2022"),
            Positioned(
              left: 15,
              bottom: buttonHeight,
              child: FloatingActionButton(
                  onPressed: () {/* Navegar para a foto anterior */}),
            ),
            Positioned(
              right: 15,
              bottom: buttonHeight,
              child: FloatingActionButton(
                  onPressed: () {/* Navegar para a foto seguinte */}),
            ),
            ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              activeBgColors: const [
                [Colors.black],
                [Colors.black]
              ],
              activeFgColor: Color.fromARGB(255, 255, 255, 255),
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 0,
              totalSwitches: 2,
              labels: ['', ''],
              radiusStyle: true,
              onToggle: (index) {
                // Logic of public/private
                switch (index) {
                  case 0:
                    globals.mode = globals.PhotoModes.private;
                    break;
                  default:
                    globals.mode = globals.PhotoModes.public;
                }
              },
            ), // Toggle entre ser publico ou privado
            const Image(
              alignment: Alignment.center,
              image: NetworkImage(
                  'https://www.thecolvinco.com/pt/c/wp-content/uploads/sites/4/2020/07/ROSE-RED-RED-NAOMI-50-768x768.jpg'), // Foto
            ),
            const Text("Isto é uma linda rosa")
          ],
        ));
  }

  Widget getCommunityPhoto(BuildContext context) {
    final buttonHeight = MediaQuery.of(context).size.height * 0.5;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 173, 137, 17), // not final
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              activeBgColors: const [
                [Colors.black],
                [Colors.black]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 1,
              totalSwitches: 2,
              labels: ['', ''],
              radiusStyle: true,
              onToggle: (index) {
                // Logic of public/private
                switch (index) {
                  case 0:
                    globals.mode = globals.PhotoModes.private;
                    break;
                  default:
                    globals.mode = globals.PhotoModes.public;
                }
              },
            ),
            Positioned(
              left: 15,
              bottom: buttonHeight,
              child: FloatingActionButton(
                  onPressed: () {/* Navegar para a foto anterior */}),
            ),
            Positioned(
              right: 15,
              bottom: buttonHeight,
              child: FloatingActionButton(
                  onPressed: () {/* Navegar para a foto seguinte */}),
            ), // Toggle entre ser publico ou privado
            const Image(
              image: NetworkImage(
                  'https://www.thecolvinco.com/pt/c/wp-content/uploads/sites/4/2020/07/ROSE-RED-RED-NAOMI-50-768x768.jpg'), // Foto
            ),
            const Text("Isto é uma linda rosa"), // Descrição da foto
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case globals.PhotoModes.private:
        return getTimelinePhoto(context);
      case globals.PhotoModes.public:
        return getCommunityPhoto(context);
    }
  }
}
