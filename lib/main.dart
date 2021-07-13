import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: ListaCompras(),
    );
  }
}

class ListaCompras extends StatefulWidget {
  @override
  _ListaComprasState createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  final List<String> item = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Lista De Compras')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ListView.builder(
              itemCount: item.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(item[index]),
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      item.removeAt(index);
                    });
                  },
                  direction: DismissDirection.endToStart,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            '${item[index]}',
                            style:
                                TextStyle(fontSize: 22, fontFamily: 'Tahoma'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 3),
                        child: SizedBox(
                          height: 3,
                        ),
                      ),
                      Divider(height: 2),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          redirectToNewPage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void redirectToNewPage(context) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => FormPage(),
      ),
    )
        .then((value) {
      print(value);
      if (value != null) {
        setState(() {
          item.add(value);
        });
      }
    });
  }
}

class FormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Qual item você precisa?         "),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: itemController,
                  onSaved: (value) {
                    itemController.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este campo é obrigatório!';
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print(itemController.text);
                        Navigator.of(context).pop(itemController.text);
                      }
                    },
                    child: Text(
                      'Salvar',
                      style: TextStyle(fontSize: 15),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
