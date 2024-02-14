import 'dart:io';

import 'package:flutter/material.dart';

import 'entities/client_entity.dart';
import 'pages/client_page.dart';
import 'pages/edit_page.dart';
import 'reducers/client_reducer.dart';
import 'services/client_service.dart';
import 'services/http_client_service.dart';

void main() {
  runApp(const RootWidget());
}

class RootWidget extends StatefulWidget {
  const RootWidget({super.key});

  @override
  State<RootWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RootWidget> {
  final httpClient = HttpClient();
  late final httpClientService = HttpClientService(httpClient);
  late final clientService = ClientService(httpClientService);
  late final reducer;

  @override
  void initState() {
    super.initState();
    reducer = ClientReducer(clientService);
  }

  @override
  void dispose() {
    reducer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => const ClientPage(),
        '/create': (_) => const EditClient(),
        '/edit': (context) {
          final entity =
              ModalRoute.of(context)?.settings.arguments as ClientEntity?;
          return EditClient(entity: entity);
        },
      },
    );
  }
}
