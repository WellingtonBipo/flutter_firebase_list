import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text('Bem Vindo!', style: TextStyle(fontSize: 20)),
        ElevatedButton(
          onPressed: () async {
            final users = FirebaseFirestore.instance.collection('users');
            final data = await users.get();
            for (var doc in data.docs) {
              print(doc.get('test'));
            }
          },
          child: const Text('Entrar'),
        ),
        ElevatedButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc('dMK5EVARSJ1Da9eQt2SJ')
                .update({'test': 2});
          },
          child: const Text('Cadastrar'),
        )
      ],
    ));
  }
}
