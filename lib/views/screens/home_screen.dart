import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../blocs/socket_bloc.dart';
import '../../models/band.dart';
import '../../views/screens/status_screen.dart';
import '../widgets/add_band_dialog.dart';

class HomeScreen extends StatefulWidget {
  static const String route = 'home';

  static Route go() => MaterialPageRoute<void>(builder: (_) => HomeScreen());

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var bands = <Band>[];

  final colors = <Color>[
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
    Colors.purple.shade100,
  ];

  void _handleActiveBands(Object payload) {
    bands = (payload as List).map((band) => Band.fromMap(band)).toList();
    setState(() {});
  }

  @override
  void initState() {
    context.read<SocketBloc>().socket.on('active_bands', _handleActiveBands);
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
          IconButton(
            icon: status == ServerStatus.online
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.offline_bolt, color: Colors.red),
            onPressed: () => Navigator.of(context).push(StatusScreen.go()),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          if (bands.isNotEmpty) _pieChart(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: bands.length,
            itemBuilder: (context, index) => _BandTile(bands[index]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        child: const Icon(Icons.add),
        onPressed: addNewBand,
      ),
    );
  }

  void addNewBand() {
    showDialog(context: context, builder: (_) => const AddBandDialog());
  }

  Widget _pieChart() {
    var dataMap = <String, double>{};
    for (var band in bands) {
      dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
    }

    return Container(
      margin: const EdgeInsets.all(20),
      child: PieChart(
        dataMap: dataMap,
        colorList: colors,
        chartType: ChartType.ring,
        chartRadius: MediaQuery.of(context).size.width / 3,
        animationDuration: const Duration(milliseconds: 500),
        legendOptions: const LegendOptions(legendShape: BoxShape.circle),
        chartValuesOptions: const ChartValuesOptions(
          showChartValues: true,
          showChartValueBackground: false,
          showChartValuesInPercentage: true,
        ),
      ),
    );
  }
}

class _BandTile extends StatelessWidget {
  const _BandTile(this.band, {Key key}) : super(key: key);

  final Band band;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) {
        context.read<SocketBloc>().emit('delete_band', {'id': band.id});
      },
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
        onTap: () {
          context.read<SocketBloc>().emit('vote_band', {'id': band.id});
        },
      ),
    );
  }
}
