import '../adapters/client_adapter.dart';
import '../dtos/client_dto.dart';
import '../entities/client_entity.dart';
import 'http_client_service.dart';

class ClientService {
  final HttpClientService client;

  ClientService(this.client);

  Future<List<ClientEntity>> fetchClients() async {
    final response = await client.get('http://10.0.2.2:3031/clients');
    return (response as List).map(ClientAdapter.fromMap).toList();
  }

  Future<void> createClient(ClientDTO dto) async {
    final data = ClientAdapter.dtoToMap(dto);
    await client.post('http://10.0.2.2:3031/clients', data);
  }

  Future<void> updateClient(ClientDTO dto) async {
    final data = ClientAdapter.dtoToMap(dto);
    await client.put('http://10.0.2.2:3031/clients/${dto.id}', data);
  }

  Future<void> deleteClient(String id) async {
    await client.delete('http://10.0.2.2:3031/clients/$id');
  }
}
