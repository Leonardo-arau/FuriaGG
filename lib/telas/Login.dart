import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furiagg/model/Usuario.dart';
import 'package:furiagg/telas/Cadastro.dart';
import 'package:furiagg/telas/home.dart';

// Tela de login
class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty) {
        setState(() {
          _mensagemErro = "";
        });

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario(usuario);
      } else {
        setState(() {
          _mensagemErro = "Preencha a Senha!";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o E-mail utilizando @";
      });
    }
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
          email: usuario.email,
          password: usuario.senha,
        )
        .then((firebaseUser) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        })
        .catchError((Error) {
          setState(() {
            _mensagemErro =
                "Erro ao autenticar usuário, verifique e-mail e senha e tente novamente!";
          });
        });
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();

    User? usuarioLogado = auth.currentUser;
    if (usuarioLogado != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Fundo com imagem personalizada
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("imagens/FuriaGG_Prototipo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Logo da empresa/app
                Padding(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Image.asset(
                    "imagens/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),

                // Título "Login"
                Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Subtítulo "Entre para continuar"
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Entre para continuar",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(179, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Campo de e-mail
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: 350,
                      child: TextField(
                        controller: _controllerEmail,
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          filled: true,
                          fillColor: Color(0xFFD9D9D9),
                          hintText: "E-mail",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Campo de senha
                Center(
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      controller: _controllerSenha,
                      obscureText: true,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        filled: true,
                        fillColor: Color(0xFFD9D9D9),
                        hintText: "Senha",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),

                // Botão de login
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: Center(
                    child: SizedBox(
                      width: 320,
                      child: ElevatedButton(
                        onPressed: () {
                          _validarCampos(); // Aqui você pode colocar a lógica de login
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Log-in",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Link para cadastro
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Nâo tem conta? Cadastre-se!",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 3, 3, 3),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cadastro()),
                      ); // Aqui você pode redirecionar para a tela de cadastro
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
