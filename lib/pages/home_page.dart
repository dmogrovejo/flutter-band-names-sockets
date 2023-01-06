import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'RockStar', votes: 3),
    Band(id: '2', name: 'Bajos Sueños', votes: 13),
    Band(id: '3', name: 'StartBand', votes: 23),
    Band(id: '4', name: 'Don Medardo', votes: 43),
    Band(id: '5', name: 'Locos del Ritmo', votes: 56),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandas', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (BuildContext context, int index) {
            return _createListTitle(bands[index]);
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), elevation: 1, onPressed: _addNewBand),
    );
  }

  Widget _createListTitle(Band band) {
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('dismissed: $direction');
        print('id: ${band.id}');
        bands.remove(band);
        setState(() {});
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name!.substring(0, 2)),
          backgroundColor: Colors.blue[200],
        ),
        title: Text(band.name!),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  _addNewBand() {
    final TextEditingController txtBandName = new TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Nueva Banda:'),
            content: TextField(
              controller: txtBandName,
            ),
            actions: [
              MaterialButton(
                  elevation: 5,
                  child: Text('Agregar'),
                  textColor: Colors.blue,
                  onPressed: () => _addBantoList(txtBandName.text))
            ],
          );
        });
  }

  _addBantoList(String name) {
    print(name);
    if (name.isNotEmpty) {
      // se debe agregar al listado
      bands.add(new Band(id: '$bands.length', name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
