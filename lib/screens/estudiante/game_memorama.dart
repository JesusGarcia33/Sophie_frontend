import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../components/widgets_app.dart';

import '../../provider/memorama_services.dart';

class Memorama extends StatefulWidget {
  const Memorama({super.key});

  @override
  State<Memorama> createState() => _MemoramaState();
}

class _MemoramaState extends State<Memorama> {
  final Set<int> flippedCards = {};
  final Set<int> matchedCards = {};
  final List<int> selectedCards = [];
  bool isChecking = false;

  @override
  void initState() {
    super.initState();
    // Fetch groups when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MemoramaServices>(context, listen: false).getMemorama();
    });
  }

  @override
  Widget build(BuildContext context) {
    final memoramaProvider = Provider.of<MemoramaServices>(context);
    final cartas = memoramaProvider.cartasList;
    return SafeArea(
      child: matchedCards.length == cartas.length
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppText(
                    text: 'FELICIDADES',
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 20),
                  const AppText(text: 'Completaste la actividad'),
                  const SizedBox(height: 20),
                  AppButton(
                    onPressed: () {
                      memoramaProvider.sendPuntajeMemorama();
                      context.goNamed('puntajes_alumno');
                    },
                    text: ' Ver puntaje',
                  ),
                ],
              ),
            )
          : GridView.builder(
              itemBuilder: (context, index) {
                final carta = cartas[index];
                final isFlipped = flippedCards.contains(index) ||
                    matchedCards.contains(index);
                return GestureDetector(
                  onTap: () {
                    if (selectedCards.length < 2 &&
                        !selectedCards.contains(index) &&
                        !matchedCards.contains(index) &&
                        !isChecking) {
                      setState(() {
                        selectedCards.add(index);
                        flippedCards.add(index);
                        if (selectedCards.length == 2) {
                          isChecking = true;
                          final firstCard = cartas[selectedCards[0]];
                          final secondCard = cartas[selectedCards[1]];
                          if (firstCard.id == secondCard.cartaPar ||
                              secondCard.id == firstCard.cartaPar) {
                            matchedCards.addAll(selectedCards);
                          } else {
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              setState(() {
                                flippedCards.removeAll(selectedCards);
                              });
                            });
                          }
                          Future.delayed(const Duration(milliseconds: 500), () {
                            setState(() {
                              selectedCards.clear();
                              isChecking = false;
                            });
                          });
                        }
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amberAccent,
                    ),
                    child: Center(
                      child: isFlipped
                          ? Text(carta.textoCarta)
                          : const Image(
                              image: AssetImage('assets/estrellaM.png'),
                              alignment: Alignment.center,
                            ),
                    ),
                  ),
                );
              },
              itemCount: cartas.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
    );
  }
}
