import 'package:bubble_timeline/bubble_timeline.dart';
import 'package:bubble_timeline/timeline_item.dart';
import 'package:flutter/material.dart';

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                  unselectedLabelColor: Colors.lightGreen,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.lightGreen),
                  tabs: [
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: Colors.lightGreen, width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("My timeline"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: Colors.lightGreen, width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("Community"),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        body: const TabBarView(children: [
          BubbleTimeline(
            bubbleDiameter: 120,
            // List of Timeline Bubble Items
            items: [
              TimelineItem(
                title: 'Boat',
                subtitle: 'Travel through Oceans',
                child: Icon(
                  Icons.directions_boat,
                  color: Colors.white,
                ),
                bubbleColor: Colors.grey,
              ),
              TimelineItem(
                title: 'Bike',
                subtitle: 'Road Trips are best',
                child: Icon(
                  Icons.directions_bike,
                  color: Colors.white,
                ),
                bubbleColor: Colors.grey,
              ),
              TimelineItem(
                title: 'Bus',
                subtitle: 'I like to go with friends',
                child: Icon(
                  Icons.directions_bus,
                  color: Colors.white,
                ),
                bubbleColor: Colors.grey,
              ),
              TimelineItem(
                title: 'Bus',
                subtitle: 'I like to go with friends',
                child: Icon(
                  Icons.directions_bus,
                  color: Colors.white,
                ),
                bubbleColor: Colors.grey,
              ),
              TimelineItem(
                title: 'Bus',
                subtitle: 'I like to go with friends',
                child: Icon(
                  Icons.directions_bus,
                  color: Colors.white,
                ),
                bubbleColor: Colors.grey,
              ),
            ],
            stripColor: Colors.teal,
            scaffoldColor: Colors.white,
          ),
          Icon(Icons.movie),
        ]),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.lightGreen,
          child: Text("Rose", textAlign: TextAlign.center, style: TextStyle(fontSize: 25, color: Colors.white), )
        ),
      ),
    ));
  }
}