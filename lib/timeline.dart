import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ipm_project/panel_widget_timeline.dart';
import 'package:ipm_project/show_photo.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'globals.dart';
import 'imageData.dart';
import 'marker.dart';
import 'package:image_picker/image_picker.dart';
import 'editImage.dart';

class Timeline extends StatefulWidget {
  const Timeline(
      {super.key, required this.indexOf, required this.currentGarden, required this.marker});

  final int indexOf;
  final int currentGarden;
  final Marker marker;
  @override
  State<Timeline> createState() => _TimelineState(indexOf);
}

class _TimelineState extends State<Timeline> {
  _TimelineState(this.indexOf);

  final int indexOf;

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.85;
    final panelController = PanelController();
    const double buttonSize = 50.0;
    const double initButtonPosition = buttonSize + 30.0;
    late double buttonPosition;
    buttonPosition = initButtonPosition;
    double padding = 25.0;
    buttonPosition = panelHeightClosed + padding;
    late bool panelClosed = true;
    late bool openMapSearch = false;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SlidingUpPanel(
            color: Color(0xff054f20),
            borderRadius: const BorderRadius.vertical(top:Radius.circular(15)),
            boxShadow: [ BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )],
            controller: panelController,
            maxHeight: widget.marker.description == "" ?  170 :panelHeightOpen,
            minHeight: panelHeightClosed,
            panelBuilder: (controller) => PanelWidgetTimeline(
              marker: widget.marker,
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
            body: Stack(children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height *2
                      ,
                  child: DefaultTabController(
                  animationDuration: Duration.zero,
                  length: 2,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(70),
                      child: Theme(
                        data: ThemeData(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        child: AppBar(
                          backgroundColor: Color(0xff054f20),
                          elevation: 0,
                          bottom: TabBar(
                              padding: EdgeInsets.all(8.0),
                              labelColor: Colors.white,
                              unselectedLabelColor:Color(0xFFD3D3D3),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  color: Color(0xff076e2c)),
                              tabs: const [
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("My timeline"),
                                  ),
                                ),
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Community"),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    body: TabBarView(children: [
                      Container(
                        color: Colors.white,
                        child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: createTimeline()),
                      ),
                      Container(
                        color: Colors.white,
                        child: ListView(children: createTimeLineCommunity()),
                      ),
                    ]),
                  ),
                ),
               ),
              Positioned(
                left: padding,
                bottom: buttonSize,
                child: addLastIcons(),
              )
          ]
        )
        )
    );
  }
  createTimeLineCommunity(){
    orderCommunity();
    List<Widget> list = <Widget>[];
    int i = 0;

    if(currentGarden == 1 && community1[markers1.indexOf(widget.marker)].isEmpty){
      return list;
    }
    else if(currentGarden == 2 && community2[markers2.indexOf(widget.marker)].isEmpty){
      return list;
    }
    list.add(startingTimeline());

    if (currentGarden == 1) {
      while (i < community1[indexOf].length) {
        if (i % 2 == 0 && i == 0) {
          list.add(evenTimelineCommunity(i));
        } else if (i % 2 == 0) {
          list.add(addDivider());
          list.add(evenTimelineCommunity(i));
        } else {
          list.add(addDivider());
          list.add(oddTimelineCommunity(i));
        }
        i++;
      }
    } else {
      while (i < community2[indexOf].length) {
        if (i % 2 == 0 && i == 0) {
          list.add(evenTimelineCommunity(i));
        } else if (i % 2 == 0) {
          list.add(addDivider());
          list.add(evenTimelineCommunity(i));
        } else {
          list.add(addDivider());
          list.add(oddTimelineCommunity(i));
        }
        i++;
      }
    }

    if (i % 2 == 0) {
      list.add(lastTimelineEven());
    } else {
      list.add(lastTimelineOdd());
    }

    list.add(SizedBox(height: 180,));
    return list;
  }

  orderCommunity(){
    if(currentGarden == 1){
      int i = 0;
      while(i < community1[indexOf].length){
        community1[i].sort((photo1, photo2){
          return photo1.date.compareTo(photo2.date);
        });
        i++;
      }
    }
    else{
      int i = 0;
      while(i < community2[indexOf].length){
        community2[i].sort((photo1, photo2){
          return photo1.date.compareTo(photo2.date);
        });
        i++;
      }
    }
  }

  createTimeline() {
    List<Widget> list = <Widget>[];
    int i = 0;
    list.add(startingTimeline());

    if (currentGarden == 1) {
      while (i < images1[indexOf].length) {
        if (i % 2 == 0 && i == 0) {
          list.add(evenTimeline(i));
        } else if (i % 2 == 0) {
          list.add(addDivider());
          list.add(evenTimeline(i));
        } else {
          list.add(addDivider());
          list.add(oddTimeline(i));
        }
        i++;
      }
    } else {
      while (i < images2[indexOf].length) {
        if (i % 2 == 0 && i == 0) {
          list.add(evenTimeline(i));
        } else if (i % 2 == 0) {
          list.add(addDivider());
          list.add(evenTimeline(i));
        } else {
          list.add(addDivider());
          list.add(oddTimeline(i));
        }
        i++;
      }
    }

    if (i % 2 == 0) {
      list.add(lastTimelineEven());
    } else {
      list.add(lastTimelineOdd());
    }

    list.add(SizedBox(height: 180,));
    return list;
  }

  Widget addLastIcons(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                ImageData image =
                await addImage(true, widget.marker, context);
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: const Icon(Icons.camera_alt, size: 30),
            ),
            const SizedBox(width: 200),
            ElevatedButton(
              onPressed: () async {
                ImageData image =
                await addImage(false, widget.marker, context);

              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: const Icon(Icons.add_photo_alternate,
                  size: 30),
            ),
          ]),
    );

  }
