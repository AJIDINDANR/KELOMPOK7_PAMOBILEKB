import 'package:flutter/material.dart';
import 'package:tabularapp/pages/result_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/sign_up_page.dart';
import 'pages/home_page.dart';
import 'pages/prediction_form_page.dart';

void main() {
  runApp(PredictionApp());
}

class PredictionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.grey[800]),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal[800]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    // Menangani rute ResultPage dengan formData
    if (settings.name == '/result') {
  if (settings.arguments is List<String>) {
    final formData = settings.arguments as List<String>;
    return MaterialPageRoute(
      builder: (context) => PredictionScreen(formData: formData),
    );
  } else {
    return _notFoundRoute();
  }
}

    // Rute lainnya
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SignInPage());
      case '/sign-up':
        return MaterialPageRoute(builder: (context) => SignUpPage());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/predictionForm':
        return MaterialPageRoute(builder: (context) => PredictionFormPage(onFormSubmit: (data) {
          // Kirim data yang diisi oleh pengguna ke halaman ResultPage
          Navigator.pushNamed(context, '/result', arguments: data);
        }));
      default:
        return _notFoundRoute();
    }
  }

  // Halaman 404 - Tidak Ditemukan
  MaterialPageRoute _notFoundRoute() {
  return MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: Text('404 - Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oops! Halaman tidak ditemukan.',
              style: TextStyle(fontSize: 18, color: Colors.red[600]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              child: Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    ),
  );
}
}