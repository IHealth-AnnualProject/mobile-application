abstract class ISQLLITEManager {

  Future openDatabaseandCreateTable();

  Future<int> insert(dynamic element);

  Future<List<dynamic>> getAll();

  Future<int> update(dynamic element);

  Future<int> delete(int id);

  Future close();


}