import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() => print("Valor alterado"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            child: Center(
              child: Text('Container grande para testar problemas de rolagem'),
            ),
          ),
          //TELA DE ASSINATURA
          Signature(
            controller: _controller,
            height: 300,
            backgroundColor: Colors.lightBlueAccent,
          ),
          //BOTÕES APROVADO E APAGAR
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //MOSTRAR IMAGEM EXPORTADA EM NOVA ROTA
                IconButton(
                  icon: const Icon(Icons.check),
                  color: Colors.blue,
                  onPressed: () async {
                    if (_controller.isNotEmpty) {
                      var data = await _controller.toPngBytes();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Scaffold(
                              appBar: AppBar(),
                              body: Center(
                                  child: Container(
                                      color: Colors.green[300], child: Image.memory(data))),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
                //LIMPAR TELA
                IconButton(
                  icon: const Icon(Icons.clear),
                  color: Colors.blue,
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            child: Center(
              child: Text('Container grande para testar problemas de rolagem'),
            ),
          ),
        ],
      ),
    );
  }
}
