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
          'Configuracion',
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
              trailing: Padding(padding: EdgeInsets.only(right: 16), child: Text(
                '0.6.0',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),),
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
                          child: const SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(''),
                                  Text(
                                      'Thank you for visiting the website of Placeholder Management LLC ("Placeholder Management LLC", the “Firm”). By accessing this website (the “Site”), you agree to accept the following Terms of Use for the use of the Site, which constitute a legal agreement between you and Placeholder Management LLC. If you do not accept these Terms of Use, you may not use the Site. Placeholder Management LLC reserves the right to modify these Terms of Use without notice, and each use of the Site constitutes your acceptance to be bound by the terms set forth in the Terms of Use as modified at the time of such use.'),
                                  Text(''),
                                  Text(
                                      'Under no circumstances should any information or materials presented on the Site be used or construed as an offer to sell, or a solicitation of an offer to buy, any securities, financial instruments, investments or other services. Furthermore, no information or materials contained in the Site should be construed or relied upon as investment, legal, accounting, tax or other professional advice or in connection with any offer or sale of securities. Placeholder Management LLC will not treat users of the Site as partners, clients, customers or investors by virtue of their accessing the Site. '),
                                  Text(''),
                                  Text(
                                      'The Site may contain forward-looking statements, which reflect Placeholder Management LLC’s current views with respect to, among other things, the operations and performance of the Firm. You can identify these forward-looking statements by the use of words such as “anticipate” “approximately,” “believe,” “continue,” “estimate,” “”expect,” “intend,” “may,” “outlook,” “plan,” “potential,” “predict,” “seek,” “should,” or “will,” or the negative version of these words or other comparable words. Forward-looking statements are subject to various risks and uncertainties. Accordingly, there are or will be important factors that could cause actual outcomes or results to differ materially from those indicated in these statements. Placeholder Management LLC undertakes no obligation to publicly update or review any forward-looking statement, whether as a result of new information, future developments or otherwise. '),
                                  Text(''),
                                  Text(
                                      'The Site may contain forward-looking statements, which reflect Placeholder Management LLC’s current views with respect to, among other things, the operations and performance of the Firm. You can identify these forward-looking statements by the use of words such as “anticipate” “approximately,” “believe,” “continue,” “estimate,” “”expect,” “intend,” “may,” “outlook,” “plan,” “potential,” “predict,” “seek,” “should,” or “will,” or the negative version of these words or other comparable words. Forward-looking statements are subject to various risks and uncertainties. Accordingly, there are or will be important factors that could cause actual outcomes or results to differ materially from those indicated in these statements. Placeholder Management LLC undertakes no obligation to publicly update or review any forward-looking statement, whether as a result of new information, future developments or otherwise. '),
                                  Text(''),
                                  Text(
                                      'The Site may contain forward-looking statements, which reflect Placeholder Management LLC’s current views with respect to, among other things, the operations and performance of the Firm. You can identify these forward-looking statements by the use of words such as “anticipate” “approximately,” “believe,” “continue,” “estimate,” “”expect,” “intend,” “may,” “outlook,” “plan,” “potential,” “predict,” “seek,” “should,” or “will,” or the negative version of these words or other comparable words. Forward-looking statements are subject to various risks and uncertainties. Accordingly, there are or will be important factors that could cause actual outcomes or results to differ materially from those indicated in these statements. Placeholder Management LLC undertakes no obligation to publicly update or review any forward-looking statement, whether as a result of new information, future developments or otherwise. '),
                                  Text(''),
                                  Text(
                                      'The Site may contain forward-looking statements, which reflect Placeholder Management LLC’s current views with respect to, among other things, the operations and performance of the Firm. You can identify these forward-looking statements by the use of words such as “anticipate” “approximately,” “believe,” “continue,” “estimate,” “”expect,” “intend,” “may,” “outlook,” “plan,” “potential,” “predict,” “seek,” “should,” or “will,” or the negative version of these words or other comparable words. Forward-looking statements are subject to various risks and uncertainties. Accordingly, there are or will be important factors that could cause actual outcomes or results to differ materially from those indicated in these statements. Placeholder Management LLC undertakes no obligation to publicly update or review any forward-looking statement, whether as a result of new information, future developments or otherwise. '),
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
                          constraints: const BoxConstraints(maxHeight: 550, maxWidth: 500),
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
                                  const SizedBox(height: 8,),
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
