import 'package:flutter/material.dart';
import 'package:cpuesp32/constants.dart';
import '../comunes.dart';

class Salidas extends StatefulWidget {
  final int? data;
  final Function(int) salida;
  const Salidas({Key? key, this.data, required this.salida}) : super(key: key);

  @override
  _Salidas createState() => _Salidas();
}

class _Salidas extends State<Salidas> {
//class ItemControlador extends StatelessWidget {
  int salida1 = 0;
  int salida2 = 0;
  String? _etiqueta;
  String? _Salida1;
  String? _Salida2;
  bool? s1Normal;
  bool? s2Normal;
  bool? s1Interm;
  bool? s2Interm;
  bool? s1ResetVcc;
  bool? s2ResetVcc;
  bool? _activo;
  bool? _excluido;
  @override
  void initState() {
    s1Normal = checkBit(widget.data!, 0);
    s1Interm = checkBit(widget.data!, 1);
    s1ResetVcc = checkBit(widget.data!, 2);
    s2Normal = checkBit(widget.data!, 4);
    s2Interm = checkBit(widget.data!, 5);
    s2ResetVcc = checkBit(widget.data!, 6);

    if (s1Normal!) {
      salida1 = bitSet(salida1, 0);
      _Salida1 = "Normal";
      s1Interm = false;
      s1ResetVcc = false;
    } else if (s1Interm!) {
      salida1 = bitSet(salida1, 1);
      _Salida1 = "Intermitente";
      s1Normal = false;
      s1ResetVcc = false;
    } else if (s1ResetVcc!) {
      salida1 = bitSet(salida1, 2);
      _Salida1 = "ResetVcc";
      s1Normal = false;
      s1Interm = false;
    }
    if (s2Normal!) {
      salida2 = bitSet(salida2, 4);
      _Salida2 = "Normal";
      s2Interm = false;
      s2ResetVcc = false;
    } else if (s2Interm!) {
      salida2 = bitSet(salida2, 5);
      _Salida2 = "Intermitente";
      s2Normal = false;
      s2ResetVcc = false;
    } else if (s2ResetVcc!) {
      salida2 = bitSet(salida2, 6);
      _Salida2 = "ResetVcc";
      s2Normal = false;
      s2Interm = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Card(
        margin: EdgeInsets.only(left: 10, top: 10, right: 2, bottom: 2),
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
                "Salida1",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              )),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(_Salida1!),
          ),
          Padding(
              padding:
                  const EdgeInsets.only(left: 10, top: 2, right: 2, bottom: 2),
              child: Row(children: [
                Text("Normal "),
                Switch(
                    value: s1Normal!,
                    onChanged: (bool value) {
                      salida1 = 0;
                      setState(() {
                        s1Normal = value;
                        if (s1Normal!) {
                          salida1 = bitSet(salida1, 0);
                          _Salida1 = "Normal";
                          s1Interm = false;
                          s1ResetVcc = false;

                          widget.salida(salida1 + salida2);
                        }
                        if (!s1Normal! && !s1Interm! && !s1ResetVcc!) {
                          salida1 = bitSet(salida1, 0);
                          _Salida1 = "Normal";
                          s1Normal = true;
                          widget.salida(salida1 + salida2);
                        }
                      });
                    })
              ])),
          Padding(
              padding:
                  const EdgeInsets.only(left: 10, top: 2, right: 2, bottom: 2),
              child: Row(children: [
                Text("Interm "),
                Switch(
                    value: s1Interm!,
                    onChanged: (bool value) {
                      salida1 = 0;
                      setState(() {
                        s1Interm = value;
                        if (s1Interm!) {
                          salida1 = bitSet(salida1, 1);
                          _Salida1 = "Intermitente";
                          s1Normal = false;
                          s1ResetVcc = false;
                          widget.salida(salida1 + salida2);
                        }
                        if (!s1Normal! && !s1Interm! && !s1ResetVcc!) {
                          salida1 = bitSet(salida1, 0);
                          _Salida1 = "Normal";
                          s1Normal = true;
                          widget.salida(salida1 + salida2);
                        }
                      });
                    })
              ])),
          Padding(
              padding:
                  const EdgeInsets.only(left: 10, top: 2, right: 2, bottom: 2),
              child: Row(children: [
                Text("ResetVcc "),
                Switch(
                    value: s1ResetVcc!,
                    onChanged: (bool value) {
                      salida1 = 0;
                      setState(() {
                        s1ResetVcc = value;
                        if (s1ResetVcc!) {
                          salida1 = bitSet(salida1, 2);
                          _Salida1 = "ResetVcc";
                          s1Interm = false;
                          s1Normal = false;
                          widget.salida(salida1 + salida2);
                        }
                        if (!s1Normal! && !s1Interm! && !s1ResetVcc!) {
                          salida1 = bitSet(salida1, 0);
                          _Salida1 = "Normal";
                          s1Normal = true;
                          widget.salida(salida1 + salida2);
                        }
                      });
                    })
              ])),
        ]),
      )),
      Expanded(
          child: Card(
        margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 2),
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
                "Salida2",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              )),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(_Salida2!),
          ),
          Padding(
              padding:
                  const EdgeInsets.only(left: 10, top: 2, right: 2, bottom: 2),
              child: Row(children: [
                Text("Normal "),
                Switch(
                    value: s2Normal!,
                    onChanged: (bool value) {
                      salida2 = 0;
                      setState(() {
                        s2Normal = value;
                        if (s2Normal!) {
                          salida2 = bitSet(salida2, 4);
                          _Salida2 = "Normal";
                          s2Interm = false;
                          s2ResetVcc = false;
                          widget.salida(salida1 + salida2);
                        }
                        if (!s2Normal! && !s2Interm! && !s2ResetVcc!) {
                          salida2 = bitSet(salida2, 4);
                          _Salida2 = "Normal";
                          s2Normal = true;
                          widget.salida(salida1 + salida2);
                        }
                      });
                    })
              ])),
          Padding(
              padding:
                  const EdgeInsets.only(left: 10, top: 2, right: 2, bottom: 2),
              child: Row(children: [
                Text("Interm "),
                Switch(
                    value: s2Interm!,
                    onChanged: (bool value) {
                      salida2 = 0;
                      setState(() {
                        s2Interm = value;
                        if (s2Interm!) {
                          salida2 = bitSet(salida2, 5);
                          _Salida2 = "Intermitente";
                          s2Normal = false;
                          s2ResetVcc = false;
                          widget.salida(salida1 + salida2);
                        }
                        if (!s2Normal! && !s2Interm! && !s2ResetVcc!) {
                          salida2 = bitSet(salida2, 4);
                          _Salida2 = "Normal";
                          s2Normal = true;
                          widget.salida(salida1 + salida2);
                        }
                      });
                    })
              ])),
          Padding(
              padding:
                  const EdgeInsets.only(left: 10, top: 2, right: 2, bottom: 2),
              child: Row(children: [
                Text("ResetVcc "),
                Switch(
                    value: s2ResetVcc!,
                    onChanged: (bool value) {
                      salida2 = 0;
                      setState(() {
                        s2ResetVcc = value;
                        if (s2ResetVcc!) {
                          salida2 = bitSet(salida2, 6);
                          _Salida2 = "ResetVcc";
                          s2Interm = false;
                          s2Normal = false;
                          widget.salida(salida1 + salida2);
                        }
                        if (!s2Normal! && !s2Interm! && !s2ResetVcc!) {
                          salida2 = bitSet(salida2, 4);
                          _Salida2 = "Normal";
                          s2Normal = true;
                          widget.salida(salida1 + salida2);
                        }
                      });
                    })
              ])),
        ]),
      ))
    ]);
  }
}
