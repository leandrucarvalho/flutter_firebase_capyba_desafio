import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  PageController pageController = PageController(initialPage: 0);
  int posicaoPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Desafio App Flutter"),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            posicaoPage = value;
          });
        },
        children: [
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.green,
        onTap: (value) {
          pageController.jumpToPage(value);
        },
        currentIndex: posicaoPage,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
          ),
          BottomNavigationBarItem(
            label: "Restrito",
            icon: FaIcon(
              FontAwesomeIcons.lock,
            ),
          ),
        ],
      ),
    );
  }
}
