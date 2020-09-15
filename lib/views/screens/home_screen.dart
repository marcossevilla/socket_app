import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../blocs/socket_bloc.dart';
import '../../models/band.dart';
import '../widgets/add_band_dialog.dart';

class HomeScreen extends StatefulWidget {
  static const String route = 'home';

  static Route go() => MaterialPageRoute<void>(builder: (_) => HomeScreen());

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var bands = <Band>[];

  @override
  void initState() {
    context.read<SocketBloc>().socket.on('active_bands', (payload) {
      bands = (payload as List).map((band) => Band.fromMap(band)).toList();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    context.read<SocketBloc>().socket.off('active_bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final status = context.select((SocketBloc bloc) => bloc.status);

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: const Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: status == ServerStatus.online
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.offline_bolt, color: Colors.red),
          ),
        ],
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
          '${band.votes}',
          style: const TextStyle(fontSize: 20.0),
        ),
        onTap: () {},
      ),
    );
  }
}
