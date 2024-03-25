import 'package:flutter/material.dart';
//import 'package:smartmetersystem/app/common/dimens/app_dimens.dart';
import 'package:cpuesp32/api_dio/client.dart';
import 'package:cpuesp32/api_dio/model01.dart';
import 'package:cpuesp32/constants.dart';

class ScreenModbus extends StatefulWidget {
  const ScreenModbus({Key? key}) : super(key: key);

  @override
  _ScreenModbus createState() => _ScreenModbus();
}

class _ScreenModbus extends State<ScreenModbus> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool passwordVisibility = true;
  String setupWifiSta = "data";
  String statusWifiSta = "data";
  String setupWifiAp = "data";
  String textSeve = "null";
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
          child:
              Text("Modbus", style: Theme.of(context).textTheme.headlineSmall)),
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
                padding: const EdgeInsets.all(10), child: Text(statusWifiSta)),
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
            Padding(
                padding: const EdgeInsets.all(10), child: Text(setupWifiAp)),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: dataRequest
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            await dataGet01('CpuSD', 'StControlCpu', 'data');
                            // await dataPos();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text('leer'),
                          ),
                        ),
                )),
          ])),
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
      case 'VersionCpu':
        statusWifiSta = '${answer.data}';
        break;
      case 'StControlCpu':
        setupWifiAp = '${answer.data}';
        break;
      default:
        print('choose a different number!');
    }
  }
}
