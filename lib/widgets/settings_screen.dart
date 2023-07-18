import 'package:flutter/material.dart';
import 'package:profinder_app/utils/my_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String dropValue = 'Español';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text(
          'Configuración',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: MyColors.secondary),
        ),
        backgroundColor: MyColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ListTile(
              trailing: Padding(
                padding: EdgeInsets.only(right: 16),
                child: Text(
                  '0.6.0',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
              title: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Version',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const Divider(),
            ListTile(
              trailing: Container(
                width: 100,
                height: 40,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    iconSize: 40,
                    isExpanded: true,
                    isDense: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'Español',
                        child: Text('Español'),
                      ),
                    ],
                    value: dropValue,
                    onChanged: (value) {
                      setState(() {
                        dropValue = value!;
                        print(dropValue);
                      });
                    },
                  ),
                ),
              ),
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Idioma',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const Divider(),
            ListTile(
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 550),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  const Text(
                                    'Política de Privacidad',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Text(''),
                                  const Text(
                                      'Gracias por usar la aplicación Profinder ("Profinder", "la Aplicación"). Al acceder a nuestra Aplicación, aceptas cumplir con los siguientes términos de nuestra Política de Privacidad, que constituyen un acuerdo legal entre tú y Profinder. Si no aceptas estos términos, no debes utilizar la Aplicación. Profinder se reserva el derecho de modificar esta Política de Privacidad sin previo aviso, y cada uso de la Aplicación implica tu aceptación a cumplir con los términos establecidos en la Política de Privacidad tal como se hayan modificado en el momento de dicho uso.'),
                                  const Text(''),
                                  const Text(
                                      'La información o materiales presentados en la Aplicación no deberán ser utilizados o interpretados como una oferta de venta, o una solicitud de una oferta de compra, de cualquier tipo de servicios. Además, ninguna información o material contenido en la Aplicación debe ser interpretado o utilizado como asesoramiento de inversión, legal, contable, fiscal o de otro tipo en conexión con cualquier oferta o venta de servicios. Profinder no tratará a los usuarios de la Aplicación como socios, clientes, o inversores por el hecho de que accedan a la Aplicación.'),
                                  const Text(''),
                                  const Text(
                                      'La Aplicación puede contener declaraciones de futuro, que reflejan las opiniones actuales de Profinder con respecto a, entre otras cosas, las operaciones y el rendimiento de la Aplicación. Puedes identificar estas declaraciones de futuro por el uso de palabras como "anticipar", "aproximadamente", "creer", "continuar", "estimar", "esperar", "intentar", "puede", "perspectiva", "plan", "potencial", "predecir", "buscar", "debería", o "voluntad", o la versión negativa de estas palabras u otras palabras comparables. Las declaraciones de futuro están sujetas a diversos riesgos e incertidumbres. En consecuencia, existen o habrá factores importantes que podrían hacer que los resultados o desenlaces reales difieran sustancialmente de los indicados en estas declaraciones. Profinder no asume ninguna obligación de actualizar o revisar públicamente ninguna declaración de futuro, ya sea como resultado de nueva información, desarrollos futuros o de otro tipo. '),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.arrow_outward,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Politica de privacidad',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const Divider(),
            ListTile(
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Container(
                          constraints: const BoxConstraints(
                              maxHeight: 550, maxWidth: 500),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: MyColors.primary),
                                      child: const Icon(
                                        Icons.support_agent,
                                        color: MyColors.secondary,
                                        size: 120,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Necesitas Ayuda? Contactanos!',
                                      style: TextStyle(
                                        color: MyColors.primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const ListTile(
                                    minLeadingWidth: 5,
                                    title: Text('Soporte@Profinder.com'),
                                    leading: Icon(Icons.email),
                                  ),
                                  const ListTile(
                                    minLeadingWidth: 5,
                                    title: Text('01-8000-311'),
                                    leading: Icon(Icons.phone),
                                  ),
                                  const ListTile(
                                    minLeadingWidth: 5,
                                    title: Text('www.Profinder.com'),
                                    leading: Icon(Icons.travel_explore),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.arrow_outward,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Soporte',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
