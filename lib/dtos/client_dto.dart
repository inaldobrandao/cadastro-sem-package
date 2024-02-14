import 'package:cadastro_sem_package/dtos/client_validate_mixin.dart';
import 'package:cadastro_sem_package/dtos/dto.dart';
import 'package:cadastro_sem_package/services/string_generator.dart';

class ClientDTO extends DTO with ClientValidate {
  late String id;
  String name;
  String email;
  String? details;

  ClientDTO({
    String? id,
    this.name = '',
    this.email = '',
    this.details,
  }) {
    this.id = id ?? stringGenerator();
  }

  ClientDTO copy() {
    return ClientDTO(id: id, name: name, email: email, details: details);
  }

  @override
  void validate() {
    nameValidate(name);
    emailValidate(email);
  }
}
