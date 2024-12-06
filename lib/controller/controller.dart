import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictionProvider with ChangeNotifier {
  List<double> inputData = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  String? predictionMessage;

  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController body_fat_percentController = TextEditingController();
  final TextEditingController diastolicController = TextEditingController();
  final TextEditingController systolicController = TextEditingController();
  final TextEditingController gripForceController = TextEditingController();
  final TextEditingController sit_and_bend_forward_cmController = TextEditingController();
  final TextEditingController sit_ups_countsController = TextEditingController();
  final TextEditingController broad_jump_cmController = TextEditingController();

  // Fungsi untuk mengupdate input data
  void updateInputData(int index, double value) {
    inputData[index] = value.toDouble();
    notifyListeners();
  }

  // Fungsi untuk mengirim data ke API dan mendapatkan respons
  Future<void> predict() async {
    final url = Uri.parse('https://paapi7.loca.lt/api/predict'); // Ganti dengan URL API kamu
    final body = jsonEncode({
      'data': inputData,
    });
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        int classPrediction = data['prediction'][0];
        predictionMessage = _mapClassToSpecies(classPrediction);
      } else {
        predictionMessage = 'Failed to get prediction';
      }
      clearInputData();
      clearControllers();
    } catch (e) {
      predictionMessage = 'Error: $e';
    }
    notifyListeners();
  }

  String _mapClassToSpecies(int classPrediction) {
    switch (classPrediction) {
      case 0:
        return 'A';
      case 1:
        return 'B';
      case 2:
        return 'C';
      case 3:
        return 'D';
      default:
        return 'Tidak diketahui';
    }
  }

  void clearInputData() {
    inputData = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,];
    notifyListeners();
  }

  // Fungsi untuk mengosongkan semua controller input
  void clearControllers() {
    ageController.clear();
    genderController.clear();
    heightController.clear();
    weightController.clear();
    body_fat_percentController.clear();
    diastolicController.clear();
    systolicController.clear();
    gripForceController.clear();
    sit_and_bend_forward_cmController.clear();
    sit_ups_countsController.clear();
    broad_jump_cmController.clear();
    
    notifyListeners();
  }
  @override
  void dispose() {
    // Jangan lupa dispose controller ketika provider tidak lagi digunakan
    ageController.dispose();
    genderController.dispose();
    heightController.dispose();
    weightController.dispose();
    body_fat_percentController.dispose();
    diastolicController.dispose();
    systolicController.dispose();
    gripForceController.dispose();
    sit_and_bend_forward_cmController.dispose();
    sit_ups_countsController.dispose();
    broad_jump_cmController.dispose();
    super.dispose();
  }
}