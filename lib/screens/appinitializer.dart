import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:task_flow/providers/taskprovider.dart';
import 'package:task_flow/providers/userprovider.dart';
import 'package:task_flow/screens/navbar.dart';

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  late Future<void> _future;

  @override
  void initState() {
    super.initState();

    _future = _initialize();
  }

  Future<void> _initialize() async {
    await Future.wait([
      context.read<Taskprovider>().loadTasks(),
      context.read<Userprovider>().setUser(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            backgroundColor: const Color(0xffF7F8FC),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/annimations/check.json",
                    height: 100,
                    width: 100
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Loading TaskFlow...",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0D47A1),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Preparing your workspace...",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text(snapshot.error.toString())));
        }
        return const Navbar();
      },
    );
  }
}
