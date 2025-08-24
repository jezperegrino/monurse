import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'proposal_form_screen.dart';
import '../models/appkit_global.dart';


class LikesPage extends StatelessWidget {
  final ReownAppKitModal appKitModal;
  final BuildContext context;
  final String? userRole;

  const LikesPage({
    required this.appKitModal,
    required this.context,
    required this.userRole,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userRole == 'Care Seeker' ? 'Mi paciente' : 'Mis solicitudes',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: userRole == 'Care Seeker'
                ? Center(
                    child: Text('Solicitud de mi paciente.'),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Table(
                      border: TableBorder.all(color: Colors.grey),
                      columnWidths: {
                        0: FlexColumnWidth(2), // Name column wider
                        1: FlexColumnWidth(3), // Status column wider to accommodate button
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Nombre',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Pagado',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Juan Pérez'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Sí'),
                                      SizedBox(width: 10),
                                      AppKitModalBalanceButton(
                                        appKitModal: AppKitGlobal.appKitModal!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('María González'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Pendiente'),
                                      SizedBox(width: 10),
                                      AppKitModalBalanceButton(
                                        appKitModal: AppKitGlobal.appKitModal!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Carlos Rodríguez'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Sí'),
                                      SizedBox(width: 10),
                                      AppKitModalBalanceButton(
                                        appKitModal: AppKitGlobal.appKitModal!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
          if (userRole == 'Care Seeker')
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProposalFormScreen(
                        onSave: (formData) {
                          Navigator.pop(context); // Close the form
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8fb9ad),
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Crear propuesta',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
