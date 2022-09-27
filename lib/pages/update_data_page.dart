import 'package:flutter/material.dart';

import '../data/repository.dart';

class UpdateData extends StatefulWidget {
  const UpdateData({Key? key}) : super(key: key);

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final messageController = TextEditingController();
  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    //RETORNA O VALOR DE ACORDO COM O INDEX 1=NOME 2=SOBRENOME 3=DESCRICAO
    final args = ModalRoute.of(context)?.settings.arguments as List<String>;
    if (args[1].isNotEmpty) {
      firstNameController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      lastNameController.text = args[2];
    }
    if (args[3].isNotEmpty) {
      messageController.text = args[3];
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Primeiro nome',
                  border: OutlineInputBorder(),
                ),
                controller: firstNameController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Segundo nome',
                  border: OutlineInputBorder(),
                ),
                controller: lastNameController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Descricao',
                  border: OutlineInputBorder(),
                ),
                controller: messageController,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/home');
                      },
                      child: const Text('Cancelar')),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.amber),
                      onPressed: () async {
                        bool response = await repository.updateData(
                          args[0],
                          firstNameController.text,
                          lastNameController.text,
                          messageController.text,
                        );

                        if (response) {
                          Navigator.popAndPushNamed(context, '/home');
                        } else {
                          throw Exception('erro');
                        }
                      },
                      child: Text('Editar')),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/home');
                      },
                      child: const Text('Voltar')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
