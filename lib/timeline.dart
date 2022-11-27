import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ipm_project/panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'globals.dart';
import 'imageData.dart';
class Timeline extends StatefulWidget {

  const Timeline({super.key, required this.indexOf});
  final int indexOf;

  @override
  State<Timeline> createState() => _TimelineState(indexOf);
}

class _TimelineState extends State<Timeline> {
  _TimelineState(this.indexOf);
  final int indexOf;

  static const double buttonSize = 50.0;
  final panelController = PanelController();
  static const double initButtonPosition = buttonSize + 30.0;
  Color transparencyLvl = Colors.white.withOpacity(0.7);
  double buttonPosition = initButtonPosition;
  double padding = 15.0;
  bool panelClosed = true;
  bool openMapSearch = false;





  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.08;
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.9;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: DefaultTabController(
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
                      unselectedLabelColor: Colors.white,
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
                color:  Colors.white,

                child: ListView(
                  children: createTimeline()
                ),
              ),
              Container(
                color:  Colors.white,

                child: ListView(
                    children: createTimeline()
                ),
              ),
            ]),
          ),
        ));
  }

  createTimeline() {
    List<Widget> list = <Widget>[];
    int i = 0;
    list.add(startingTimeline());

    while(i < images[indexOf].length){
      if(i % 2 == 0 && i == 0){
        list.add(evenTimeline(i));
      }
      else if(i % 2 == 0){
        list.add(addDivider());
        list.add(evenTimeline(i));
      }
      else{
        list.add(addDivider());
        list.add(oddTimeline(i));
      }
      i++;
    }

    if(i % 2 == 0){
      list.add(lastTimelineEven());
    }
    else{
      list.add(lastTimelineOdd());
    }


    return list;
  }

  Widget startingTimeline(){
    return TimelineTile(
      afterLineStyle: LineStyle(
        color: Color(0xFF618A3D),
        thickness: 3,
      ),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        width: 30,
        height: 30,
        color:  Color(0xFF618A3D),

      ),
      alignment: TimelineAlign.manual,
      lineXY: 0.15,
      isFirst: true,
      endChild: Center(
        child: Text(
          "Timeline starts here...",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget evenTimeline(int i){
    return TimelineTile(
      beforeLineStyle: LineStyle(
        color: Color(0xFF618A3D),
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
              color: Color(0xFF618A3D),
              width: 3,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              images[indexOf][i].date,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF618A3D)),
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
              child: Image.file(File(images[indexOf][i].imagePath),
                  width: 300, height: 200, fit: BoxFit.cover),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.search),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(images[indexOf][i].description),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget oddTimeline(int i){
    return TimelineTile(
      beforeLineStyle: LineStyle(
        color: Color(0xFF618A3D),
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
              color: Color(0xFF618A3D),
              width: 3,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              images[indexOf][i].date,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF618A3D)),
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
              child:  Image.file(File(images[indexOf][i].imagePath),
                  width: 300, height: 200, fit: BoxFit.cover),
            ),
            Row(
              children:[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.search),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(images[indexOf][i].description),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget lastTimelineOdd(){
    return TimelineTile(
      afterLineStyle: LineStyle(
        color: Color(0xFF618A3D),
        thickness: 3,
      ),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        width: 30,
        height: 30,
        color:  Color(0xFF618A3D),

      ),
      alignment: TimelineAlign.manual,
      lineXY: 0.15,
      isLast: true,
      endChild: Center(
        child: Text(
          "Timeline ends here...",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget lastTimelineEven(){
    return TimelineTile(
      afterLineStyle: LineStyle(
        color: Color(0xFF618A3D),
        thickness: 3,
      ),
      indicatorStyle: IndicatorStyle(
        drawGap: true,
        width: 30,
        height: 30,
        color:  Color(0xFF618A3D),

      ),
      alignment: TimelineAlign.manual,
      lineXY: 0.85,
      isLast: true,
      endChild: Center(
        child: Text(
          "Timeline ends here...",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget addDivider(){
    return const TimelineDivider(
      begin: 0.15,
      end: 0.85,
      thickness: 3,
      color: Color(0xFF618A3D),
    );
  }

}
