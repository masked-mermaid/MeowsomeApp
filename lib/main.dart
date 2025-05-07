import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Facts App',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Meowsome Facts App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String catFact = 'Tap the paw for a meowsome fact!';
  String imageUrl = 'https://cataas.com/cat'; // default image

  // 🧠 Fetch cat fact & image
  void getCatData() async {
    try {
      // 1️⃣ Fetch cat fact
      final factRes = await http.get(Uri.parse('https://catfact.ninja/fact'));

      if (factRes.statusCode == 200) {
        final data = jsonDecode(factRes.body);
        final newFact = data['fact'];

        // 2️⃣ Update state with new fact and image
        setState(() {
          catFact = newFact;
          imageUrl = 'https://cataas.com/cat?timestamp=${DateTime.now().millisecondsSinceEpoch}';
          // ⏱️ Adding timestamp to force image refresh
        });
      } else {
        setState(() {
          catFact = 'Failed to load cat fact. Try again!';
        });
      }
    } catch (e) {
      setState(() {
        catFact = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.pink.shade200,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 🖼️ Image
            Image.network(
              imageUrl,
              height: 250,
              width: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, size: 100),
            ),
            const SizedBox(height: 20),

            // 📜 Fact
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              color: Colors.pink.shade50,
              child: Text(
                catFact,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getCatData,
        tooltip: 'Get Cat Fact',
        child: const Icon(Icons.pets),
      ),
    );
  }
}
