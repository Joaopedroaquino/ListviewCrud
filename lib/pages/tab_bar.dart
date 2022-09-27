import 'package:edit_widget/pages/home_page.dart';
import 'package:edit_widget/pages/update_data_page.dart';
import 'package:flutter/material.dart';

import '../data/repository.dart';
import '../model/person.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TabBarWidgetData();
  }
}

class TabBarWidgetData extends State<TabBarWidget>
    with TickerProviderStateMixin {
  late TabController _tabControllerList;
  List<Person> listPerson = [];
  Repository repository = Repository();

  getData() async {
    listPerson = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
    _tabControllerList = TabController(length: 2, vsync: this, initialIndex: 0);
    _scrollController = ScrollController();
  }

  late ScrollController _scrollController;

  int _tabIndex = 0;

  late TabController _tabController;

  void _toggleTab() {
    _tabIndex = _tabControllerList.index + 1;
    _tabController.animateTo(_tabIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _tabControllerList.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45,
              color: Colors.white30,
              width: 420,
              child: TabBar(
                indicator: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  color: Color(0x9B83BDEC),
                ),
                indicatorColor: Color(0xFF2797FF),
                labelColor: Color(0xFF000305),
                labelStyle: const TextStyle(),
                controller: _tabControllerList,
                tabs: [
                  ///TAB DE LISTAGEM
                  Tab(
                    child: Row(
                      children: const [
                        Icon(Icons.view_list_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Listagem",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///TAB DE DETALHE
                  Tab(
                    child: Row(
                      children: const [
                        Icon(Icons.task_alt_rounded),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Detalhe",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2 * 2,
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 9,
                child: TabBarView(
                  controller: _tabControllerList,
                  children: [
                    Card(
                      child: HomePage(
                        listPerson: listPerson,
                      ),
                    ),
                    const Center(child: UpdateData()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final messageController = TextEditingController();
  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
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
              SizedBox(
                height: 50,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Primeiro nome',
                  border: OutlineInputBorder(),
                ),
                controller: firstNameController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Segundo nome',
                  border: OutlineInputBorder(),
                ),
                controller: lastNameController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Descricao',
                  border: OutlineInputBorder(),
                ),
                controller: messageController,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, 'home');
                      },
                      child: Text('Cancelar')),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        bool response = await repository.updateData(
                            args[0],
                            firstNameController.text,
                            lastNameController.text,
                            messageController.text);

                        if (response) {
                          Navigator.popAndPushNamed(context, 'home');
                        } else {
                          throw Exception('erro');
                        }
                      },
                      child: Text('Editar'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
