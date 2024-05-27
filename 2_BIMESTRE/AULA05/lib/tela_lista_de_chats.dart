import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'tela_chat.dart';

final _firebaseAuth = FirebaseAuth.instance;

class TelaListaDeChats extends StatefulWidget {
  const TelaListaDeChats({super.key});

  @override
  State<TelaListaDeChats> createState() => _TelaListaDeChatsState();
}

class _TelaListaDeChatsState extends State<TelaListaDeChats> {
  void configuraNotificacoes(chatsCarregados, usuarioAutenticado) async {
    final firebaseMessageria = FirebaseMessaging.instance;
    await firebaseMessageria.requestPermission();

    for (var documento in chatsCarregados) {
      for (var email in documento['email']) {
        if (email == usuarioAutenticado.email) {
          firebaseMessageria.subscribeToTopic(documento.id);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarioAutenticado = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('salas-participantes')
          .where('email', arrayContains: usuarioAutenticado!.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('Nenhuma sala encontrada!'),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Algum erro desconhecido ocorreu'),
          );
        }

        final chatsCarregados = snapshot.data!.docs;

        configuraNotificacoes(chatsCarregados, usuarioAutenticado);

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 219, 219, 219),
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: const Text(
              'Turmas',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                onPressed: () => _firebaseAuth.signOut(),
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 40),
              itemCount: chatsCarregados.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  title: Text(chatsCarregados[index].id),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaChat(chatId: chatsCarregados[index].id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
