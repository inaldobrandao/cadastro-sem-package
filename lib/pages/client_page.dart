import 'package:cadastro_sem_package/states/client_state.dart';
import 'package:flutter/material.dart';

import '../atoms/client_atom.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    clientState.value = const StartClientState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchClientsAction.value = Object();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: ListenableBuilder(
          listenable: clientState,
          builder: (context, child) {
            return switch (clientState.value) {
              StartClientState _ => const SizedBox(),
              LoadingClientState _ =>
                const Center(child: CircularProgressIndicator()),
              GettedClientState state => _gettedClients(state),
              FailureClientState state => _failure(state),
            };
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewClient,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _gettedClients(GettedClientState state) {
    final clients = state.clients;
    return ListView.builder(
        itemCount: clients.length,
        itemBuilder: (_, index) {
          final client = clients[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/edit', arguments: client);
            },
            title: Text(client.name),
            subtitle: Text(client.email),
            trailing: IconButton(
              onPressed: () {
                deleteClientAction.value = client.id;
              },
              icon: const Icon(Icons.remove_circle),
            ),
          );
        });
  }

  Widget _failure(FailureClientState state) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            fetchClientsAction.value = Object();
          },
          child: Text(state.message)),
    );
  }

  void _createNewClient() {
    Navigator.of(context).pushNamed('/create');
  }
}
