import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TelaDeGameplay extends StatefulWidget {
  final String nome;
  final String imagemH;
  final int vida;
  final int moedas;
  final int poder;

  const TelaDeGameplay({
    super.key,
    required this.nome,
    required this.imagemH,
    required this.vida,
    required this.moedas,
    required this.poder,
  });

  @override
  State<TelaDeGameplay> createState() => _TelaDeGameplayState();
}

class _TelaDeGameplayState extends State<TelaDeGameplay> {
  double posicaoHorizontal = 40;
  double posicaoVertical = 120;

  double pocaoHorizontal = 160;
  double pocaoVertical = 160;

  late int vida = widget.vida;

  int miliss = 200;

  bool pocao = true;
  bool pulando = false;

  // COLISÃO COM A POÇÃO
  void colisao() {
    double distanciaX =
        (posicaoHorizontal - pocaoHorizontal).abs();

    double distanciaY =
        (posicaoVertical - pocaoVertical).abs();

    if (pocao && distanciaX < 60 && distanciaY < 80) {
      pocao = false;
      vida += 50;
    }
  }

  // ANDAR PARA A DIREITA
  void andarParaDireita() {
    setState(() {
      posicaoHorizontal += 40;
      colisao();
    });
  }

  // ANDAR PARA A ESQUERDA
  void andarParaEsquerda() {
    setState(() {
      if (posicaoHorizontal > 10) {
        posicaoHorizontal -= 40;
      }

      colisao();
    });
  }

  // PULAR
  void pular() {
    if (!pulando) {
      pulando = true;

      setState(() {
        posicaoVertical = 220;
        colisao();
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            posicaoVertical = 120;
            pulando = false;
            colisao();
          });
        }
      });
    }
  }

  // CONTROLES DO TECLADO
  void usarTecla(KeyEvent evento) {
    if (evento is KeyDownEvent) {
      if (evento.logicalKey == LogicalKeyboardKey.arrowRight) {
        andarParaDireita();
      }

      if (evento.logicalKey == LogicalKeyboardKey.arrowLeft) {
        andarParaEsquerda();
      }

      if (evento.logicalKey == LogicalKeyboardKey.arrowUp) {
        pular();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, evento) {
        usarTecla(evento);
        return KeyEventResult.handled;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // FUNDO
            Positioned.fill(
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmbjeMWU4uWiVuQAs-wGhArJy2l-p8Ap9J1OwLsGgIlA&s=10',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox.shrink();
                },
              ),
            ),

            // INFORMAÇÕES DO HERÓI
            Positioned(
              top: 40,
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nome,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "❤️ Vida: $vida",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),

                    Text(
                      "💰 Moedas: ${widget.moedas}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),

                    Text(
                      "⚔️ Poder: ${widget.poder}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // POÇÃO
            if (pocao)
              Positioned(
                left: pocaoHorizontal,
                bottom: pocaoVertical,
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/105/105223.png',
                  height: 60,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
              ),

            // PERSONAGEM
            AnimatedPositioned(
              duration: Duration(milliseconds: miliss),
              curve: Curves.easeOut,
              left: posicaoHorizontal,
              bottom: posicaoVertical,
              child: Image.network(
                widget.imagemH,
                height: 130,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox.shrink();
                },
              ),
            ),

            // BOTÃO ESQUERDA
            Positioned(
              bottom: 30,
              left: 30,
              child: ElevatedButton(
                onPressed: andarParaEsquerda,
                child: const Text(
                  "⬅ Esquerda",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            // BOTÃO PULO
            Positioned(
              bottom: 30,
              left: 170,
              child: ElevatedButton(
                onPressed: pular,
                child: const Text(
                  "⬆ Pulo",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            // BOTÃO DIREITA
            Positioned(
              bottom: 30,
              right: 30,
              child: ElevatedButton(
                onPressed: andarParaDireita,
                child: const Text(
                  "Direita ➡",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}