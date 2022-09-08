import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ConfettiAnim extends StatefulWidget {
  const ConfettiAnim({Key? key}) : super(key: key);

  @override
  State<ConfettiAnim> createState() => _ConfettiAnimState();
}

class _ConfettiAnimState extends State<ConfettiAnim> {
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(( ){
          isPlaying = controller.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          backgroundColor: Colors.black38,
          appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              title: const Text(
                'Confetti App',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              )),
          body: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange, onPrimary: Colors.white),
              onPressed: () {
                if (isPlaying) {
                  controller.stop();
                } else {
                  controller.play();
                }
              },
              child: Text(
                isPlaying ? 'Stop' : 'Celebrate',
                style: const TextStyle(
                  fontSize: 40
                ),
              ),
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: controller,
          shouldLoop: true,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 100,
          emissionFrequency: 0.05,
          gravity: 0.5,
          createParticlePath: (size) {
            final path = Path();
            path.addArc(
                Rect.fromCircle(center: Offset.zero, radius: 10), 20, 130);
            return path;
          },
          colors: const [
            Colors.deepOrange,
            Colors.red,
            Colors.white,
            Colors.indigo,
            Colors.blue,
            Colors.lightGreenAccent,
            Colors.amber,
            Colors.greenAccent,
            Colors.pink
          ],
        ),
      ],
    );
  }
}
