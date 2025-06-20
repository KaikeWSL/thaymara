import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(BrincadeiraApp());
}

class BrincadeiraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questionário Interativo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TelaInicial(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  String? erroNome;
  String? erroIdade;
  bool nomeAlterado = false;

  final String nomeEsperado = "Thaymara da Silva Santos";
  final int idadeCorreta = 23;

  // Para a pergunta do amor
  String? respostaAmor;
  final List<String> alternativasAmor = [
    "Sim", "Com certeza", "Óbvio", "Lógico", "Sem dúvidas"
  ];

  @override
  void initState() {
    super.initState();
    // Adicionar listener para o campo da idade
    _idadeController.addListener(() {
      if (!nomeAlterado && _nomeController.text.trim().toLowerCase() == nomeEsperado.toLowerCase()) {
        setState(() {
          nomeAlterado = true;
          _nomeController.text = "Thaymara Santos da Silva";
        });
      }
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

  void _avancar() {
    String nome = _nomeController.text.trim();
    String idade = _idadeController.text.trim();

    // Limpar erros anteriores
    setState(() {
      erroNome = null;
      erroIdade = null;
    });

    // Validar se os campos estão preenchidos
    if (nome.isEmpty || idade.isEmpty) {
      setState(() {
        if (nome.isEmpty) erroNome = "Preencha o nome!";
        if (idade.isEmpty) erroIdade = "Preencha a idade!";
      });
      return;
    }

    // Validar nome (aceita apenas o original)
    String nomeOriginal = "Thaymara da Silva Santos";
    if (nome.toLowerCase() != nomeOriginal.toLowerCase()) {
      setState(() {
        erroNome = "esse não é seu nome gatinha!";

        nomeAlterado = false; // Impede que o listener preencha novamente
      });
      return;
    }

    // Validar idade
    int? idadeNum = int.tryParse(idade);
    if (idadeNum == null || idadeNum != idadeCorreta) {
      setState(() {
        erroIdade = "vc não tem essa idade gatinha!"; 
        _idadeController.clear();
      });
      return;
    }

    // Se chegou até aqui, os dados estão corretos
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TelaAutoAvaliacao(nomeOriginal: nome, numeroFormulario: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Formulário 1 de 100", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10),
              Text("(feito com amor e carinho)", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              SizedBox(height: 20),
              Text(
                "Conhecer você foi a melhor coisa que aconteceu na minha vida! ❤️",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.pink[600], fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: "Digite seu nome completo",
                  border: OutlineInputBorder(),
                  errorText: erroNome,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _idadeController,
                decoration: InputDecoration(
                  labelText: "Digite sua idade",
                  border: OutlineInputBorder(),
                  errorText: erroIdade,
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _avancar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text("Avançar", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaAutoAvaliacao extends StatefulWidget {
  final String nomeOriginal;
  final int numeroFormulario;

  TelaAutoAvaliacao({required this.nomeOriginal, required this.numeroFormulario});

  @override
  _TelaAutoAvaliacaoState createState() => _TelaAutoAvaliacaoState();
}

class _TelaAutoAvaliacaoState extends State<TelaAutoAvaliacao> {
  final _notaController = TextEditingController();
  String? erroNota;
  bool nota999 = false;

  void _confirmarNota() {
    String notaStr = _notaController.text.trim();
    double? nota = double.tryParse(notaStr);

    if (notaStr.isEmpty) {
      setState(() => erroNota = "Por favor, digite uma nota!");
      return;
    }
    if (nota == null || nota < 0 || nota > 10) {
      setState(() => erroNota = "Digite uma nota entre 0 e 10!");
      return;
    }
    if (nota < 10) {
      setState(() => erroNota = "nota $nota gatinha? vc é muito mais bonita! tente novamente");
      return;
    }
    setState(() {
      nota999 = true;
      _notaController.text = "99999";
    });
    // Não avança automaticamente mais
  }

  void _avancar() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => TelaJogoMemoria(numeroFormulario: widget.numeroFormulario + 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Formulário ${widget.numeroFormulario} de 100", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10),
              Text("Perfeito meu amor", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text(
                "Você é a pessoa mais linda que já conheci!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.pink[600], fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 30),
              Text("agora em uma escala de 0 a 10, qual seu nivel de beleza?"),
              SizedBox(height: 20),
              TextField(
                controller: _notaController,
                enabled: !nota999,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: "Nota",
                  border: OutlineInputBorder(),
                  fillColor: nota999 ? Colors.green[50] : null,
                  filled: nota999,
                ),
              ),
              if (erroNota != null) ...[
                SizedBox(height: 10),
                Text(erroNota!, style: TextStyle(color: Colors.orange)),
              ],
              SizedBox(height: 30),
              if (!nota999)
                ElevatedButton(
                  onPressed: _confirmarNota,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text("Confirmar Nota", style: TextStyle(fontSize: 16)),
                ),
              if (nota999) ...[
                Text("mudei sua nota para 99999! acho mais justo!", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _avancar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text("Avançar", style: TextStyle(fontSize: 16)),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class TelaJogoMemoria extends StatefulWidget {
  final int numeroFormulario;
  TelaJogoMemoria({required this.numeroFormulario});
  @override
  _TelaJogoMemoriaState createState() => _TelaJogoMemoriaState();
}

class _TelaJogoMemoriaState extends State<TelaJogoMemoria> {
  List<String> cartas = [
    '❤️', '💕', '💖', '💗', '💓', '💝', '💘', '💞',
    '💟', '❣️', '❤️‍🩹', '❤️‍🔥'
  ];
  List<String> cartasEmbaralhadas = [];
  List<int> cartasViradas = [];
  List<int> cartasEncontradas = [];
  bool podeClicar = true;

  @override
  void initState() {
    super.initState();
    cartasEmbaralhadas = [...cartas, ...cartas];
    cartasEmbaralhadas.shuffle();
  }

  void virarCarta(int index) {
    if (!podeClicar || cartasViradas.contains(index) || cartasEncontradas.contains(index)) {
      return;
    }

    setState(() {
      cartasViradas.add(index);
    });

    if (cartasViradas.length == 2) {
      podeClicar = false;
      if (cartasEmbaralhadas[cartasViradas[0]] == cartasEmbaralhadas[cartasViradas[1]]) {
        cartasEncontradas.addAll(cartasViradas);
        cartasViradas.clear();
        podeClicar = true;
        
        if (cartasEncontradas.length == cartasEmbaralhadas.length) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => TelaCadeadoChaves(numeroFormulario: widget.numeroFormulario + 1)),
            );
          });
        }
      } else {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            cartasViradas.clear();
            podeClicar = true;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text("Formulário ${widget.numeroFormulario} de 100", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 30),
              Text(
                "Jogo da Memória do Amor! 💕",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Encontre os pares de corações meu amor! ❤️",
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: cartasEmbaralhadas.length,
                  itemBuilder: (context, index) {
                    bool estaVirada = cartasViradas.contains(index);
                    bool foiEncontrada = cartasEncontradas.contains(index);
                    return GestureDetector(
                      onTap: () => virarCarta(index),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: foiEncontrada ? Colors.pink[100] : (estaVirada ? Colors.white : Colors.pink[300]),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.pink[400]!),
                        ),
                        child: Center(
                          child: Text(
                            foiEncontrada || estaVirada ? cartasEmbaralhadas[index] : '?',
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaCadeadoChaves extends StatefulWidget {
  final int numeroFormulario;
  TelaCadeadoChaves({required this.numeroFormulario});
  @override
  _TelaCadeadoChavesState createState() => _TelaCadeadoChavesState();
}

class _TelaCadeadoChavesState extends State<TelaCadeadoChaves> with SingleTickerProviderStateMixin {
  int chaveCerta = 6; // índice da chave correta (penúltima chave de 8)
  bool aberto = false;
  String? erro;
  late AnimationController _controller;
  late Animation<double> _coracaoAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _coracaoAnim = Tween<double>(begin: 1, end: 1.2).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void tentarAbrir(int idx) {
    if (idx == chaveCerta) {
      setState(() {
        aberto = true;
        erro = null;
      });
      _controller.forward(from: 0);
      Future.delayed(Duration(milliseconds: 900), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TelaCorFavorita(numeroFormulario: widget.numeroFormulario + 1),
          ),
        );
      });
    } else {
      setState(() {
        erro = "Essa chave não encaixa! Tente outra.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Formulário ${widget.numeroFormulario} de 100", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10),
              Text("Ache a chave do meu coração", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink[600])),
              SizedBox(height: 20),
              AnimatedBuilder(
                animation: _coracaoAnim,
                builder: (context, child) {
                  return Transform.scale(
                    scale: aberto ? _coracaoAnim.value : 1,
                    child: Icon(
                      Icons.favorite,
                      size: 70,
                      color: aberto ? Colors.red : Colors.grey[400],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text("Qual chave abre o meu coração?", style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Wrap(
                spacing: 12,
                children: List.generate(8, (idx) => ElevatedButton(
                  onPressed: aberto ? null : () => tentarAbrir(idx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: aberto ? Colors.green : Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Icon(Icons.vpn_key, size: 32),
                )),
              ),
              if (erro != null) ...[
                SizedBox(height: 20),
                Text(erro!, style: TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class TelaCorFavorita extends StatefulWidget {
  final int numeroFormulario;
  TelaCorFavorita({required this.numeroFormulario});
  @override
  _TelaCorFavoritaState createState() => _TelaCorFavoritaState();
}

class _TelaCorFavoritaState extends State<TelaCorFavorita> {
  String? resposta;
  String? erro;
  final List<String> opcoes = [
    "Azul", "Roxo", "Rosa", "Verde", "Amarelo", "Vermelho", "Preto", "Branco", "Laranja", "Marrom", "Cinza", "Lilás", "Turquesa", "Bege"
  ];

  @override
  void initState() {
    super.initState();
    opcoes.shuffle();
  }

  void responder() {
    if (resposta == null) {
      setState(() { erro = "Selecione uma cor!"; });
      return;
    }
    if (resposta == "Roxo") {
      setState(() { erro = null; });
      Future.delayed(Duration(milliseconds: 800), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TelaFlores(numeroFormulario: widget.numeroFormulario + 1),
          ),
        );
      });
    } else {
      setState(() { erro = "Hmm... não foi essa que vc me falou!"; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Formulário ${widget.numeroFormulario} de 100", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10),
              Text("Qual sua cor favorita?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              DropdownButtonFormField<String>(
                value: resposta,
                items: opcoes.map((cor) => DropdownMenuItem(
                  value: cor,
                  child: Text(cor),
                )).toList(),
                onChanged: (val) {
                  setState(() {
                    resposta = val;
                    erro = null;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Selecione a cor",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: responder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text("Avançar", style: TextStyle(fontSize: 16)),
              ),
              if (erro != null) ...[
                SizedBox(height: 20),
                Text(erro!, style: TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class TelaFlores extends StatefulWidget {
  final int numeroFormulario;
  TelaFlores({required this.numeroFormulario});
  @override
  _TelaFloresState createState() => _TelaFloresState();
}

class _TelaFloresState extends State<TelaFlores> {
  List<String> opcoes = [
    "Rosa vermelha",
    "Girassol",
    "Rosa branca",
    "Margarida",
    "Tulipa",
    "Orquídea",
    "Lírio",
    "Violeta",
    "Dália",
    "Jasmim",
    "Camélia",
    "Crisântemo",
    "Hortênsia",
    "Azaleia",
    "Amarílis"
  ];
  Set<String> selecionadas = {};
  String? erro;

  @override
  void initState() {
    super.initState();
    opcoes.shuffle();
  }

  void confirmar() {
    if (selecionadas.contains("Rosa vermelha") && selecionadas.contains("Girassol") && selecionadas.contains("Rosa branca") && selecionadas.length == 3) {
      setState(() { erro = null; });
      Future.delayed(Duration(milliseconds: 800), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TelaLabirintoCaminho(numeroFormulario: widget.numeroFormulario + 1),
          ),
        );
      });
    } else {
      setState(() { erro = "Tem que escolher as três certas!"; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Formulário ${widget.numeroFormulario} de 100", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10),
              Text("Quais foram as três primeiras flores que te dei?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Container(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: opcoes.map((flor) => CheckboxListTile(
                      value: selecionadas.contains(flor),
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            selecionadas.add(flor);
                          } else {
                            selecionadas.remove(flor);
                          }
                        });
                      },
                      title: Text(flor),
                      controlAffinity: ListTileControlAffinity.leading,
                    )).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: confirmar,
                child: Text("Confirmar"),
              ),
              if (erro != null) ...[
                SizedBox(height: 10),
                Text(erro!, style: TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class TelaLabirintoCaminho extends StatefulWidget {
  final int numeroFormulario;
  TelaLabirintoCaminho({required this.numeroFormulario});
  @override
  _TelaLabirintoCaminhoState createState() => _TelaLabirintoCaminhoState();
}

class _TelaLabirintoCaminhoState extends State<TelaLabirintoCaminho> {
  final int gridSize = 6;
  final List<List<bool>> obstaculos = [
    [false, true,  false, true,  false, false],
    [false, true,  false, true,  true,  false],
    [false, false, false, false, true,  false],
    [true,  true,  true,  false, false, false],
    [false, false, false, true,  true,  false],
    [false, true,  false, false, true,  false],
  ];
  List<List<bool>> caminhoPercorrido = [];
  int posX = 0, posY = 0;
  String? erro;
  bool venceu = false;

  @override
  void initState() {
    super.initState();
    resetarCaminho();
  }

  void resetarCaminho() {
    caminhoPercorrido = List.generate(gridSize, (_) => List.filled(gridSize, false));
    posX = 0;
    posY = 0;
    caminhoPercorrido[posY][posX] = true;
    venceu = false;
    erro = null;
    setState(() {});
  }

  void clicar(int y, int x) {
    if (venceu) return;
    if ((x - posX).abs() + (y - posY).abs() != 1) return;
    if (obstaculos[y][x]) {
      setState(() {
        erro = "Opa! Tem um obstaculo aqui! Tente de novo.";
      });
      Future.delayed(Duration(seconds: 1), resetarCaminho);
      return;
    }
    caminhoPercorrido[y][x] = true;
    posX = x;
    posY = y;
    setState(() {
      erro = null;
    });
    if (x == gridSize - 1 && y == gridSize - 1) {
      venceu = true;
      Future.delayed(Duration(milliseconds: 800), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TelaNos(numeroFormulario: widget.numeroFormulario + 1),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Formulário ${widget.numeroFormulario} de 100", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10),
              Text("Labirinto do Amor! Chegue ate meu coracao!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink[600])),
              SizedBox(height: 30),
              Container(
                width: 360,
                height: 360,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridSize,
                  ),
                  itemCount: gridSize * gridSize,
                  itemBuilder: (context, idx) {
                    int y = idx ~/ gridSize;
                    int x = idx % gridSize;
                    bool isObstaculo = obstaculos[y][x];
                    bool isCaminho = caminhoPercorrido[y][x];
                    bool isCoracao = (x == gridSize - 1 && y == gridSize - 1);
                    return GestureDetector(
                      onTap: isObstaculo || venceu ? null : () => clicar(y, x),
                      child: Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: isCoracao
                              ? Colors.red
                              : isObstaculo
                                  ? Colors.grey[400]
                                  : isCaminho
                                      ? Colors.blue[200]
                                      : Colors.white,
                          border: Border.all(color: Colors.pink[200]!, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: isCoracao
                              ? Icon(Icons.favorite, color: Colors.white, size: 32)
                              : isObstaculo
                                  ? Icon(Icons.block, color: Colors.white)
                                  : isCaminho
                                      ? Icon(Icons.directions_walk, color: Colors.blue[800])
                                      : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (erro != null) ...[
                SizedBox(height: 20),
                Text(erro!, style: TextStyle(color: Colors.red)),
              ],
              SizedBox(height: 20),
              Text("Dica: so pode andar para o lado ou para baixo/cima, e nao pode passar pelos obstaculos!", style: TextStyle(fontSize: 14, color: Colors.grey[700]), textAlign: TextAlign.center),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: resetarCaminho,
                child: Text("Recomecar caminho"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaNos extends StatefulWidget {
  final int numeroFormulario;
  TelaNos({required this.numeroFormulario});
  @override
  _TelaNosState createState() => _TelaNosState();
}

class _TelaNosState extends State<TelaNos> {
  List<bool> nos = List.filled(5, true);

  void desfazerNo(int idx) {
    setState(() {
      nos[idx] = false;
    });
    if (nos.every((n) => !n)) {
      Future.delayed(Duration(milliseconds: 600), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => TelaCartaFinal(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Último desafio!", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10),
              Text("A carta está cheia de nós! Desfaça todos para abrir.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              Wrap(
                spacing: 24,
                children: List.generate(5, (idx) => IconButton(
                  icon: Icon(Icons.emoji_objects, size: 40, color: nos[idx] ? Colors.orange : Colors.grey[300]),
                  onPressed: nos[idx] ? () => desfazerNo(idx) : null,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaCartaFinal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail, size: 60, color: Colors.red[400]),
              SizedBox(height: 20),
              Text("Carta de Amor", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink[600])),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8)],
                ),
                child: Text(
                  "Amar voce e algo que simplesmente acontece, sem esforco, sem motivo, so acontece, tem dias que so de lembrar do seu sorriso eu fico bem, tem momentos em que a sua voz e tudo que eu precisava ouvir.\nnao e sobre palavras bonitas ou grandes gestos, e sobre como voce me faz sentir leve, feliz e em paz so por existir, pois nao importa o tempo ou distancia, voce esta sempre nos meu coracao",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.pink[800]),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PerguntaKaikeAmaThaymara(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text("Avançar", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PerguntaKaikeAmaThaymara extends StatefulWidget {
  @override
  State<PerguntaKaikeAmaThaymara> createState() => _PerguntaKaikeAmaThaymaraState();
}

class _PerguntaKaikeAmaThaymaraState extends State<PerguntaKaikeAmaThaymara> {
  String? resposta;
  final List<String> alternativas = [
    "Sim", "Com certeza", "Óbvio", "Lógico", "Sem dúvidas"
  ];

  void _avancar() {
    if (resposta != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TelaFinalCompleta(numeroFormulario: 99),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("O Kaike ama a Thaymara?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink[600])),
              SizedBox(height: 10),
              Column(
                children: alternativas.map((alt) => RadioListTile<String>(
                  title: Text(alt),
                  value: alt,
                  groupValue: resposta,
                  onChanged: (val) {
                    setState(() {
                      resposta = val;
                    });
                  },
                  activeColor: Colors.pink[400],
                )).toList(),
              ),
              SizedBox(height: 10),
              if (resposta != null)
                Text(
                  "Vc esta certa amor, ele ama mesmo",
                  style: TextStyle(
                    color: Colors.pink[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              if (resposta != null)
                SizedBox(height: 10),
              ElevatedButton(
                onPressed: resposta != null ? _avancar : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text("Avançar", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaFinalCompleta extends StatelessWidget {
  final int numeroFormulario;
  TelaFinalCompleta({required this.numeroFormulario});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Formulário $numeroFormulario de 100", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10),
              Text("", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 40),
              Text(
                "meu amor, você é incrível!\n\n"
                "Espero que tenha gostado de todas essas brincadeiras!\n\n"
                "Agora uma última pergunta",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TelaPerguntaFinal(nomeExibido: "Thaymara", numeroFormulario: numeroFormulario + 1),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text("Última pergunta!", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaPerguntaFinal extends StatefulWidget {
  final String nomeExibido;
  final int numeroFormulario;
  TelaPerguntaFinal({required this.nomeExibido, required this.numeroFormulario});

  @override
  _TelaPerguntaFinalState createState() => _TelaPerguntaFinalState();
}

class _TelaPerguntaFinalState extends State<TelaPerguntaFinal> with TickerProviderStateMixin {
  double naoX = 0, naoY = 0;
  int movimentos = 0;
  final Random random = Random();
  late AnimationController _animationController;
  late Animation<double> _animationX;
  late Animation<double> _animationY;
  bool posicaoInicialDefinida = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    // A posição inicial será definida no primeiro build
  }

  void definirPosicaoInicial(BuildContext context) {
    if (posicaoInicialDefinida) return;
    final screenWidth = MediaQuery.of(context).size.width;
    final simButtonWidth = 120.0;
    final naoButtonWidth = 80.0;
    final centerX = (screenWidth - simButtonWidth) / 2;
    naoX = centerX + simButtonWidth + 20; // 20 de espaço entre os botões
    naoY = 370; // altura aproximada do botão SIM
    posicaoInicialDefinida = true;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void moverBotaoNao() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double novaX = random.nextDouble() * (screenWidth - 100);
    double novaY = random.nextDouble() * (screenHeight - 200);
    novaX = novaX.clamp(0.0, screenWidth - 100);
    novaY = novaY.clamp(100.0, screenHeight - 200);
    setState(() {
      naoX = novaX;
      naoY = novaY;
      movimentos++;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    definirPosicaoInicial(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Formulário ${widget.numeroFormulario} de 100", style: TextStyle(color: Colors.grey)),
                SizedBox(height: 10),
                Text("", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                Text("Uma última pergunta...", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 40),
                Text("vamos sair essa semana?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 60),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      minimumSize: Size(120, 50),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TelaFinalReal(),
                        ),
                      );
                    },
                    child: Text("SIM", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 30),
                if (movimentos >= 3 && movimentos < 6)
                  Text("Persistente... Ainda tentando clicar em 'Não'?", style: TextStyle(color: Colors.orange)),
                if (movimentos >= 6 && movimentos < 10)
                  Text("Teimosa! Ja percebeu que o 'Não' nao quer ficar parado?", style: TextStyle(color: Colors.orange)),
                if (movimentos >= 10)
                  Text("Desistiu? Que tal clicar no 'SIM' entao?", style: TextStyle(color: Colors.orange)),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: naoX,
            top: naoY,
            child: GestureDetector(
              onTap: moverBotaoNao,
              child: MouseRegion(
                onEnter: (_) => moverBotaoNao(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    "Não",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TelaFinalReal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Então está combinado, meu amor!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[700])),
              SizedBox(height: 20),
              Text(
                "Te pego sábado às 16h!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),
              Text("💕 amo vc meu amor! 💕", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.pink[600])),
              SizedBox(height: 40),
              Text(
                "Conhecer você foi a melhor coisa que me aconteceu!\n\n"
                "Cada momento ao seu lado é especial.\n\n"
                "Cada sentimento é real.\n\n"
                "Amo exatamente quem você é! ❤️\n\n"
                "Voce é o meu amor, e um dia vou te chamar de minha!\n\n"
                "E lembre-se: vc tem alguem que realmente ama você!\n\n",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TelaFinalMensagem(),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text("finalizar!", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaFinalMensagem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail, size: 60, color: Colors.purple[400]),
              SizedBox(height: 20),
              Text(
                "Isso demorou um pouco para terminar, mas foi feito com muito carinho e so pra voce, amor.\nPode nao estar perfeito, mas foi feito com o coracao, com a intencao mais sincera de te arrancar um sorriso e mostrar o quanto voce significa pra mim. 💜",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.pink[800]),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text("Fechar", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}