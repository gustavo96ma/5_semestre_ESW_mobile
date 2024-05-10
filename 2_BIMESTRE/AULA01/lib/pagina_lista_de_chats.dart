import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebaseAuth = FirebaseAuth.instance;

class PaginaListaDeChats extends StatefulWidget {
  const PaginaListaDeChats({super.key});

  @override
  State<PaginaListaDeChats> createState() => _PaginaListaDeChatsState();
}

class _PaginaListaDeChatsState extends State<PaginaListaDeChats> {
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
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Turmas'),
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
                  'Última mensagem: ${listaChats[index].mensagens['conteudo']!}'),
              onTap: () {
                // redirecionar o usuario para a tela do chat
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
