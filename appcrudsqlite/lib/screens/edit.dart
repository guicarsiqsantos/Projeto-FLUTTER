import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/dbCarro.dart';

class Edit extends StatefulWidget {
  int rollno;

  Edit({required this.rollno}); //constructor for class

  @override
  State<StatefulWidget> createState() {
    return _Edit();
  }
}

class _Edit extends State<Edit> {
  TextEditingController marca = TextEditingController();

  TextEditingController modelo = TextEditingController();

  TextEditingController motor = TextEditingController();

  TextEditingController transmicao = TextEditingController();

  TextEditingController ano = TextEditingController();

  TextEditingController roll_no = TextEditingController();

  dbCarro mydb = new dbCarro();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getCarro(
          widget.rollno); //widget.rollno is passed paramater to this class

      if (data != null) {
        marca.text = data["marca"];

        modelo.text = data["modelo"];
        
        motor.text = data["motor"];

        transmicao.text = data["transmicao"];

        ano.text = data["ano"];

        roll_no.text = data["roll_no"].toString();

        setState(() {});
      } else {
        print("Não encontrado dados com roll no: " + widget.rollno.toString());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Carro"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: marca,
                decoration: InputDecoration(
                  hintText: "Marca",
                ),
              ),
              TextField(
                controller: modelo,
                decoration: InputDecoration(
                  hintText: "Modelo",
                ),
              ),
              TextField(
                controller: motor,
                decoration: InputDecoration(
                  hintText: "motor",
                ),
              ),
              TextField(
                controller: transmicao,
                decoration: InputDecoration(
                  hintText: "Transmissão",
                ),
              ),
              TextField(
                controller: ano,
                decoration: InputDecoration(
                  hintText: "Ano",
                ),
              ),
              TextField(
                controller: roll_no,
                decoration: InputDecoration(
                  hintText: "roll_no",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE carro SET marca = ?, modelo = ?, motor = ?, transmicao=?, ano=? WHERE roll_no = ?",
                        [
                          modelo.text,
                          marca.text,
                          motor.text,
                          transmicao.text,
                          ano.text,
                          widget.rollno
                        ]);

                    //update table with roll no.

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Carro Alterado!")));
                  },
                  child: Text("Alterar Carro")),
            ],
          ),
        ));
  }
}
