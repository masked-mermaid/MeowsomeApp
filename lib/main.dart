import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;






void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  
  

  // This widget is the root of your application.
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 87, 0, 236)),
      ),
      home: const MyHomePage(title: 'Press the button for Meowsome facts'),
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
  
  void getfacts() async{
  final url=Uri.parse('https://catfact.ninja/fact');
  final response = await http.get(url);
  if (response.statusCode==200){
    final data = jsonDecode(response.body);
   final fact=data['fact'];
  
  

  setState((){
    catfact = fact;
    
  });

  }
  }


  String catfact='Meow';

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
      
        backgroundColor: const Color.fromARGB(255, 255, 177, 203),
       
        title: Text(widget.title),
      ),
      body: Center(
       
        child: Column(
        
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              color: const Color.fromARGB(255, 255, 194, 255),
              child: Text(
               catfact,
                style: Theme.of(context).textTheme.headlineMedium,
                
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getfacts,
        tooltip: 'Cat Fact',
        child: const Icon(Icons.pets),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
