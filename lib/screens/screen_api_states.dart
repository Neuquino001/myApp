import 'package:flutter/material.dart';
//import 'package:smartmetersystem/app/common/dimens/app_dimens.dart';
import 'package:cpuesp32/api_dio/client.dart';
import 'package:cpuesp32/api_dio/model01.dart';

class ScreenApiStates extends StatefulWidget {
  const ScreenApiStates({Key? key}) : super(key: key);

  @override
  _ScreenApiStates createState() => _ScreenApiStates();
}

class _ScreenApiStates extends State<ScreenApiStates> {
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
    return Column(children: [
      Text("sesionViewModel.token"),
      Center(
        child: ElevatedButton(
          onPressed: () async {
            //   statuSave = await writePref("Todo Bien");
            if (statuSave) {
              setState(() {
                textSeve = "Dato grabado";
              });
            } else {
              setState(() {
                textSeve = "Esperando";
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Save'),
          ),
        ),
      ),
      // Text(textSeve),
      Center(
        child: ElevatedButton(
          onPressed: () async {
            //   textRead = await readPref();
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Read'),
          ),
        ),
      ),
      //Text(textRead),
      Center(
        child: dataRequest
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  await dataPos();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('Login'),
                ),
              ),
      ),
      Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: dataRequest
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      await dataServer();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('DataServer'),
                    ),
                  ),
          )),
      Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: dataRequest
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      // await readGateway();
                      await getReadGateway();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('Gateway'),
                    ),
                  ),
          )),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(textRead),
      )
    ]);
  }

  Future<void> dataPos() async {
    //  final sesionViewModel = context.read<SesionViewModel>();
    ApiClient apiClient = ApiClient();
    DataApi? answer;
    String url = "/usuario/SesionUsuario01.php";
    DataApi request = DataApi(
        comando: "Usuario",
        tipo: "LoginUsuario",
        status: "Request",
        data: {"Password": "cspplot541", "email": "millananco@gmail.com"});
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

  Future<void> dataServer() async {
    // final sesionViewModel = context.read<SesionViewModel>();
    ApiClient apiClient = ApiClient();
    DataApi? answer;
    String url = "/frontend/Service.php";
    DataApi request =
        DataApi(comando: "gateway", tipo: "gateway", status: "Request", data: {
      "function": "GatewayAllRead",
      //    "tokenSesion": sesionViewModel.token
    });
    setState(() {
      dataRequest = true;
    });

    answer = await apiClient.postApi01(url: url, request: request);

    if (answer!.status == "Success") {
      textRead = '${answer.data}';
      print('${answer.data}');
    } else {
      print("Fallo data");
    }
    setState(() {
      dataRequest = false;
    });
  }

  Future<void> readGateway() async {
    // final sesionViewModel = context.read<SesionViewModel>();
    ApiClient apiClient = ApiClient();
    DataApi? answer;
    String url = "/frontend/FlujoToken01.php";
    DataApi request = DataApi(
        comando: "gateway",
        tipo: "GrupoGateway",
        status: "Request",
        data: {
          "function": "GrupoGatewayAllRead",
          //     "tokenSesion": sesionViewModel.token
        });
    setState(() {
      dataRequest = true;
    });

    answer = await apiClient.postApi01(url: url, request: request);

    if (answer!.status == "Success") {
      textRead = '${answer.data}';
      print('${answer.data}');
    } else {
      print("Fallo data");
    }
    setState(() {
      dataRequest = false;
    });
  }

  Future<void> getReadGateway() async {
    // final sesionViewModel = context.read<SesionViewModel>();
    ApiClient apiClient = ApiClient();
    DataApi? answer;
    String url = "/frontend/Service.php";
    DataApi request = DataApi(
        comando: "gateway",
        tipo: "GrupoGateway",
        status: "Request",
        data: {
          "function": "GrupoGatewayAllRead",
          //     "tokenSesion": sesionViewModel.token
        });
    setState(() {
      dataRequest = true;
    });

    answer = await apiClient.getApi01(url: url, request: request);

    if (answer!.status == "Success") {
      textRead = '${answer.data}';
      print('${answer.data}');
    } else {
      print("Fallo data");
    }
    setState(() {
      dataRequest = false;
    });
  }
}
