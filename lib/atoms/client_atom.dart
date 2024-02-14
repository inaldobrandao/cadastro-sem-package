import 'package:cadastro_sem_package/dtos/client_dto.dart';
import 'package:cadastro_sem_package/states/client_state.dart';
import 'package:cadastro_sem_package/states/edit_state.dart';
import 'package:flutter/material.dart';

//Atom
final clientState = ValueNotifier<ClientState>(const StartClientState());
final editClientState =
    ValueNotifier<ClientEditState>(const StartEditClientState());

//Actions
final fetchClientsAction = ValueNotifier(Object());
final createClientAction = ValueNotifier<ClientDTO>(ClientDTO());
final updateClientAction = ValueNotifier<ClientDTO>(ClientDTO());
final deleteClientAction = ValueNotifier<String>('');
