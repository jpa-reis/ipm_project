import 'package:flutter/material.dart';
import 'package:ipm_project/globals.dart';
import 'package:ipm_project/panel_widget.dart';
import 'white_theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
          primarySwatch: myWhite,
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


class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const Color iconColor = Color(0xFF383838);
  static const double elevation = 0.7;
  static const double initButtonPosition = buttonSize + 30.0;
  static const Duration fadeTime = Duration(milliseconds: 200);
  Color transparencyLvl = Colors.white.withOpacity(0.7);
  double buttonPosition = initButtonPosition;
  double padding = 15.0;
  bool panelClosed = true;
  bool openMapSearch = false;

  TextEditingController editingController = TextEditingController();
  final TransformationController _transformationController =
    TransformationController();


  @override
  void initState() {
    super.initState();
    buttonPosition = initButtonPosition;
    panelClosed = true;
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
              onTapDown: (details) => setState(() {
                openMapSearch = false;
                var position = details.globalPosition;
              }),
              child: InteractiveViewer(
                transformationController: _transformationController,
                constrained: false,
                scaleEnabled: true,
                minScale: 0.2,
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
                                  builder: (context) => marker.getPage()
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
            onTap: () {},
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


class Marker {
  final Offset position;
  final Widget page;

  const Marker({
    required this.position,
    required this.page});

  Offset getPosition() {
    return position;
  }

  Widget getPage() {
    return page;
  }
}
