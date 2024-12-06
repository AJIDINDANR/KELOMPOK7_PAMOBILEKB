import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabularapp/controller/controller.dart';

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({super.key, required List<String> formData});

  @override
  Widget build(BuildContext context) {
    final predictionProvider = Provider.of<PredictionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Prediksi Performa Tubuh")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await predictionProvider.predict();
              },
              child: Text('Predict'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'age'),
              controller: predictionProvider.ageController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(
                    11, double.tryParse(value) ?? 0.0);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Gender'),
              controller: predictionProvider.genderController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(
                    1, double.tryParse(value) ?? 0.0);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Height'),
              controller: predictionProvider.heightController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(
                    2, double.tryParse(value) ?? 0.0);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Weight'),
              controller: predictionProvider.weightController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(
                    3, double.tryParse(value) ?? 0.0);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Body Fat Percentage'),
              controller: predictionProvider.body_fat_percentController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(
                    4, double.tryParse(value) ?? 0.0);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Diastolic'),
              controller: predictionProvider.diastolicController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(
                    5, double.tryParse(value) ?? 0.0);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Systolic'),
              controller: predictionProvider.systolicController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(
                    6, double.tryParse(value) ?? 0.0);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Grip Force'),
              controller: predictionProvider.gripForceController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(
                    7, double.tryParse(value) ?? 0.0);
              },
            ),
            TextField(
              decoration:
                  InputDecoration(labelText: 'Sit and Bend Forward (cm)'),
              controller: predictionProvider.sit_and_bend_forward_cmController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(
                    8, double.tryParse(value) ?? 0.0);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Sit-Ups Count'),
              controller: predictionProvider.sit_ups_countsController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(
                    9, double.tryParse(value) ?? 0.0);
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Broad Jump (cm)'),
              controller: predictionProvider.broad_jump_cmController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                predictionProvider.updateInputData(
                    10, double.tryParse(value) ?? 0.0);
              },
            ),

            SizedBox(height: 20),
            // Tombol untuk mengirim prediksi
            ElevatedButton(
              onPressed: () async {
                await predictionProvider.predict();
              },
              child: Text('Predict'),
            ),
            SizedBox(height: 20),
            // Menampilkan hasil prediksi
            if (predictionProvider.predictionMessage != null)
              Text(
                'Prediction: ${predictionProvider.predictionMessage}',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
