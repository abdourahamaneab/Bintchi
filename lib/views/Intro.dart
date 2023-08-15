import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:projetuto/views/connexion.dart  ';


class Presentation extends StatefulWidget {
  const Presentation({super.key});

  @override
  State<Presentation> createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  //pour savoir si on est sur la dernieère page
  bool lastlast = false;
  //le controller
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (value) {
            setState(() {
              lastlast = (value == 6);
            });
          },
          children: [
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('entrain de travailler',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 48, 73),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Center(
                    child: Lottie.asset('assets/icon/worker.json'),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(
                widthFactor: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('un petit creux',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 48, 73),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Lottie.asset("assets/icon/hungry.json"),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('attente trop longue',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 48, 73),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Lottie.asset(
                    'assets/icon/queue.json',
                  )
                ],
              )),
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('commande ton repas ',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 48, 73),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Lottie.asset('assets/icon/appli.json'),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('paye en ligne ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 48, 73),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Lottie.asset('assets/icon/money.json'),
                    ]),
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('et viens le récupérer',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 48, 73),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Lottie.asset('assets/icon/recupérer.json'),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Center(
                widthFactor: 50,
                child: Image.asset('assets/logo-range/orange_transparent.png'),
              ),
            )
          ],
        ),
        Container(
            alignment: const Alignment(0.0, 0.70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                lastlast
                    ? GestureDetector(
                        child: const Text(
                          'commander',
                          style: TextStyle(color: Color.fromARGB(255,247,127,0), fontSize: 20,decoration: TextDecoration.underline),

                        ),
                        onTap: () {
                          //va à la page de connexion
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Connexion()));
                        },
                      )
                    : GestureDetector(
                        child: const Text(
                          'suivant',
                          style: TextStyle(color: Color.fromARGB(255,247,127,0), fontSize: 20),
                        ),
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 7,
                ),
                GestureDetector(
                  child: const Text('passer',
                      style: TextStyle(color: Color.fromARGB(255,247,127,0), fontSize: 20)),
                  onTap: () {
                    _controller.jumpToPage(6);
                  },
                ),
              ],
            )),
      ],
    ));
  }
}
