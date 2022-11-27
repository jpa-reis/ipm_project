import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ipm_project/addImage.dart';
import 'package:ipm_project/globals.dart';
import 'package:ipm_project/panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'timeline.dart';
import 'marker.dart';
import 'imageData.dart';
// TODO as contas para ver onde colocar o marker estão mal

void main() {
  runApp(const App());
}

const double buttonSize = 50.0;
final panelController = PanelController();


class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Time Garden',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white
          )
        ),
        home: const HomePage(title: 'Time Garden'));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  static const Color iconColor = Color(0xFF383838);
  static const double elevation = 0;
  static const double initButtonPosition = buttonSize + 30.0;
  static const Duration fadeTime = Duration(milliseconds: 200);

  TextEditingController editingController = TextEditingController();
  Color transparencyLvl = Colors.white.withOpacity(0.8);
  double padding = 15.0;
  Completer<void>? nextButtonCompleter;

  late Offset _globalPosition;
  late Offset _tapPosition;
  late double _zoomLvl;
  late double buttonPosition;
  late bool panelClosed;
  late bool openMapSearch;


  Future<void> addMarker() async {
    final completer = Completer<void>();
    nextButtonCompleter = completer;
    // This line will wait until onPressed called
    await completer.future;

    final mPosition = (_tapPosition + _globalPosition)/_zoomLvl;
    markers.add(Marker(position: mPosition, name: ""));
    images.add(<ImageData>[]);
  }

  @override
  void initState() {
    super.initState();
    _globalPosition = const Offset(0.0, 0.0);
    _tapPosition = const Offset(0.0, 0.0);
    _zoomLvl = 1.0;
    buttonPosition = initButtonPosition;
    panelClosed = true;
    openMapSearch = false;
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.9;
    padding = MediaQuery.of(context).size.height * 0.02;
    buttonPosition = panelHeightClosed + padding;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            GestureDetector(
              onTapDown: (details) {
                setState(() {
                  _tapPosition = details.globalPosition;
                  openMapSearch = false;
                });
                nextButtonCompleter?.complete();
                nextButtonCompleter = null;
              },
              child: Zoom(
                onPositionUpdate: (Offset position) => setState(() {
                  _globalPosition = position;
                }),
                onScaleUpdate: (double scale, double zoom) => setState(() {
                  _zoomLvl = zoom;
                }),

                child: Container(
                  width: 4000,
                  height: 2500,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('lib/jardim.png')
                      )
                  ),
                  child: CustomMultiChildLayout(
                    delegate: MapLayout(),
                    children: <Widget>[
                      for (var marker in markers)
                        LayoutId(
                            id: markers.indexOf(marker),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddImageScreen(marker: marker)
                                ));
                              },
                              icon: const Icon(Icons.location_on),
                            )
                        )
                    ],
                  ),
                ),
              ),
            ),



            // WIDGET A COPIAR PARA TER ACESSO AO DRAWER
            SlidingUpPanel(
              controller: panelController,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15)),
              maxHeight: panelHeightOpen,
              minHeight: panelHeightClosed,
              panelBuilder: (controller) => PanelWidget(
                controller: controller,
                panelController: panelController,
              ),
              onPanelSlide: (position) => setState(() {
                buttonPosition =
                    position * (panelHeightOpen - panelHeightClosed) +
                    initButtonPosition;
                panelClosed = ((buttonPosition - initButtonPosition) == 0);
                openMapSearch = false;
              }),
            ),

            Positioned(
              child: AnimatedOpacity(
                opacity: openMapSearch ? 1 : 0,
                duration: fadeTime,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: editingController,
                    decoration: const InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(
                        Icons.search,
                        color: iconColor,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(25.0)
                          )
                      )
                    ),
                  ),
                ),
              ),
            ),
            // -----------------------------------

            Positioned(
              right: padding,
              bottom: buttonPosition,
              child: AnimatedOpacity(
                duration: fadeTime,
                opacity: panelClosed ? 1 : 0,
                child: markerButton(context),
              ),
            ),
            Positioned(
              left: padding,
              bottom: buttonPosition,
              child: AnimatedOpacity(
                  duration: fadeTime,
                  opacity: panelClosed ? 1 : 0,
                  child: generalButton(context, Icons.settings)
              ),
            ),
            Positioned(
              left: padding,
              bottom: buttonPosition + buttonSize + padding,
              child: AnimatedOpacity(
                  duration: fadeTime,
                  opacity: panelClosed ? 1 : 0,
                  child: generalButton(context, Icons.question_mark)
              ),
            ),
            Positioned(
              left: padding,
              top: padding,
              child: AnimatedOpacity(
                  duration: fadeTime,
                  opacity: (panelClosed && !openMapSearch) ? 1 : 0,
                  child: generalButton(context, Icons.person)
              ),
            ),
          ],

        ),
      ),
    );
  }

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
          onTap: () => setState(() {
            openMapSearch = true;
          }),
        ),
        SpeedDialChild(
          child: const Icon(Icons.add),
          backgroundColor: transparencyLvl,
          foregroundColor: iconColor,
          elevation: elevation,
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Add a new marker"),
              content: const Text("Click on the map in the position where"
                  " you would like to place a new marker."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    addMarker();
                  },
                  style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Color(0xFF484848))
                  ),
                  child: const Text('OK')
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel')
                )
              ],
            )
          )
        ),
      ],
    );
  }

}

class MapLayout extends MultiChildLayoutDelegate {
  final constraints = const BoxConstraints(
      maxHeight: 50.0,
      maxWidth: 50.0
  );

  @override
  void performLayout(Size size) {
    for (final marker in markers) {
      layoutChild(markers.indexOf(marker), constraints);
      positionChild(markers.indexOf(marker), marker.getPosition());
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }

}
