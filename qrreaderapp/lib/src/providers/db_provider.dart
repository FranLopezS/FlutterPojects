import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qrreaderapp/src/models/scan_model.dart';
export 'package:qrreaderapp/src/models/scan_model.dart';

class DBProvider {

  // Sólo podrá haber 1 instancia a la vez de esta clase.
  static Database _database;
  static final DBProvider db = DBProvider._(); // Inicializar con constructor privado.

  DBProvider._();

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        // Lo que se crea cuando se crea la bbdd.
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY, '
          ' tipo TEXT, '
          ' valor TEXT '
          ')'
        );
      }
    );
  }

  // Crear registros en la bbdd.
  /*nuevoScanRaw(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.rawInsert(
      "INSERT into Scans(id, tipo, valor) ""
      "VALUES ( '${nuevoScan.id}', '${nuevoScan.tipo}', '${nuevoScan.valor}' )"
    );
    return res;
  }*/

  nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  // SELECT - Obtener información.
  getScanPorId(int id) async {
    final db = await database; // Para ver si podemos escribir en la bbdd.
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null; // Si res no tá vacío... Devuelvo un json de ScanModel. 
  }

  Future<List<ScanModel>> getTodoScans() async {
    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty 
                              ? res.map((e) => ScanModel.fromJson(e))
                              .toList()
                              : [];
    return list;
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo'");

    List<ScanModel> list = res.isNotEmpty 
                              ? res.map((e) => ScanModel.fromJson(e))
                              .toList()
                              : [];
    return list;
  }
  
  // Actualizar.
  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
                                  where: 'id=?', whereArgs: [nuevoScan.id]);
    return res;
  }

  // Eliminar registros.
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }

}