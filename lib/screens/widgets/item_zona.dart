import 'package:flutter/material.dart';
import 'package:cpuesp32/constants.dart';
import '../comunes.dart';
import 'package:cpuesp32/api_dio/client.dart';
import 'package:cpuesp32/api_dio/model01.dart';

class ItemZona extends StatefulWidget {
  final int? idControl;
  final int? idZona;
  final int? data;
  final Function(int) setStZona;
  const ItemZona(
      {Key? key,
      this.idControl,
      this.idZona,
      this.data,
      required this.setStZona})
      : super(key: key);

  @override
  _ItemZona createState() => _ItemZona();
}

class _ItemZona extends State<ItemZona> {
//class ItemControlador extends StatelessWidget {
  final _etiquetaZona = TextEditingController();
  String _etiqueta = "Activa ";
  int _stZona = 0;
  bool? _activa;
  bool? _excluida;
  bool? _retardo;
  int? _idControl;
  String textRead = "null";
  bool dataRequest = false;
  bool statuSave = false;
  @override
  void initState() {
    _idControl = widget.idControl;
    _stZona = widget.data!;
    _activa = checkBit(widget.data!, 0);
    if (_activa!)
      _etiqueta = "Activa ";
    else
      _etiqueta = "Anulada ";
    _excluida = checkBit(widget.data!, 1);
    _retardo = checkBit(widget.data!, 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_idControl != widget.idControl) initState();
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
              'Zona Id ' + widget.idZona.toString(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            )),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              Text(_etiqueta),
              Switch(
                  // This bool value toggles the switch.
                  value: _activa!,
                  onChanged: (bool value) {
                    setState(() {
                      _activa = value;
                      if (_activa!) {
                        _etiqueta = "Activa ";
                        _stZona = bitSet(_stZona, 0);
                      } else {
                        _etiqueta = "Anulada ";
                        _stZona = bitClear(_stZona, 0);
                      }
                      widget.setStZona(_stZona);
                    });

                    // This is called when the user toggles the switch.
                  })
            ])),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              Text("Excluida "),
              Switch(
                  // This bool value toggles the switch.
                  value: _excluida!,
                  onChanged: (bool value) {
                    setState(() {
                      _excluida = value;
                      if (_excluida!) {
                        _stZona = bitSet(_stZona, 1);
                      } else {
                        _stZona = bitClear(_stZona, 1);
                      }
                      widget.setStZona(_stZona);
                    });

                    // This is called when the user toggles the switch.
                  })
            ])),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              Text("Retardo "),
              Switch(
                  // This bool value toggles the switch.
                  value: _retardo!,
                  onChanged: (bool value) {
                    setState(() {
                      _retardo = value;
                      if (_retardo!) {
                        _stZona = bitSet(_stZona, 2);
                      } else {
                        _stZona = bitClear(_stZona, 2);
                      }
                      widget.setStZona(_stZona);
                    });

                    // This is called when the user toggles the switch.
                  })
            ])),
        Card(
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
                  child: Row(children: [
                    Text("Etiqueta Zona",
                        style: Theme.of(context).textTheme.headlineSmall),
                  ])),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 250,
                    child: TextField(
                      controller: _etiquetaZona,
                      //obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Etiqueta',
                      ),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: dataRequest
                        ? CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await dataGet01(
                                            'ControladorEE', 'readLavelZona', {
                                          "IdControl": widget.idControl,
                                          "IdZona": widget.idZona
                                        });
                                        // await dataPos();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text('leer'),
                                      ),
                                    )),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_etiquetaZona.text != '')
                                      await dataGet01(
                                          'ControladorEE', 'saveLavelZona', {
                                        "IdControl": widget.idControl,
                                        "IdZona": widget.idZona,
                                        "Lavel": _etiquetaZona.text
                                      });
                                    // await dataPos();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text('guardar'),
                                  ),
                                )
                              ]),
                  )),
            ])),
      ]),
    );
  }

  Future<void> dataGet01(String comando, String tipo, dynamic data) async {
    // final sesionViewModel = context.read<SesionViewModel>();
    ApiClient apiClient = ApiClient();
    DataApi? answer;
    //String url = "/frontend/Service.php";
    String url = "/webService";
    DataApi request =
        DataApi(comando: comando, tipo: tipo, status: "Request", data: data);
    setState(() {
      dataRequest = true;
    });

    answer = await apiClient.getApi01(url: url, request: request);

    if (answer!.status == "Success") {
      fcComando(answer);
      textRead = '${answer.data}';
      print('${answer.data}');
    } else {
      print("Fallo data");
    }
    setState(() {
      dataRequest = false;
    });
  }

  void fcComando(DataApi answer) {
    switch (answer.tipo) {
      case 'readLavelZona':
        textRead = '${answer.data}';
        _etiquetaZona.text = answer.data["Lavel"];
        break;

      default:
        textRead = '${answer.data}';
        print('choose a different number!');
    }
  }
}
