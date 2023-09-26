import 'package:flutter/material.dart';
import 'package:appcrudsqlite/data/dbCarro.dart';

class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Add();
  }
}

class _Add extends State<Add> {
  TextEditingController marca = TextEditingController();

  TextEditingController modelo = TextEditingController();

  TextEditingController motor = TextEditingController();

  TextEditingController transmicao = TextEditingController();

  TextEditingController ano = TextEditingController();

  TextEditingController roll_no = TextEditingController();

  //test editing controllers for form

  dbCarro mydb = dbCarro(); //mydb new object from db.dart

  @override
  void initState() {
    mydb.open(); //initilization database

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Inserir Carros"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: marca,
                decoration: const InputDecoration(
                  hintText: "Marca",
                ),
              ),
              TextField(
                controller: modelo,
                decoration: const InputDecoration(
                  hintText: "modelo",
                ),
              ),
              TextField(
                controller: motor,
                decoration: const InputDecoration(
                  hintText: "motor",
                ),
              ),
              TextField(
                controller: transmicao,
                decoration: const InputDecoration(
                  hintText: "transmição",
                ),
              ),
              TextField(
                controller: ano,
                decoration: const InputDecoration(
                  hintText: "Ano",
                ),
              ),
              TextField(
                controller: roll_no,
                decoration: const InputDecoration(
                  hintText: "roll_no",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "INSERT INTO carro(marca, modelo, motor, transmicao, ano, roll_no) VALUES (?, ?, ?, ?, ?, ?);",
                        [
                          marca.text,
                          modelo.text,
                          motor.text,
                          transmicao.text,
                          ano.text,
                          roll_no.text
                        ]); //add student from form to database

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Carro Adicionado")));

                    marca.text = "";

                    modelo.text = "";

                    motor.text = "";

                    transmicao.text = " ";

                    ano.text = " ";
                    
                    roll_no.text = " ";
                  },
                  child: Text("Salvar Carro")),
            ],
          ),
        ));
  }
}
