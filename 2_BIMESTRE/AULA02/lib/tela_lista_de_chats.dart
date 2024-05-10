import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'tela_chat.dart';

final _firebaseAuth = FirebaseAuth.instance;

class TelaListaDeChats extends StatefulWidget {
  const TelaListaDeChats({super.key});

  @override
  State<TelaListaDeChats> createState() => _TelaListaDeChatsState();
}

class _TelaListaDeChatsState extends State<TelaListaDeChats> {
  final List<Chat> listaChats = [];

  void adicionaNovoChat() {
    listaChats.add(
      Chat(
        nome: '5º Engenharia de Software',
        mensagens: {'conteudo': 'Olá'},
      ),
    );
    listaChats.add(
      Chat(
        nome: '5º Análise e Desenvolvimento de Sistemas',
        mensagens: {'conteudo': 'Alô'},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    adicionaNovoChat();

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
          itemCount: listaChats.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(8),
              title: Text(listaChats[index].nome),
              subtitle: Text(
                'Última mensagem: ${listaChats[index].mensagens['conteudo']!}',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaChat(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Chat {
  final String nome;
  final Map<String, String> mensagens;

  Chat({required this.nome, required this.mensagens});
}
