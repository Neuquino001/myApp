import 'package:flutter/material.dart';
//import 'package:smartmetersystem/app/common/dimens/app_dimens.dart';
import 'package:cpuesp32/api_dio/client.dart';
import 'package:cpuesp32/api_dio/model01.dart';
import 'package:cpuesp32/constants.dart';
import './comunes.dart';
import '../screens/widgets/Item_controlador.dart';

class ScreenCpu extends StatefulWidget {
  const ScreenCpu({Key? key}) : super(key: key);

  @override
  _ScreenCpu createState() => _ScreenCpu();
}

class _ScreenCpu extends State<ScreenCpu> {
  //final _email = TextEditingController();
  //final _password = TextEditingController();
  //bool passwordVisibility = true;
  //String setupWifiSta = "data";
  List<dynamic>? _lisStControlador;
  List<dynamic>? _editLisStControlador;
  String _vercionCpu = "data";
  String _stControlador = "data";
  // String textSeve = "null";
  String textRead = "null";
  bool dataRequest = false;
  bool statuSave = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final sesionViewModel = context.read<SesionViewModel>();
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
          padding: const EdgeInsets.all(10),
          child: Text("Cpu", style: Theme.of(context).textTheme.headlineSmall)),
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
                'Version Cpu',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10), child: Text(_vercionCpu)),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: dataRequest
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            await dataGet01('CpuSD', 'VersionCpu', 'data');
                            // await dataPos();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text('leer'),
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
                'Status Controladores',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            //  Padding(
            //      padding: const EdgeInsets.all(10), child: Text(_stControlador)),
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
                                            'CpuSD', 'StControlCpu', 'data');
                                        // await dataPos();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text('leer'),
                                      ),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await dataGet01(
                                            'CpuSD', 'SaveStControlCpu', {
                                          "StControlCpu": _editLisStControlador
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text('guardar'),
                                      ),
                                    ))
                              ]))),
          ])),
      // ItemControlador(
      //   data: 1,
      //   id: 3,
      // ),
      Card(
          margin: EdgeInsets.all(10),
          color: Theme.of(context).canvasColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: primaryColor.withOpacity(0.8), width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListStControl(
                listStControl: _lisStControlador,
                itemSelec: (iten) {
                  _editLisStControlador![iten.id!] = iten.itemData;
                },
              ))),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(textRead),
      )
    ]));
  }

/*
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
*/
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

/*
  Future<void> dataGet02(String comando, String tipo, String data) async {
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
      //textRead = '${answer.data}';
      print('${answer.data}');
    } else {
      print("Fallo data");
    }
    setState(() {
      dataRequest = false;
    });
  }
*/
  void fcComando(DataApi answer) {
    switch (answer.tipo) {
      case 'VersionCpu':
        _vercionCpu = '${answer.data}';
        break;
      case 'StControlCpu':
        _stControlador = '${answer.data["StControlCpu"]}';
        _lisStControlador = answer.data["StControlCpu"];
        _editLisStControlador = _lisStControlador;
        break;
      default:
        print('choose a different number!');
    }
  }
/*
  Future<void> dataGet03(String comando, String tipo, String data) async {
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

    //answer = await apiClient.getApi01(url: url, request: request);
    String dataString = await apiClient.getApi02(url: url, request: request);
    textRead = dataString;
    setState(() {
      dataRequest = false;
    });
  }
 */
}

class ListStControl extends StatelessWidget {
  const ListStControl({
    Key? key,
    this.listStControl,
    required this.itemSelec,
  }) : super(key: key);
  final Function(Item) itemSelec;
  final List<dynamic>? listStControl;
  @override
  Widget build(BuildContext context) {
    if (listStControl == null)
      return Text("Status Controladores");
    else
      return ListView.builder(
        primary: false,
        itemBuilder: (BuildContext context, int index) => ItemControlador(
          data: listStControl![index],
          id: index + 1,
          setStControl: (itemdata) {
            Item _item = Item();
            _item.id = index;
            _item.itemData = itemdata;
            itemSelec(_item);
          },
        ),
        // new ItemMedidor(medidor: listMedidor[index], itemSelec: itemSelec),
        itemCount: listStControl!.length,
        shrinkWrap: true,
      );
  }
}
