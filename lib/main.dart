import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import './constants.dart';
import './screens/screen_contruction.dart';
import './screens/screen_home.dart';
import './screens/screen_api_states.dart';
import './screens/screen_cpu.dart';
import './screens/screen_modbus.dart';
import './screens/screen_controlador.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  bool get useLightMode {
    switch (_themeMode) {
      case ThemeMode.system:
        return SchedulerBinding.instance.window.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CPU Esp32',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        canvasColor: snowColor,
        primaryColor: secondaryColor,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        canvasColor: secondaryColor,
        primaryColor: snowColor,
      ),
      themeMode: _themeMode,
      home: MyHomePage(
        title: 'CPU Esp32',
        useLightMode: useLightMode,
        handleBrightnessChange: (useLightMode) => setState(() {
          _themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
        }),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.handleBrightnessChange,
    required this.useLightMode,
  });
  final String title;
  final bool useLightMode;
  final void Function(bool useLightMode) handleBrightnessChange;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ScreenHome(),
    ScreenHome(),
    ScreenCpu(),
    ScreenControlador(),
    ScreenContruction(name: "Teclado"),
    ScreenModbus(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            //boton del tema
            _BrightnessButton(
              handleBrightnessChange: widget.handleBrightnessChange,
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text('Configuracion'),
              ),
              ListTile(
                leading: Icon(Icons.wifi),
                title: const Text('Wifi'),
                selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(1);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.computer),
                title: const Text('Cpu'),
                selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(2);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.device_thermostat),
                title: const Text('Controlador'),
                selected: _selectedIndex == 3,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(3);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.keyboard),
                title: const Text('Teclado'),
                selected: _selectedIndex == 4,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(4);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.usb),
                title: const Text('Modbus'),
                selected: _selectedIndex == 4,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(5);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 5, // key: key,
                      child: _widgetOptions[_selectedIndex])
                ]))));
  }
}

class _BrightnessButton extends StatelessWidget {
  const _BrightnessButton({
    required this.handleBrightnessChange,
    this.showTooltipBelow = true,
  });

  final Function handleBrightnessChange;
  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Toggle brightness',
      child: IconButton(
        icon: isBright
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined),
        onPressed: () => handleBrightnessChange(!isBright),
      ),
    );
  }
}
