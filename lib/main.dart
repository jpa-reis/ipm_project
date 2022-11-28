import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ipm_project/addImage.dart';
import 'package:ipm_project/globals.dart';
import 'package:ipm_project/panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'marker.dart';
import 'imageData.dart';
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
          fontFamily: 'SanFrancisco',
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white
          ),
          snackBarTheme: SnackBarThemeData(
            actionTextColor: Colors.white
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.grey[800])
            )
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

  // -------------------------------------------------------- BUTTONS
  static const Color iconColor = Color(0xFF006525);
  static const double elevation = 0;
  static const double buttonSize = 50.0;
  static const double markerSize = 50.0;
  Color transparencyLvl = Color(0xff51983c).withOpacity(0.7);
  // -------------------------------------------------------

  static const double initButtonPosition = buttonSize + 30.0;
  static const Duration fadeTime = Duration(milliseconds: 200);
  final newMarkerController = TextEditingController();
  final searchMarkerController = TextEditingController();
  FocusNode focusNode = FocusNode();
  double padding = 15.0;
  Completer<void>? nextButtonCompleter;

  final panelController = PanelController();
  final transformationController = TransformationController();
  late Offset _tapPosition;
  late double buttonPosition;
  late bool panelClosed;
  late bool openMapSearch;

  Future<void> addMarker(String markerName) async {
    final completer = Completer<void>();
    nextButtonCompleter = completer;
    // This line will wait until onPressed called
    await completer.future;

    final mPosition = _tapPosition;
    var newMarker = Marker(
        position: mPosition,
        name: markerName,
        id: (currentGarden == 1) ? markers1.length : markers2.length,
        description: ""
    );

    if (currentGarden == 1) {
      markers1.add(newMarker);
    }
    else {
      markers2.add(newMarker);
    }
    (currentGarden == 1) ? images1.add(<ImageData>[]) : images2.add(<ImageData>[]);
  }

  late List<Marker> currentMarkers;
  void searchMarker(String query) {
    final markerList = (currentGarden == 1) ? markers1 : markers2;
    final suggestions = markerList.where((marker) {
      final markerName = marker.name.toLowerCase();
      final searchQuery = query.toLowerCase();

      return markerName.contains(searchQuery);
    }).toList();

    setState(() => currentMarkers = suggestions);
  }

  @override
  void initState() {
    transformationController.value = Matrix4.identity();
    transformationController.value.translate(-800.0, -600.0);

    currentMarkers = markers1;
    _tapPosition = const Offset(0.0, 0.0);
    buttonPosition = initButtonPosition;
    panelClosed = true;
    openMapSearch = false;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.9;
    padding = MediaQuery.of(context).size.height * 0.02;
    buttonPosition = panelHeightClosed + padding;

    currentMarkers = (currentGarden == 1) ? markers1 : markers2;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            GestureDetector(
              onTapUp: (details) {
                FocusManager.instance.primaryFocus?.unfocus();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                final offset = transformationController.toScene(
                    details.globalPosition);
                setState(() {
                  _tapPosition = Offset(offset.dx-35.0, offset.dy-65.0);
                  print("AAAAA $_tapPosition");
                  openMapSearch = false;
                  nextButtonCompleter?.complete();
                  nextButtonCompleter = null;
                });
              },
              child: InteractiveViewer(
                transformationController: transformationController,
                onInteractionStart: (details) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                constrained: false,
                minScale: 0.5,
                maxScale: 1.1,
                child: Container(
                  width: (currentGarden == 1) ? 4000 : 5200,
                  height: (currentGarden == 1) ? 2500 : 4300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: (currentGarden == 1)
                          ? AssetImage('lib/jardim.png')
                          : AssetImage('lib/estufa.png')
                    )
                  ),
                  child: CustomMultiChildLayout(
                    delegate: MapLayout(markerList: currentMarkers),
                    children: <Widget> [
                      for (var marker in currentMarkers)
                        LayoutId(
                          id: marker.id,
                          child: TextButton(
                            onPressed: () {
                              if(currentGarden == 1){
                                if(images1[markers1.indexOf(marker)].isEmpty){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          AddImageScreen(marker: marker, currentGarden: currentGarden,)
                                  ));
                                }
                                else{
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          Timeline(indexOf: markers1.indexOf(marker), currentGarden: currentGarden, marker: marker,)
                                  ));
                                }
                              }
                              else{
                                if(images2[markers2.indexOf(marker)].isEmpty){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          AddImageScreen(marker: marker, currentGarden: currentGarden,)
                                  ));
                                }
                                else{
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          Timeline(indexOf: markers2.indexOf(marker), currentGarden: currentGarden, marker: marker,)
                                  ));
                                }
                              }



                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: markerSize,
                                  color: Color(0xFF8D021F),
                                ),
                                Text(
                                  marker.name,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: markerSize/2.3
                                  ),
                                )
                              ],
                            ),
                          )
                        )
                    ]
                  ),
                ),
              ),
            ),


            // --------------------- WIDGET DE DRAWER : copiar este widget
            SlidingUpPanel(
              color: Color(0xFF75A889),
              boxShadow: [],
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

            // --------------------- WIDGET DE PESQUISA
            Positioned(
              child: AnimatedOpacity(
                opacity: openMapSearch ? 1 : 0,
                duration: fadeTime,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    focusNode: focusNode,
                    controller: searchMarkerController,
                    decoration: InputDecoration(
                      hintText: "Search marker",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: iconColor,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(25.0))
                      )
                    ),
                    onChanged: searchMarker,
                  ),
                ),
              ),
            ),

            // --------------------- BOTAO DO MARKER
            Positioned(
              right: padding,
              bottom: buttonPosition,
              child: AnimatedOpacity(
                duration: fadeTime,
                opacity: panelClosed ? 1 : 0,
                child: markerButton(context),
              ),
            ),

            // --------------------- BOTAO DE SETTINGS
            Positioned(
              left: padding,
              bottom: buttonPosition,
              child: AnimatedOpacity(
                  duration: fadeTime,
                  opacity: panelClosed ? 1 : 0,
                  child: generalButton(context, Icons.settings)
              ),
            ),

            // --------------------- BOTAO DE AJUDA
            Positioned(
              left: padding,
              bottom: buttonPosition + buttonSize + padding,
              child: AnimatedOpacity(
                  duration: fadeTime,
                  opacity: panelClosed ? 1 : 0,
                  child: generalButton(context, Icons.question_mark)
              ),
            ),

            // --------------------- BOTAO DE USER
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
      foregroundColor: Color(0xFF8D021F),
      elevation: elevation,
      buttonSize: const Size(buttonSize, buttonSize),
      spacing: 7,
      onOpen: () => setState(() {
        openMapSearch = false;
        FocusManager.instance.primaryFocus?.unfocus();
      }),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.search),
          backgroundColor: transparencyLvl,
          foregroundColor: iconColor,
          elevation: elevation,
          onTap: () {
            focusNode.requestFocus();
            setState(() {
              openMapSearch = true;
            });
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.add),
          backgroundColor: transparencyLvl,
          foregroundColor: iconColor,
          elevation: elevation,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            setState(() {
              currentMarkers = (currentGarden == 1) ? markers1 : markers2;
              searchMarkerController.clear();
            });
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Add a new marker"),
                content: TextField(
                  controller: newMarkerController,
                  decoration: const InputDecoration(
                    hintText: "Marker name",
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      final name = newMarkerController.text;
                      Navigator.pop(context, 'OK');
                      FocusManager.instance.primaryFocus?.unfocus();
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 6),
                        content: Text('Select where to place the marker.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      addMarker(name);
                      newMarkerController.clear();
                    },
                    child: const Text('OK')
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel')
                  )
                ],
              )
            );
          }
        ),
      ],
    );
  }

}

class MapLayout extends MultiChildLayoutDelegate {
  final List<Marker> markerList;
  final constraints = BoxConstraints(
      maxHeight: _HomePageState.markerSize*3,
      maxWidth: _HomePageState.markerSize*4
  );

  MapLayout({required this.markerList});

  @override
  void performLayout(Size size) {
    for (var marker in markerList) {
      layoutChild(marker.id, constraints);
      positionChild(marker.id, marker.position);
    }
  }

  @override
  bool shouldRelayout(MapLayout oldDelegate) {
    return (markerList != oldDelegate.markerList);
  }

}
