import 'package:flutter/material.dart';
import 'package:flutter_expansion_tile/custom_tile.dart';

void main() => runApp(TileApp());

class TileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Custom Expansion Tile",
      home: CustomTile(
        title: Text(
          "Here will be the title",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
        notExpandedTileHeightRatio: 0.1,
        expandedTileHeightRatio: 0.4,
        contentPadding: EdgeInsets.all(10.0),
        children: [
          Text("Hello ! 1"),
          Text("Hello World! 3"),
          Text("Hello World! 4"),
          Text("Hello ! 2"),
          Text("Hello World! 5"),
          Text("Hello World! 6"),
          Text("Hello ! 3"),
          Text("Hello World! 7"),
          Text("Hello World! 8"),
          Text("Hello ! 4"),
          Text("Hello World! 9"),
          Text("Hello World! 10"),
          Text("Hello ! 5"),
          Text("Hello World! 11"),
          Text("Hello World! 12"),
        ],
      ),
    );
  }
}