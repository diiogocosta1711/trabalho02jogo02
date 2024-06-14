import 'package:flutter/material.dart';
import 'package:jogo/models/question.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Definindo as perguntas e respostas para cada nível
  final List<List<Question>> questions = [
    // Nível 1: Redes
    [
      Question(
        questionText: 'Qual é o Network ID do endereço IP 192.168.1.10 com máscara de sub-rede /24?',
        options: ['192.168.1.0', '192.168.1.1', '192.168.1.10', '192.168.0.0'],
        correctAnswer: '192.168.1.0',
      ),
      Question(
        questionText: 'Qual é o Broadcast do endereço IP 10.0.0.5 com máscara de sub-rede /8?',
        options: ['10.0.0.0', '10.255.255.255', '10.0.0.5', '10.0.0.255'],
        correctAnswer: '10.255.255.255',
      ),
      Question(
        questionText: 'Os endereços IP 172.16.5.1 e 172.16.10.1 estão no mesmo segmento de rede com máscara de sub-rede /16?',
        options: ['Sim, ambos estão na rede 172.16.0.0/16.', 'Não, estão em redes diferentes.', 'Sim, ambos estão na rede 172.16.10.0/16.', 'Não há informações suficientes para determinar.'],
        correctAnswer: 'Sim, ambos estão na rede 172.16.0.0/16.',
      ),
    ],
    // Nível 2: Sub-redes (ainda não implementado)
    [
      Question(
        questionText: 'Qual é o Network ID do endereço IP 192.168.1.130 com máscara de sub-rede 255.255.255.192?',
        options: ['192.168.1.128', '192.168.1.64', '192.168.1.192', '192.168.1.0'],
        correctAnswer: '192.168.1.128',
      ),
      Question(
        questionText: 'Qual é o Broadcast do endereço IP 172.16.4.66 com máscara de sub-rede 255.255.255.240?',
        options: ['172.16.4.79', '172.16.4.255', '172.16.4.64', '172.16.4.255'],
        correctAnswer: '172.16.4.79',
      ),
      Question(
        questionText: 'Os endereços IP 192.168.2.33 e 192.168.2.65 estão no mesmo segmento de rede com máscara de sub-rede 255.255.255.224?',
        options: ['Sim, ambos estão na rede 192.168.2.32/27.', 'Não, 192.168.2.33 está na rede 192.168.2.33/27 e 192.168.2.65 está na rede 192.168.2.64/27.', 'Sim, ambos estão na rede 192.168.2.64/27.', 'Não, estão em redes diferentes.'],
        correctAnswer: 'Não, 192.168.2.33 está na rede 192.168.2.32/27 e 192.168.2.65 está na rede 192.168.2.64/27.',
      ),
    ],
    // Nível 3: Super-redes (ainda não implementado)
    [
      Question(
        questionText: 'Qual é o Network ID do endereço IP 198.51.100.14 com máscara de sub-rede 255.255.252.0?',
        options: ['198.51.100.0', '198.51.100.8', '198.51.100.12', '198.51.100.14'],
        correctAnswer: '198.51.100.0',
      ),
      Question(
        questionText: 'Qual é o Broadcast do endereço IP 203.0.113.75 com máscara de sub-rede 255.255.248.0 ou /21?',
        options: ['203.0.119.255', '203.0.113.255', '203.0.115.255', '203.0.127.255'],
        correctAnswer: '203.0.119.255',
      ),
      Question(
        questionText: 'Os endereços IP 192.0.2.35 e 192.0.2.100 estão no mesmo segmento de rede com máscara de sub-rede 255.255.240.0?',
        options: ['Sim, ambos estão na rede 192.0.0.0/20.', 'Não, estão em redes diferentes.', 'Sim, ambos estão na rede 192.0.2.0/24.', 'Não há informações suficientes para determinar.'],
        correctAnswer: 'Sim, ambos estão na rede 192.0.0.0/20.',
      ),
    ],
  ];

  // Índices para rastrear o nível atual e a pergunta atual
  int currentLevelIndex = 0;
  int currentQuestionIndex = 0;

  // Função para responder à pergunta
  void answerQuestion(String selectedAnswer) {
    String correctAnswer = questions[currentLevelIndex][currentQuestionIndex].correctAnswer;

    if (selectedAnswer == correctAnswer) {
      print('Resposta correta!');
      // Implemente a lógica de pontuação aqui, se necessário
    } else {
      print('Resposta incorreta!');
    }

    // Avança para a próxima pergunta
    if (currentQuestionIndex < questions[currentLevelIndex].length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Se for a última pergunta do nível, avança para o próximo nível ou finaliza o jogo
      if (currentLevelIndex < questions.length - 1) {
        setState(() {
          currentLevelIndex++;
          currentQuestionIndex = 0; // Reinicia para a primeira pergunta do novo nível
        });
      } else {
        // Fim do jogo
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Fim do jogo!'),
            content: Text('Parabéns! Você completou todos os níveis.'),
            actions: <Widget>[
              TextButton(
                child: Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz de Redes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Exibe a pergunta atual
          Text(
            questions[currentLevelIndex][currentQuestionIndex].questionText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          // Exibe as opções de resposta
          Column(
            children: questions[currentLevelIndex][currentQuestionIndex].options.map((option) {
              return ElevatedButton(
                onPressed: () {
                  answerQuestion(option);
                },
                child: Text(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}