import 'package:flutter/material.dart';

import '../../models/band.dart';
import '../widgets/add_band_dialog.dart';

class HomeScreen extends StatefulWidget {
  static const String route = 'home';

  static Route go() => MaterialPageRoute<void>(builder: (_) => HomeScreen());

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var bands = <Band>[
    Band(id: '0', name: 'Red Hot Chili Peppers', votes: 5),
    Band(id: '2', name: 'Muse', votes: 3),
    Band(id: '1', name: 'Queen', votes: 8),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 1.0,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) {
          final band = bands[index];
          return _BandTile(band, onDelete: deleteBand);
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1.0,
        child: const Icon(Icons.add),
        onPressed: addNewBand,
      ),
    );
  }

  void addNewBand() {
    showDialog(
      context: context,
      builder: (context) => AddBandDialog(
        confirmationAction: (Band newBand) {
          setState(() => bands.add(newBand));
        },
      ),
    );
  }

  void deleteBand(Band band) => setState(() => bands.remove(band));
}

class _BandTile extends StatelessWidget {
  const _BandTile(this.band, {Key key, this.onDelete}) : super(key: key);

  final Band band;
  final Function(Band) onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) => onDelete(band),
      background: Container(
        padding: const EdgeInsets.only(left: 15.0),
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: const Text(
          'Delete band',
          style: TextStyle(color: Colors.white),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text(
          band.votes.toString(),
          style: const TextStyle(fontSize: 20.0),
        ),
        onTap: () {},
      ),
    );
  }
}
