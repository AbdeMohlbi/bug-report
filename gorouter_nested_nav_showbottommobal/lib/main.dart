import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: '/page1',
        routes: [
          StatefulShellRoute.indexedStack(builder: (context, state, child) => child, branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                pageBuilder: (context, state) => const MaterialPage(child: Page1()),
                path: '/page1',
                routes: [
                  GoRoute(
                    pageBuilder: (context, state) => const MaterialPage(child: Page2()),
                    path: 'page2',
                  ),
                ],
              )
            ]),
          ]),
        ],
      ),
      title: 'Demo',
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push('/page1/page2');
          },
          child: const Text('Push nested'),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested - Page 2'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                useRootNavigator: true,
                context: context,
                builder: (context) {
                  return Container(
                    height: 150,
                    color: Colors.amber,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.pop(true);
                        },
                        child: const Text('Close modal'),
                      ),
                    ),
                  );
                });
          },
          child: const Text('show modal'),
        ),
      ),
    );
  }
}