//Color(0xff054f20)
  Widget startingTimeline() {
    return TimelineTile(
      afterLineStyle: LineStyle(
        color: Color(0xff054f20),
        thickness: 3,
      ),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        width: 30,
        height: 30,
        color: Color(0xff054f20),
      ),
      alignment: TimelineAlign.manual,
      lineXY: 0.15,
      isFirst: true,
      endChild: Center(
        child: Text(
          "Timeline starts here...",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }

  Widget evenTimeline(int i) {
    return TimelineTile(
      beforeLineStyle: LineStyle(
        color: Color(0xff054f20),
        thickness: 3,
      ),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        width: 50,
        height: 50,
        color: Colors.purple,
        padding: const EdgeInsets.all(8),
        indicator: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff054f20),
              width: 3,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              (currentGarden == 1)
                  ? DateFormat('MM-dd').format(images1[indexOf][i].date)
                  : DateFormat('MM-dd').format(images2[indexOf][i].date),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff054f20)),
            ),
          ),
        ),
      ),
      alignment: TimelineAlign.manual,
      lineXY: 0.15,
      endChild: Padding(
        padding: const EdgeInsets.only(
            left: 40.0, right: 30.0, top: 30.0, bottom: 30.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  if (currentGarden == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowPhoto(
                            image: images1[indexOf][i],
                            marker: markers1[indexOf],
                            indexOf: indexOf,
                            i: i,
                            currentGarden: currentGarden)));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowPhoto(
                            image: images2[indexOf][i],
                            marker: markers2[indexOf],
                            indexOf: indexOf,
                            i: i,
                            currentGarden: currentGarden)));
                  }
                },
                child: (currentGarden == 1)
                    ? Image.file(File(images1[indexOf][i].imagePath))
                    : Image.file(File(images2[indexOf][i].imagePath),
                    width: 300, height: 200, fit: BoxFit.cover),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: (currentGarden == 1)
                      ? Text(images1[indexOf][i].description)
                      : Text(images2[indexOf][i].description),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget evenTimelineCommunity(int i) {
    return TimelineTile(
      beforeLineStyle: LineStyle(
        color: Color(0xff054f20),
        thickness: 3,
      ),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        width: 50,
        height: 50,
        color: Colors.purple,
        padding: const EdgeInsets.all(8),
        indicator: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff054f20),
              width: 3,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              (currentGarden == 1)
                  ? DateFormat('MM-dd').format(images1[indexOf][i].date)
                  : DateFormat('MM-dd').format(images2[indexOf][i].date),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff054f20)),
            ),
          ),
        ),
      ),
      alignment: TimelineAlign.manual,
      lineXY: 0.15,
      endChild: Padding(
        padding: const EdgeInsets.only(
            left: 40.0, right: 30.0, top: 30.0, bottom: 30.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  if (currentGarden == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowPhoto(
                            image: community1[indexOf][i],
                            marker: markers1[indexOf],
                            indexOf: indexOf,
                            i: i,
                            currentGarden: currentGarden)));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowPhoto(
                            image: community2[indexOf][i],
                            marker: markers2[indexOf],
                            indexOf: indexOf,
                            i: i,
                            currentGarden: currentGarden)));
                  }
                },
                child: (currentGarden == 1)
                    ? Image.file(File(community1[indexOf][i].imagePath))
                    : Image.file(File(community2[indexOf][i].imagePath),
                    width: 300, height: 200, fit: BoxFit.cover),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: (currentGarden == 1)
                      ? Text(community1[indexOf][i].description)
                      : Text(community2[indexOf][i].description),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget oddTimeline(int i) {
    return TimelineTile(
      beforeLineStyle: LineStyle(
        color: Color(0xff054f20),
        thickness: 3,
      ),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        width: 50,
        height: 50,
        color: Colors.purple,
        padding: const EdgeInsets.all(8),
        indicator: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff054f20),
              width: 3,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              (currentGarden == 1)
                  ? DateFormat('MM-dd').format(images1[indexOf][i].date)
                  : DateFormat('MM-dd').format(images2[indexOf][i].date),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff054f20)),
            ),
          ),
        ),
      ),
      alignment: TimelineAlign.manual,
      lineXY: 0.85,
      startChild: Padding(
        padding: const EdgeInsets.only(
            left: 40.0, right: 30.0, top: 30.0, bottom: 30.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  if (currentGarden == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowPhoto(
                            image: images1[indexOf][i],
                            marker: markers1[indexOf],
                            indexOf: indexOf,
                            i: i,
                            currentGarden: currentGarden)));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowPhoto(
                            image: images2[indexOf][i],
                            marker: markers2[indexOf],
                            indexOf: indexOf,
                            i: i,
                            currentGarden: currentGarden)));
                  }
                },
                child: (currentGarden == 1)
                    ? Image.file(File(images1[indexOf][i].imagePath))
                    : Image.file(File(images2[indexOf][i].imagePath),
                    width: 300, height: 200, fit: BoxFit.cover),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: (currentGarden == 1)
                      ? Text(images1[indexOf][i].description)
                      : Text(images2[indexOf][i].description),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget oddTimelineCommunity(int i) {
    return TimelineTile(
      beforeLineStyle: LineStyle(
        color: Color(0xff054f20),
        thickness: 3,
      ),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        width: 50,
        height: 50,
        color: Colors.purple,
        padding: const EdgeInsets.all(8),
        indicator: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff054f20),
              width: 3,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              (currentGarden == 1)
                  ? DateFormat('MM-dd').format(images1[indexOf][i].date)
                  : DateFormat('MM-dd').format(images2[indexOf][i].date),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff054f20)),
            ),
          ),
        ),
      ),
      alignment: TimelineAlign.manual,
      lineXY: 0.85,
      startChild: Padding(
        padding: const EdgeInsets.only(
            left: 40.0, right: 30.0, top: 30.0, bottom: 30.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  if (currentGarden == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowPhoto(
                            image: community1[indexOf][i],
                            marker: markers1[indexOf],
                            indexOf: indexOf,
                            i: i,
                            currentGarden: currentGarden)));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShowPhoto(
                            image: community2[indexOf][i],
                            marker: markers2[indexOf],
                            indexOf: indexOf,
                            i: i,
                            currentGarden: currentGarden)));
                  }
                },
                child: (currentGarden == 1)
                    ? Image.file(File(community1[indexOf][i].imagePath))
                    : Image.file(File(community2[indexOf][i].imagePath),
                    width: 300, height: 200, fit: BoxFit.cover),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: (currentGarden == 1)
                      ? Text(community1[indexOf][i].description)
                      : Text(community2[indexOf][i].description),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget lastTimelineOdd() {
    return TimelineTile(
      beforeLineStyle: LineStyle(
        color: Color(0xff054f20),
        thickness: 3,
      ),
      afterLineStyle: LineStyle(
        color: Color(0xff054f20),
        thickness: 3,
      ),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        width: 30,
        height: 30,
        color: Color(0xff054f20),
      ),
      alignment: TimelineAlign.manual,
      lineXY: 0.15,
      isLast: true,
      endChild: Center(
        child: Text("Timeline ends here!",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color:Colors.black
          ),
        )
      ),
    );
  }

  Widget lastTimelineEven() {
    return TimelineTile(
      beforeLineStyle: LineStyle(
        color: Color(0xff054f20),
        thickness: 3,
      ),
      afterLineStyle: LineStyle(
        color: Color(0xff054f20),
        thickness: 3,
      ),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        width: 30,
        height: 30,
        color: Color(0xff054f20),
      ),
      alignment: TimelineAlign.manual,
      lineXY: 0.85,
      isLast: true,
      endChild: Center(
        child: Text(
          "Timeline ends here...",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFD3D3D3)
          ),
        ),
      ),
    );
  }

  Widget addDivider() {
    return const TimelineDivider(
      begin: 0.15,
      end: 0.85,
      thickness: 3,
      color: Color(0xff054f20),
    );
  }
}

//adds image to images list and moves to edit screen of that image
addImage(bool useCamera, Marker marker, BuildContext context) async {
  final navigator = Navigator.of(context);
  XFile? image;
  if (useCamera) {
    image = await ImagePicker().pickImage(source: ImageSource.camera);
  } else {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
  }
  if (image == null) return;
  final now = DateTime.now();
  int markerIndex = markers1.indexOf(marker);
  ImageData i =
  ImageData(imagePath: image.path, date: now, markerIndex: markerIndex);
  if (currentGarden == 1) {
    images1[markers1.indexOf(marker)].add(i);
  } else {
    images2[markers2.indexOf(marker)].add(i);
  }
  navigator.push(MaterialPageRoute(
      builder: (context) => EditImageScreen(
        image: i,
        marker: marker,
        currentGarden: currentGarden,
      )));
}