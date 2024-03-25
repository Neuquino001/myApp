import 'package:flutter/material.dart';
import 'package:cpuesp32/constants.dart';
import '../comunes.dart';

class ItemControlador extends StatefulWidget {
  final int? id;
  final int? data;
  final Function(int) setStControl;
  const ItemControlador(
      {Key? key, this.id, this.data, required this.setStControl})
      : super(key: key);

  @override
  _ItemControlador createState() => _ItemControlador();
}

class _ItemControlador extends State<ItemControlador> {
//class ItemControlador extends StatelessWidget {
  String? _etiqueta;
  bool? _activo;
  bool? _excluido;
  int? _stcontrol;
  @override
  void initState() {
    _stcontrol = widget.data!;
    _activo = checkBit(widget.data!, 0);
    if (_activo!)
      _etiqueta = "Activo ";
    else
      _etiqueta = "Anulado ";

    _excluido = checkBit(widget.data!, 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Theme.of(context).canvasColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: primaryColor.withOpacity(0.8), width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Controlador Id ' + widget.id.toString(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              Text(_etiqueta!),
              Switch(
                  // This bool value toggles the switch.
                  value: _activo!,
                  onChanged: (bool value) {
                    setState(() {
                      _activo = value;
                      if (_activo!) {
                        _etiqueta = "Activo ";
                        _stcontrol = bitSet(_stcontrol!, 0);
                      } else {
                        _etiqueta = "Anulado ";
                        _stcontrol = bitClear(_stcontrol!, 0);
                      }
                      widget.setStControl(_stcontrol!);
                    });

                    // This is called when the user toggles the switch.
                  })
            ])),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              Text("Excluido "),
              Switch(
                  // This bool value toggles the switch.
                  value: _excluido!,
                  onChanged: (bool value) {
                    setState(() {
                      _excluido = value;
                      if (_excluido!) {
                        _stcontrol = bitSet(_stcontrol!, 1);
                      } else {
                        _stcontrol = bitClear(_stcontrol!, 1);
                      }
                      widget.setStControl(_stcontrol!);
                    });

                    // This is called when the user toggles the switch.
                  })
            ]))
      ]),
    );
  }
}
