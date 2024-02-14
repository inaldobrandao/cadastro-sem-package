import '../entities/client_entity.dart';
import '../dtos/client_dto.dart';

class ClientAdapter {
  ClientAdapter._();

  static ClientEntity fromMap(dynamic map) {
    return ClientEntity(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      datails: map['datails'],
    );
  }

  static ClientDTO entityToDTO(ClientEntity model) {
    return ClientDTO(
        id: model.id,
        name: model.name,
        email: model.email,
        details: model.datails);
  }

  static Map<String, dynamic> entityToMap(ClientEntity model) {
    return {
      'id': model.id,
      'name': model.name,
      'email': model.email,
      'details': model.datails
    };
  }

  static Map<String, dynamic> dtoToMap(ClientDTO model) {
    return {
      'id': model.id,
      'name': model.name,
      'email': model.email,
      'details': model.details
    };
  }
}
