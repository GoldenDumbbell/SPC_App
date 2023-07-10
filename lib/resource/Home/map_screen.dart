import 'package:flutter/material.dart';
import 'package:webspc/DTO/spot.dart';
import 'package:webspc/path_finding/map_painter.dart';
import 'package:webspc/path_finding/map_pre_handle.dart';
import 'package:webspc/path_finding/path_finding_algorithm.dart';
import 'package:webspc/resource/Home/home_page.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.listSpot, this.boughtSpot});
  final List<Spot> listSpot;
  final Spot? boughtSpot;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapObject end;
  late MapObject start;
  late List<MapObject> spots;
  late List<MapObject> obstacles;
  MapPreHandle mapPreHandle = MapPreHandle(
    mapWidth: 50,
    mapHeight: 50,
  );

  List<List<int>> navigatedMap = [];
  void initialMap() {
    mapPreHandle.start = start;
    mapPreHandle.end = end;
    mapPreHandle.generateMap();
    // Draw the spot from spots list
    for (int i = 0; i < spots.length; i++) {
      mapPreHandle.drawSpot(
        row: spots[i].row,
        col: spots[i].col,
        width: spots[i].width,
        height: spots[i].height,
      );
    }
    // Draw obstacles from obstacles list
    for (int i = 0; i < obstacles.length; i++) {
      mapPreHandle.drawObstacle(
        row: obstacles[i].row,
        col: obstacles[i].col,
        width: obstacles[i].width,
        height: obstacles[i].height,
      );
    }
    setState(() {
      navigatedMap = mapPreHandle.map;
    });
  }

  @override
  void initState() {
    start = MapObject(46, 0, 8, 4);
    end = MapObject(0, 0, 8, 6);
    spots = [
      // Row, col, width, height
      MapObject(0, 0, 8, 6, "A04", widget.listSpot[3].available!),
      MapObject(0, 20, 6, 8, "B02", widget.listSpot[5].available!),
      MapObject(0, 42, 8, 6, "C04", widget.listSpot[9].available!),
      MapObject(13, 0, 8, 6, "A03", widget.listSpot[2].available!),
      MapObject(13, 42, 8, 6, "C03", widget.listSpot[8].available!),
      MapObject(22, 0, 8, 6, "A02", widget.listSpot[1].available!),
      MapObject(22, 42, 8, 6, "C02", widget.listSpot[7].available!),
      MapObject(35, 0, 8, 6, "A01", widget.listSpot[0].available!),
      MapObject(35, 20, 6, 8, "B01", widget.listSpot[4].available!),
      MapObject(35, 42, 8, 6, "C01", widget.listSpot[6].available!),
    ];

    obstacles = [MapObject(12, 16, 20, 20, "Elevator")];
    initialMap();
    // Check if boughtSpot is not null
    if (mounted && widget.boughtSpot != null) {
      // Find spot in spots list has the same spotId with boughtSpot

      for (int i = 0; i < spots.length; i++) {
        if (spots[i].title == widget.boughtSpot!.spotId) {
          // Set start to the spot
          List<List<int>> newMap = mapPreHandle.findPossibleRoad();
          Grid grid = Grid(navigatedMap);
          PathFindingAlgorithm pathFindingV2 = PathFindingAlgorithm(grid: grid);
          List<List<int>> navMap = pathFindingV2.findPath(start, spots[i]);
          if (newMap.isNotEmpty) {
            setState(() {
              navigatedMap = navMap;
            });
          }
          break;
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double mapWidthOnScreen =
        MediaQuery.of(context).size.width / mapPreHandle.mapWidth;
    final double mapHeightOnScreen =
        MediaQuery.of(context).size.width / mapPreHandle.mapHeight;
    // Show the map
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        // centerTitle: false,
        // automaticallyImplyLeading: false,
        backgroundColor: Color(0xff3a57e8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Parking Spot (S101 Floor 1)",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24),
          color: Color(0xff212435),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: widget.listSpot.isEmpty
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      // Draw the map on top of the stack
                      children: [
                        // Draw start point
                        Positioned(
                          left: start.col * mapWidthOnScreen,
                          top: start.row * mapHeightOnScreen,
                          child: Container(
                            width: 66,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: Color(0x4d9e9e9e), width: 1),
                            ),
                            child: const Center(
                              child: Text(
                                'You',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Draw spot and obstacles
                        for (MapObject obstacle in obstacles)
                          Positioned(
                            left: obstacle.col * mapWidthOnScreen,
                            top: 120,
                            child: Container(
                              width: 150,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0x1f000000),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: Color(0x4d9e9e9e), width: 1),
                              ),
                              child: Center(
                                child: Text(
                                  obstacle.title ?? 'Obstacle',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        CustomPaint(
                          painter: MapPainter(
                              navigatedMap,
                              [start.row, start.col],
                              [end.row, end.col]), // Provide the map data
                          size: Size(
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.width,
                          ),
                        ),
                        for (MapObject spot in spots)
                          Positioned(
                            left: spot.col * mapWidthOnScreen,
                            top: spot.row * mapHeightOnScreen,
                            child: GestureDetector(
                              onTap: () {
                                if (spot.available ||
                                    spot.title == widget.boughtSpot!.spotId) {
                                  initialMap();
                                  List<List<int>> newMap =
                                      mapPreHandle.findPossibleRoad();
                                  Grid grid = Grid(navigatedMap);
                                  PathFindingAlgorithm pathFindingV2 =
                                      PathFindingAlgorithm(grid: grid);
                                  List<List<int>> navMap =
                                      pathFindingV2.findPath(start, spot);
                                  if (newMap.isNotEmpty) {
                                    setState(() {
                                      navigatedMap = navMap;
                                    });
                                  }
                                }
                              },
                              child: Container(
                                width: 80,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: spot.available
                                      ? const Color.fromARGB(255, 194, 190, 190)
                                      : widget.boughtSpot != null
                                          ? spot.title ==
                                                  widget.boughtSpot!.spotId
                                              ? const Color.fromARGB(
                                                  255, 133, 186, 230)
                                              : const Color.fromARGB(
                                                  255, 234, 116, 107)
                                          : Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                      color: Color(0x4d9e9e9e), width: 1),
                                ),
                                child: Center(
                                  child: Text(
                                    spot.title ?? 'Spot',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Button to generate a random map
                ],
              ),
      ),
    );
  }
}
