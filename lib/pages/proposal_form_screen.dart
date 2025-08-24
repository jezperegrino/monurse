import 'package:flutter/material.dart';

class ProposalFormScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const ProposalFormScreen({required this.onSave});

  @override
  _ProposalFormScreenState createState() => _ProposalFormScreenState();
}

class _ProposalFormScreenState extends State<ProposalFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name, city;
  late bool sex;
  late int age;
  late String telephoneNumber, country;

  @override
  void initState() {
    super.initState();
    // Initialize with default values
    name = '';
    city = '';
    sex = true; // Default to Male
    age = 0;
    telephoneNumber = '';
    country = '';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final formData = {
        'name': name,
        'age': age,
        'sex': sex,
        'telephoneNumber': telephoneNumber,
        'country': country,
        'city': city,
        'registrationTime': DateTime.now().millisecondsSinceEpoch, // Simulated
      };
      widget.onSave(formData); // Pass data back to parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Propuesta del paciente'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre del paciente'),
                validator: (value) => value!.isEmpty ? 'Ingrese un nombre' : null,
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty || int.tryParse(value) == null || int.parse(value) <= 0 || int.parse(value) > 150 ? 'Edad inválida' : null,
                onSaved: (value) => age = int.parse(value!),
              ),
              Row(
                children: [
                  Text('Sexo: '),
                  Radio<bool>(
                    value: true,
                    groupValue: sex,
                    onChanged: (value) => setState(() => sex = value!),
                  ),
                  Text('Hombre'),
                  Radio<bool>(
                    value: false,
                    groupValue: sex,
                    onChanged: (value) => setState(() => sex = value!),
                  ),
                  Text('Mujer'),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Número de Teléfono'),
                validator: (value) => value!.isEmpty ? 'Ingrese un número' : null,
                onSaved: (value) => telephoneNumber = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'País'),
                validator: (value) => value!.isEmpty ? 'Ingrese un país' : null,
                onSaved: (value) => country = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ciudad'),
                validator: (value) => value!.isEmpty ? 'Ingrese una ciudad' : null,
                onSaved: (value) => city = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Monto de la Propuesta (MON)'),
                validator: (value) => value!.isEmpty ? 'Ingrese un monto' : null,
                onSaved: (value) => city = value!,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8fb9ad),
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Aceptar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}