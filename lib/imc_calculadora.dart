import 'package:flutter/material.dart';

import 'pessoa.dart';

class IMCCalculadora extends StatefulWidget {
  const IMCCalculadora({super.key});

  @override
  State<IMCCalculadora> createState() => _IMCCalculadoraState();
}

class _IMCCalculadoraState extends State<IMCCalculadora> {
  var nomeController = TextEditingController();
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  List<String> results = [];

  String classificacao(double resultado) {
    if (resultado < 16) {
      return "Cuida, magreza grave!";
    } else if (resultado >= 16 && resultado < 17) {
      return "Magreza moderada, comer mais";
    } else if (resultado >= 17 && resultado < 18.5) {
      return "Magreza leve, tá feio ainda!";
    } else if (resultado >= 18.5 && resultado < 25) {
      return "Está saudável mas pode malhar um pouquinho!";
    } else if (resultado >= 25 && resultado < 30) {
      return "Está engordando, fazer exercício e fechar a boca!";
    } else if (resultado >= 30 && resultado < 35) {
      return "Obesidade grau I, pode parar que vai dar problema!";
    } else if (resultado >= 35 && resultado < 40) {
      return "Obesidade grau II, pode correr para o hospital!";
    } else {
      return "Obesidade grau III, procure tratamento urgente!";
    }
  }

  void calcularIMC(Pessoa pessoa) {
    double bmi = pessoa.peso / (pessoa.altura * pessoa.altura);
    String result =
        '${pessoa.nome}: IMC = ${bmi.toStringAsFixed(2)} - ${classificacao(bmi)}';

    setState(() {
      results.add(result);
      nomeController.clear();
      pesoController.clear();
      alturaController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: nomeController,
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
          TextField(
            controller: pesoController,
            decoration: const InputDecoration(labelText: 'Peso (kg)'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: alturaController,
            decoration: const InputDecoration(labelText: 'Altura (m)'),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: () {
              String nome = nomeController.text;
              double peso = double.tryParse(pesoController.text) ?? 0;
              double altura = double.tryParse(alturaController.text) ?? 0;

              if (nome.isNotEmpty && peso > 0 && altura > 0) {
                Pessoa pessoa = Pessoa(nome, peso, altura);
                calcularIMC(pessoa);
              }
            },
            child: const Text('Calcular IMC'),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(results[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
