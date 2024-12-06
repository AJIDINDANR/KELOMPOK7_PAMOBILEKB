import 'package:flutter/material.dart';
import 'prediction_form_page.dart';
import 'result_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<String> formData = [];

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages.add(HomeContent());
    _pages.add(PredictionFormPage(
      onFormSubmit: (data) {
        setState(() {
          formData = data;
        });
      },
    ));
    _pages.add(PredictionScreen(formData: formData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal[800],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.input), label: "Form"),
          BottomNavigationBarItem(icon: Icon(Icons.assessment), label: "Result"),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.greenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.fitness_center,
              color: Colors.white,
              size: 25,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Selamat Datang di Aplikasi Prediksi Performa Tubuh",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal[800],
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Aplikasi ini dirancang untuk membantu Anda menganalisis "
            "dan memprediksi performa tubuh berdasarkan beberapa atribut "
            "kesehatan dan kebugaran.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.teal, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.info, color: Colors.teal, size: 24),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Prediksi performa tubuh ini dapat membantu Anda "
                    "meningkatkan kebugaran serta kesehatan.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.teal[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Contoh Gambar dan Penjelasan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: ImageSlide(
                    imagesWithDescriptions: [
                      {
                        'imagePath': 'assets/images/image1.jpg',
                        'description': 'Gambar 1: Metode Deep Neural Network'
                      },
                      {
                        'imagePath': 'assets/images/image2.jpg',
                        'description': 'Gambar 2: Class Kategori'
                      },
                      {
                        'imagePath': 'assets/images/image3.jpg',
                        'description': 'Gambar 3: Hasil Prediksi yang Detail'
                      },
                      {
                        'imagePath': 'assets/images/image4.jpg',
                        'description': 'Gambar 4: Grafik Analisis'
                      },
                      {
                        'imagePath': 'assets/images/image5.jpg',
                        'description': 'Gambar 5: Informasi dan Saran'
                      },
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PredictionFormPage(
                    onFormSubmit: (data) {},
                  ),
                ),
              );
            },
            icon: Icon(Icons.arrow_forward, color: Colors.white),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              textStyle: TextStyle(fontSize: 18),
            ),
            label: Text("Mulai Prediksi Sekarang"),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ImageSlide extends StatefulWidget {
  final List<Map<String, String>> imagesWithDescriptions;

  const ImageSlide({required this.imagesWithDescriptions});

  @override
  _ImageSlideState createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imagesWithDescriptions.length,
            itemBuilder: (context, index) {
              final item = widget.imagesWithDescriptions[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    // Background Image with rounded corners
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.9, // Perbesar tinggi menjadi 60% layar
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: Image.asset(
                          item['imagePath']!,
                          fit: BoxFit.cover, // Isi area gambar sepenuhnya
                        ),
                      ),
                    ),
                    // Left arrow for previous slide
                    Positioned(
                      left: 10,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (_pageController.page! > 0) {
                            _pageController.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    // Right arrow for next slide
                    Positioned(
                      right: 10,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (_pageController.page! < widget.imagesWithDescriptions.length - 1) {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    // Description box at the bottom
                    Positioned(
                      bottom: 5,
                      left: 7,
                      right: 7,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          item['description']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}