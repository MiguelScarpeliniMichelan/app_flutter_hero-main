import 'package:flutter/material.dart';
import "TelaDeGameplay.dart";

class TelaJogoHeroi extends StatefulWidget {
  const TelaJogoHeroi({super.key});

  @override
  State<TelaJogoHeroi> createState() => TelaJogoHeroiState();
}

class TelaJogoHeroiState extends State<TelaJogoHeroi> {
  String nome = "";
  int vida = 0;
  int moedas = 0;
  int poder = 0;
  String imagemH = "";
  String titulo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Escolha seu herói:",
              style: TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    escolha("Guerreiro");
                  },
                  child: const Text("Guerreiro"),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    escolha("Mago");
                  },
                  child: const Text("Mago"),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    escolha("Bardo");
                  },
                  child: const Text("Bardo"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (imagemH != "")
              Image.asset(
                imagemH,
                height: 250,
              ),

            const SizedBox(height: 20),

            Card(
              elevation: 5,
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Classe: $nome",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    const Divider(),

                    Text(
                      "❤️ Vida: $vida",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),

                    Text(
                      "💰 Moedas: $moedas",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.orange,
                      ),
                    ),

                    Text(
                      "⚔️ Poder: $poder",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (nome != "") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaDeGameplay(
                        nome: nome,
                        vida: vida,
                        moedas: moedas,
                        poder: poder,
                        imagemH: imagemH,
                      ),
                    ),
                  );
                }
              },
              child: const Text("Jogar"),
            ),
          ],
        ),
      ),
    );
  }

  void escolha(String tipoHeroi) {
    setState(() {
      if (tipoHeroi == "Guerreiro") {
        nome = "Renan Santos";
        vida = 200;
        moedas = 20;
        poder = 100;
        titulo = "O Salvador";
        imagemH = "Renan.png";
      }

      if (tipoHeroi == "Mago") {
        nome = "Arthur do Val";
        vida = 50;
        moedas = 10;
        poder = 155;
        titulo = "O Mago das Loiras";
        imagemH = "arthur.png";
      }

      if (tipoHeroi == "Bardo") {
        nome = "Kim Kataguiri";
        vida = 20;
        moedas = 1000;
        poder = 200;
        titulo = "O Terror da Velha Política";
        imagemH = "Kim.png";
      }
    });
  }
}