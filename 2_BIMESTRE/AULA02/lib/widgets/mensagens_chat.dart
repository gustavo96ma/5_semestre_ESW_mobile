import 'package:flutter/material.dart';

import 'mensagem.dart';

class MensagensChat extends StatelessWidget {
  const MensagensChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return const Mensagem();
          },
        ),
      ),
    );
  }
}
