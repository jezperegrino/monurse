import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';


class HomePage extends StatelessWidget {
  final ReownAppKitModal appKitModal;
  final BuildContext context;

  const HomePage({required this.appKitModal, required this.context, super.key});
  // const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caregiver Network'),
      ),
      body: Column(
        children: [
          // AppKitModalNetworkSelectButton(appKit: appKitModal),
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Connect Skills',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Caregiver List
          Expanded(
            child: ListView(
              children: [
                PatientRequestCard(
                  name: "Juan Pérez",
                  sex: true, // Male
                  age: 72,
                  specialCare: false,
                  entryTime: "9:00 AM",
                  departureTime: "5:00 PM",
                  offers: 45.50,
                  city: "Guadalajara, México",
                  requiresBathCleaning: false,
                ),
                PatientRequestCard(
                  name: "María González",
                  sex: false, // Female
                  age: 68,
                  specialCare: true,
                  entryTime: "8:30 AM",
                  departureTime: "4:30 PM",
                  offers: 72.00,
                  city: "CDMX, México",
                  requiresBathCleaning: true, // Likely needed due to special care
                ),
                PatientRequestCard(
                  name: "Carlos Rodríguez",
                  sex: true, // Male
                  age: 79,
                  specialCare: false,
                  entryTime: "10:00 AM",
                  departureTime: "6:00 PM",
                  offers: 30.75,
                  city: "Córdoba, México",
                  requiresBathCleaning: false,
                ),
                PatientRequestCard(
                  name: "Ana López",
                  sex: false, // Female
                  age: 65,
                  specialCare: true,
                  entryTime: "7:00 AM",
                  departureTime: "3:00 PM",
                  offers: 85.25,
                  city: "Querétaro, México",
                  requiresBathCleaning: true, // Likely needed due to special care
                ),
                PatientRequestCard(
                  name: "José Martínez",
                  sex: true, // Male
                  age: 74,
                  specialCare: false,
                  entryTime: "9:30 AM",
                  departureTime: "5:30 PM",
                  offers: 60.00,
                  city: "CDMX, México",
                  requiresBathCleaning: false,
                ),
                PatientRequestCard(
                  name: "Lucía Hernández",
                  sex: false, // Female
                  age: 82,
                  specialCare: true,
                  entryTime: "8:00 AM",
                  departureTime: "4:00 PM",
                  offers: 95.50,
                  city: "Cancún, México",
                  requiresBathCleaning: true, // Likely needed due to special care and age
                ),
                PatientRequestCard(
                  name: "Pedro Sánchez",
                  sex: true, // Male
                  age: 67,
                  specialCare: false,
                  entryTime: "10:30 AM",
                  departureTime: "6:30 PM",
                  offers: 15.00,
                  city: "Puebla, México",
                  requiresBathCleaning: false,
                ),
                PatientRequestCard(
                  name: "Sofía Díaz",
                  sex: false, // Female
                  age: 70,
                  specialCare: true,
                  entryTime: "7:30 AM",
                  departureTime: "3:30 PM",
                  offers: 88.75,
                  city: "Zacatecas, México",
                  requiresBathCleaning: true, // Likely needed due to special care
                ),
                PatientRequestCard(
                  name: "Miguel Torres",
                  sex: true, // Male
                  age: 76,
                  specialCare: false,
                  entryTime: "9:00 AM",
                  departureTime: "5:00 PM",
                  offers: 25.30,
                  city: "Monterrey, México",
                  requiresBathCleaning: false,
                ),
                PatientRequestCard(
                  name: "Isabela Rivera",
                  sex: false, // Female
                  age: 22, // Young person with disability
                  specialCare: true, // Requires special care due to disability
                  entryTime: "8:00 AM",
                  departureTime: "4:00 PM",
                  offers: 100.00,
                  city: "Tijuana, México",
                  requiresBathCleaning: true, // Likely needed due to disability
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CaregiverCard extends StatelessWidget {
  final String name;
  final List<String> skills;
  final double rating;
  final String imageUrl;

  CaregiverCard({
    required this.name,
    required this.skills,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: skills.map((skill) => Text(skill)).toList(),
        ),
        trailing: Text('$rating/5.0'),
      ),
    );
  }
}



class PatientRequestCard extends StatefulWidget {
  final String name;
  final bool sex; // True for Male, False for Female
  final int age;
  final bool specialCare; // True if special care is required
  final String entryTime; // Expected entry time of the caregiver
  final String departureTime; // Expected departure time of the caregiver
  final double offers; // Amount offered in MON
  final String city; // City of the patient
  final bool requiresBathCleaning; // True if bath/cleaning assistance is needed

  const PatientRequestCard({
    required this.name,
    required this.sex,
    required this.age,
    required this.specialCare,
    required this.entryTime,
    required this.departureTime,
    required this.offers,
    required this.city,
    required this.requiresBathCleaning,
  });

  @override
  _PatientRequestCardState createState() => _PatientRequestCardState();
}

class _PatientRequestCardState extends State<PatientRequestCard> {
  bool _isInterested = false; // State to track button click


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFd9e8eb), // Set card background color
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        // leading: Icon(
        //   Icons.account_circle, // Profile icon
        //   size: 40,
        //   color: Color(0xFF8fb9ad),
        // ),
        title: Text(
          widget.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Edad: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.age}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Sexo: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.sex ? 'Hombre' : 'Mujer'}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Requiere cuidado especial: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.specialCare ? 'Sí' : 'No'}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Entrada: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.entryTime}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Salida: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.departureTime}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Oferta: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.offers.toStringAsFixed(2)} MON',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Ciudad: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.city}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Requiere baño/limpieza: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.requiresBathCleaning ? 'Sí' : 'No'}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            setState(() {
              _isInterested = !_isInterested; // Toggle interest state
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _isInterested ? Color(0xFF4CAF50) : Color(0xFF8fb9ad), // Green when interested
            minimumSize: Size(100, 40), // Adjust size as needed
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Me interesa',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

