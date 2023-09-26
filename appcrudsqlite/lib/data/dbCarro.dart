import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbCarro {
  late Database db;

  Future open() async {
    // Get a location using getDatabasesPath

    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, 'bdcrud.db');

    //join is from path package

    print(
        path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table

      await db.execute(''' 
                  CREATE TABLE IF NOT EXISTS carro (  
                        id primary key, 
                        marca varchar(255) not null, 
                        modelo varchar(255) not null, 
                        motor varchar(255) not null,
                        transmicao varchar(255) not null,
                        ano varchar(255) not null ,
                        roll_no int not null
                    ); 
  
                    //create more table here 

                ''');
      print("Tabela Criada com Sucesso!");
    });
  }

  //método de consulta de dados

  Future<Map<dynamic, dynamic>?> getCarro(int rollno) async {
    List<Map> maps =
        await db.query('carro', where: 'roll_no = ?', whereArgs: [rollno]);

    //getting student data with roll no.

    if (maps.length > 0) {
      return maps.first;
    }

    return null;
  }
}
