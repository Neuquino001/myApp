import 'package:cpuesp32/dropdown_button2.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ScreenConfiguracion extends StatefulWidget {
  const ScreenConfiguracion({Key? key}) : super(key: key);

  @override
  State<ScreenConfiguracion> createState() => _ScreenConfiguracion();
}

class _ScreenConfiguracion extends State<ScreenConfiguracion> {
  final TextEditingController _etiqueta = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  final TextEditingController _tiempoAckController = TextEditingController();
  final TextEditingController _tiempoRetController = TextEditingController();
  final TextEditingController _tiempoSirController = TextEditingController();
  bool dataRequest = false;

  final List<String> opciones = [
    'Activada',
    'Anulada',
    'Incluida',
    'Excluida',
  ];

  String _selectedOption = 'Activada';

  void _leerValores() {
    String tiempoAck = _tiempoAckController.text;
    String tiempoRet = _tiempoRetController.text;
    String tiempoSir = _tiempoSirController.text;

    print(
        'TiempoAck: $tiempoAck, TiempoRet: $tiempoRet, TiempoSir: $tiempoSir');
  }

  void _guardarValores() {
    // Implementa aquí la lógica para guardar los valores
  }

  // Widget _buildFloatingActionButton() {
  //   return Column(
  //     // mainAxisAlignment: MainAxisAlignment.end,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       FloatingActionButton(
  //         onPressed: _leerValores,
  //         tooltip: 'Leer',
  //         child: Icon(Icons.read_more),
  //       ),
  //       SizedBox(height: 16.0),
  //       FloatingActionButton(
  //         onPressed: _guardarValores,
  //         tooltip: 'Guardar',
  //         child: Icon(Icons.save),
  //       ),
  //     ],
  //   );
  // }

  @override
  void initState() {
    // _id.text = "1";
    // _idZona.text = "1";
    super.initState();
  }

  Widget build(BuildContext context) {
    // final sesionViewModel = context.read<SesionViewModel>();
    return Scaffold(
        backgroundColor: Color(0xffdbdbdb),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text("Configuracion",
                        style: Theme.of(context).textTheme.headlineSmall)),
                Card(
                  margin: EdgeInsets.all(10),
                  color: Theme.of(context).canvasColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: primaryColor.withOpacity(0.8), width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'Ingrese Zona',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 50),
                            Text(
                              'Estado de Zona',
                              style: TextStyle(fontSize: 16),
                            ),
                            // Expanded(
                            //   child: Container(
                            //     width: 140,
                            //     height: 50,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(14),
                            //       border: Border.all(
                            //         color: Colors.black26,
                            //       ),
                            //       color: Colors.white,
                            //     ),
                            //     child: TextField(
                            //       controller: _numeroController,
                            //       keyboardType: TextInputType.number,
                            //       maxLength: 3,
                            //       decoration: InputDecoration(
                            //         hintText: 'zona',
                            //         contentPadding:
                            //             EdgeInsets.symmetric(horizontal: 10),
                            //         border: InputBorder.none,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.black26,
                                ),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: _numeroController,
                                keyboardType: TextInputType.number,
                                maxLength: 3,
                                decoration: InputDecoration(
                                  hintText: 'zona',
                                  // labelText: 'zona',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  border: InputBorder.none,
                                  // border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            // Text(
                            //   'Estado de Zona',
                            //   style: TextStyle(fontSize: 16),
                            // ),
                            SizedBox(width: 38),
                            SizedBox(height: 16.0),
                            Expanded(
                              child: Container(
                                width: 140,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                  color: Colors.white,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: const Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Estado',
                                            style: TextStyle(
                                              fontSize: 16,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: opciones
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  // fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: _selectedOption,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedOption = newValue!;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 140,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        color: Colors.white,
                                      ),
                                      elevation: 2,
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                      iconSize: 30,
                                      iconEnabledColor: Colors.black,
                                      iconDisabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.white,
                                      ),
                                      offset: const Offset(0, 0),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
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
                              ))
                        ]),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: dataRequest
                                ? CircularProgressIndicator()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width:
                                                120, // Ajusta el ancho del botón
                                            height:
                                                40, // Ajusta la altura del botón
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.lightBlue,
                                                  foregroundColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              onPressed: () async {
                                                // Lógica de tu botón
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text('Leer'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.lightBlue,
                                              foregroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () async {
                                            // if (_etiqueta.text != '')
                                            //   await dataGet01(
                                            //       'ControladorEE', 'saveLavelControl', {
                                            //     "Id": int.parse(_id.text),
                                            //     "Lavel": _etiqueta.text
                                            //   });
                                            // await dataPos();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text('guardar'),
                                          ),
                                        )
                                      ]),
                          )),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  color: Theme.of(context).canvasColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: primaryColor.withOpacity(0.8), width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'TiempoAck',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 120),
                            Expanded(
                              child: Container(
                                width: 140,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: _tiempoAckController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                  decoration: InputDecoration(
                                    hintText: 'Min.',
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'TiempoRet',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 123),
                            Expanded(
                              child: Container(
                                width: 140,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: _tiempoRetController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                  decoration: InputDecoration(
                                    hintText: 'Min.',
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'TiempoSir',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 125),
                            Expanded(
                              child: Container(
                                width: 140,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: _tiempoSirController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                  decoration: InputDecoration(
                                    hintText: 'Min.',
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: dataRequest
                                ? CircularProgressIndicator()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width:
                                                120, // Ajusta el ancho del botón
                                            height:
                                                40, // Ajusta la altura del botón
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.lightBlue,
                                                  foregroundColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              onPressed: () async {
                                                // Lógica de tu botón
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text('Leer'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.lightBlue,
                                              foregroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () async {
                                            // if (_etiqueta.text != '')
                                            //   await dataGet01(
                                            //       'ControladorEE', 'saveLavelControl', {
                                            //     "Id": int.parse(_id.text),
                                            //     "Lavel": _etiqueta.text
                                            //   });
                                            // await dataPos();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text('guardar'),
                                          ),
                                        )
                                      ]),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
