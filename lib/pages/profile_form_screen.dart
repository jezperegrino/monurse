import 'package:flutter/material.dart';

class ProfileFormScreen extends StatefulWidget {
  final String userRole;
  final Function(Map<String, dynamic>) onSave;

  const ProfileFormScreen({required this.userRole, required this.onSave});

  @override
  _ProfileFormScreenState createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name, city;
  late bool professionalLicense, sex;
  late int age;
  late String telephoneNumber, country;

  @override
  void initState() {
    super.initState();
    // Initialize with default values
    name = '';
    city = '';
    professionalLicense = false;
    sex = true; // Default to Male
    age = 0;
    telephoneNumber = '';
    country = '';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final formData = <String, dynamic>{};
      if (widget.userRole == 'Care Provider') {
        formData.addAll({
          'name': name,
          'professionalLicense': professionalLicense,
          'age': age,
          'sex': sex,
          'telephoneNumber': telephoneNumber,
          'country': country,
          'city': city,
          'registrationTime': DateTime.now().millisecondsSinceEpoch, // Simulated
        });
      } else if (widget.userRole == 'Care Seeker') {
        formData.addAll({
          'name': name,
          'city': city,
        });
      }
      widget.onSave(formData);
      Navigator.pop(context); // Close the form
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Ingrese un nombre' : null,
                onSaved: (value) => name = value!,
              ),
              if (widget.userRole == 'Care Provider')
                Column(
                  children: [
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
                    CheckboxListTile(
                      title: Text('Licencia Profesional'),
                      value: professionalLicense,
                      onChanged: (value) => setState(() => professionalLicense = value!),
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
                  ],
                ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ciudad'),
                validator: (value) => value!.isEmpty ? 'Ingrese una ciudad' : null,
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