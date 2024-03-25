import 'package:cpuesp32/screens/widgets/item_zona.dart';
import 'package:cpuesp32/screens/widgets/salidas.dart';
import 'package:flutter/material.dart';
//import 'package:smartmetersystem/app/common/dimens/app_dimens.dart';
import 'package:cpuesp32/api_dio/client.dart';
import 'package:cpuesp32/api_dio/model01.dart';
import 'package:cpuesp32/constants.dart';
import 'comunes.dart';
//import '../screens/widgets/Item_zona.dart';

class ScreenControlador extends StatefulWidget {
  const ScreenControlador({Key? key}) : super(key: key);

  @override
  _ScreenControlador createState() => _ScreenControlador();
}

class _ScreenControlador extends State<ScreenControlador> {
  final _etiqueta = TextEditingController();
  final _id = TextEditingController();
  final _etiquetaZona = TextEditingController();
  final _idZona = TextEditingController();
  List<dynamic>? _listSalidasZonas;
  List<dynamic>? _editListSalidasZonas;
  String textSeve = "null";
  String textRead = "null";
  bool dataRequest = false;
  bool statuSave = false;
  @override
  void initState() {
    _id.text = "1";
    _idZona.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final sesionViewModel = context.read<SesionViewModel>();
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            Text("Controlador",
                style: Theme.of(context).textTheme.headlineSmall),
            Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 75,
                  child: TextField(
                    controller: _id,
                    keyboardType: TextInputType.number,
                    //obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Id',
                    ),
                  ),
                )),
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
              child: Text(
                'Editar Etiqueta',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _etiqueta,
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
                                          'ControladorEE',
                                          'readLavelControl',
                                          {"Id": int.parse(_id.text)});
                                      // await dataPos();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text('leer'),
                                    ),
                                  )),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_etiqueta.text != '')
                                    await dataGet01(
                                        'ControladorEE', 'saveLavelControl', {
                                      "Id": int.parse(_id.text),
                                      "Lavel": _etiqueta.text
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
              child: Text(
                'Controlador SDEE',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
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
                                          'ControladorEE',
                                          'ReadControlSDEE',
                                          {"Id": int.parse(_id.text)});
                                      // await dataPos();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text('leer'),
                                    ),
                                  )),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_editListSalidasZonas != null)
                                    await dataGet01(
                                        'ControladorEE', 'SaveControlSDEE', {
                                      "Id": int.parse(_id.text),
                                      "ControlSDEE": _editListSalidasZonas
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
      /*  ItemZona(
        idControl: int.parse(_id.text),
        data: 1,
        idZona: 3,
      ),*/
      //Salidas(data: 17),

      ListSalidasZonas(
        idControl: int.parse(_id.text),
        itemStControl: (item) {
          _editListSalidasZonas![item.id!] = item.itemData;
        },
        listStControl: _listSalidasZonas,
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(textRead),
      )
    ]));
  }

  Future<void> dataPos01(String comando, String tipo, String data) async {
    //  final sesionViewModel = context.read<SesionViewModel>();
    ApiClient apiClient = ApiClient();
    DataApi? answer;
    String url = "/webService";
    DataApi request =
        DataApi(comando: comando, tipo: tipo, status: "Request", data: data);
    setState(() {
      dataRequest = true;
    });

    answer = await apiClient.postApi01(url: url, request: request);

    if (answer!.status == "Success") {
      textRead = '${answer.data}';
      // sesionViewModel.setToken('${answer.data["tokenSesion"]}');

      print('${answer.data}');
    } else {
      print("Fallo login");
    }
    setState(() {
      dataRequest = false;
    });
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
      case 'readLavelControl':
        textRead = '${answer.data}';
        _etiqueta.text = answer.data["Lavel"];
        break;
      case 'ReadControlSDEE':
        textRead = '${answer.data["ControlSDEE"]}';
        _listSalidasZonas = answer.data["ControlSDEE"];
        _editListSalidasZonas = _listSalidasZonas;
        break;
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

class ListSalidasZonas extends StatelessWidget {
  const ListSalidasZonas({
    Key? key,
    required this.idControl,
    this.listStControl,
    required this.itemStControl,
  }) : super(key: key);
  final int idControl;
  final Function(Item) itemStControl;
  final List<dynamic>? listStControl;
  @override
  Widget build(BuildContext context) {
    if (listStControl == null)
      return Text("Status Controladores");
    else
      return Column(children: [
        Salidas(
            data: listStControl![0],
            salida: (itemdata) {
              Item _itemdata = Item();
              _itemdata.id = 0;
              _itemdata.itemData = itemdata;
              itemStControl(_itemdata);
            }),
        ListView.builder(
          primary: false,
          itemBuilder: (BuildContext context, int index) => ItemZona(
            data: listStControl![index + 1],
            idZona: index + 1,
            idControl: idControl,
            setStZona: (itemdata) {
              Item _itemdata = Item();
              _itemdata.id = index + 1;
              _itemdata.itemData = itemdata;
              itemStControl(_itemdata);
            },
          ),
          // new ItemMedidor(medidor: listMedidor[index], itemSelec: itemSelec),
          itemCount: listStControl!.length - 1,
          shrinkWrap: true,
        )
      ]);
  }
}
