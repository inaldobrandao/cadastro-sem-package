import '../adapters/client_adapter.dart';
import '../atoms/client_atom.dart';
import '../states/edit_state.dart';
import '../widgets/text_input.dart';

import '../dtos/client_dto.dart';
import '../entities/client_entity.dart';
import 'package:flutter/material.dart';

class EditClient extends StatefulWidget {
  final ClientEntity? entity;

  const EditClient({super.key, this.entity});

  @override
  State<EditClient> createState() => _EditClientState();
}

class _EditClientState extends State<EditClient>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late ClientDTO dto;

  bool get editable => widget.entity != null;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    if (widget.entity != null) {
      dto = ClientAdapter.entityToDTO(widget.entity!);
    } else {
      dto = ClientDTO();
    }

    editClientState.value = const StartEditClientState();
    editClientState.addListener(_listener);
  }

  _listener() {
    setState(() {});
    return switch (editClientState.value) {
      StartEditClientState state => state,
      SavedClientState _ => Navigator.of(context).pop(),
      LoadingEditClientState state => state,
      FailureEditClientState state => _showSnackError(state),
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    editClientState.removeListener(_listener);
    super.dispose();
  }

  void _showSnackError(FailureEditClientState state) {
    final snackBar = SnackBar(
      content: Text(
        state.message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _save() {
    if (!dto.isValid()) {
      _showSnackError(const FailureEditClientState('Campos inválidos'));
      return;
    }

    if (editable) {
      updateClientAction.value = dto.copy();
    } else {
      createClientAction.value = dto.copy();
    }
  }

  void _clear() {
    setState(() {
      dto = ClientDTO(id: dto.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = editClientState.value;

    final enabled = state is! LoadingEditClientState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextInput(
              key: Key('name:$enabled${dto.hashCode}'),
              enabled: enabled,
              initialValue: dto.name,
              hint: 'Nome',
              validator: dto.nameValidate,
              onChanged: (value) => dto.name = value,
            ),
            const SizedBox(height: 5),
            TextInput(
              key: Key('email:$enabled${dto.hashCode}'),
              enabled: enabled,
              initialValue: dto.email,
              hint: 'Email',
              validator: dto.emailValidate,
              onChanged: (value) => dto.email = value,
            ),
            const SizedBox(height: 5),
            TextInput(
              key: Key('details:$enabled${dto.hashCode}'),
              enabled: enabled,
              initialValue: dto.details,
              hint: 'Detalhes',
              onChanged: (value) => dto.details = value,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                OutlinedButton(
                  onPressed: !enabled ? null : _save,
                  child: const Text('Salvar'),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: !enabled ? null : _clear,
                  child: const Text('Limpar'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
