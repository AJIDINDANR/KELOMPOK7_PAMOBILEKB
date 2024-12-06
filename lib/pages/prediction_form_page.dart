import 'package:flutter/material.dart';
import 'result_page.dart';

class PredictionFormPage extends StatefulWidget {
  final Function(List<String>) onFormSubmit; // Callback for form submission

  PredictionFormPage({required this.onFormSubmit});

  @override
  _PredictionFormPageState createState() => _PredictionFormPageState();
}

class _PredictionFormPageState extends State<PredictionFormPage> {
  final List<String> attributes = [
    "Umur",
    "Gender",
    "Tinggi Badan (cm)",
    "Berat Badan (kg)",
    "Body Fat (%)",
    "Diastolic",
    "Systolic",
    "Grip Force",
    "Sit and Bend Forward (cm)",
    "Sit-Ups Count",
    "Broad Jump (cm)",
  ];

  final List<TextEditingController> controllers = List.generate(
    11,
    (index) => TextEditingController(),
  );

  // Variabel untuk menyimpan jenis kelamin yang dipilih
  String gender = 'Laki-laki';

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<String> getFormData() {
    return controllers.map((controller) => controller.text).toList()..insert(1, gender); // Menambahkan gender ke dalam form data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Prediksi"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[50]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: attributes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attributes[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[800],
                      ),
                    ),
                    SizedBox(height: 5),
                    // Jika index adalah untuk gender, tampilkan RadioButton
                    if (index == 1)
                      Column(
                        children: <Widget>[
                          RadioListTile<String>(
                            title: Text("Laki-laki"),
                            value: 'Laki-laki',
                            groupValue: gender,
                            onChanged: (String? value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: Text("Perempuan"),
                            value: 'Perempuan',
                            groupValue: gender,
                            onChanged: (String? value) {
                              setState(() {
                                gender = value!;
                              });
                            },
                          ),
                        ],
                      )
                    else
                      TextField(
                        controller: controllers[index],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          filled: true,
                          fillColor: Colors.teal[50],
                          hintText: "Masukkan ${attributes[index]}",
                          hintStyle: TextStyle(color: Colors.teal[300]),
                        ),
                        keyboardType:
                            index == 1 ? TextInputType.text : TextInputType.number,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          List<String> formData = getFormData();
          widget.onFormSubmit(formData);  // Pass form data to the callback

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PredictionScreen(formData: formData),
            ),
          );
        },
        label: Text("Kirim"),
        icon: Icon(Icons.send),
        backgroundColor: Colors.teal,
      ),
    );
  }
}