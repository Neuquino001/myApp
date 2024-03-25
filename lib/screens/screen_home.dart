import 'package:flutter/material.dart';
//import 'package:smartmetersystem/app/common/dimens/app_dimens.dart';
import 'package:cpuesp32/api_dio/client.dart';
import 'package:cpuesp32/api_dio/model01.dart';
import 'package:cpuesp32/constants.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _ScreenHome createState() => _ScreenHome();
}

class _ScreenHome extends State<ScreenHome> {
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
              Text("Home", style: Theme.of(context).textTheme.headlineSmall)),
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
                'Setup Wifi Sta',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _email,
                    //obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'SSID',
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 250,
                  child: TextField(
                    controller: _password,
                    obscureText: passwordVisibility,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => passwordVisibility = !passwordVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            passwordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        )),
                  ),
                )),
            //Padding(padding: const EdgeInsets.all(10), child: Text(setupWifiSta)),
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
                                          'WifiCpu', 'SetupWifiSta', 'data');
                                      // await dataPos();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text('leer'),
                                    ),
                                  )),
                              ElevatedButton(
                                onPressed: () async {
                                  if ((_email.text != '') &&
                                      (_password.text != ''))
                                    await dataGet01('WifiCpu', 'UpdateSta', {
                                      "SSID": _email.text,
                                      "Password": _password.text
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
                'Status Wifi Sta',
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
                            await dataGet01('WifiCpu', 'StatusWifiSta', 'data');
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
                'Setup Wifi Ap',
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
                            await dataGet01('WifiCpu', 'SetupWifiAp', 'data');
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

  void fcComando(DataApi answer) {
    switch (answer.tipo) {
      case 'SetupWifiSta':
        _email.text = answer.data["SSID"];
        _password.text = answer.data["Password"];
        setupWifiSta = '${answer.data}';

        break; // The switch statement must be told to exit, or it will execute every case.
      case 'StatusWifiSta':
        statusWifiSta = '${answer.data}';
        break;
      case 'SetupWifiAp':
        setupWifiAp = '${answer.data}';
        break;
      default:
        print('choose a different number!');
    }
  }

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
    /*   if (answer!.status == "Success") {
      textRead = '${answer.data}';
      print('${answer.data}');
    } else {
      print("Fallo data");
    }
    setState(() {
      dataRequest = false;
    });*/
  }
}
