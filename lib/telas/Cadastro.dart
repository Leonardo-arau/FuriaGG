import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:furiagg/model/Usuario.dart';
import 'package:furiagg/telas/home.dart';

class Cadastro extends StatefulWidget {
  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  //Controladores
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    //Recupera dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (nome.isNotEmpty && nome.length > 3) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty && senha.length > 6) {
          setState(() {
            _mensagemErro = "";
          });

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;

          _cadastrarUsuario(usuario);
        } else {
          setState(() {
            _mensagemErro = "Preencha a Senha! digite mais de 6 caracteres";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha o E-mail utilizando @";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Nome precisa ter mais que 3 caracteres";
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
          email: usuario.email,
          password: usuario.senha,
        )
        .then((UserCredential userCredential) {
          // Obter o usuário a partir do UserCredential
          User? firebaseUser = userCredential.user;

          // Verificação se o firebaseUser não é null antes de acessar o uid
          if (firebaseUser != null) {
            // Salvar dados do usuário no Firestore
            FirebaseFirestore db = FirebaseFirestore.instance;

            // Acesso seguro usando 'firebaseUser.uid'
            db
                .collection("usuarios")
                .doc(firebaseUser.uid)
                .set(usuario.toMap());

            // Navegar para a página inicial
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
          } else {
            print("Usuário não encontrado.");
          }
        })
        .catchError((Error) {
          setState(() {
            _mensagemErro =
                "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        // Fundo com imagem personalizada
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("imagens/FuriaGG_Cadastro.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Título "criar conta"
                Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: Text(
                    "Criar nova conta",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Subtítulo
                Padding(
                  padding: EdgeInsets.only(bottom: 80),
                  child: Text(
                    "Já está cadastrado? Faça login aqui",
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(179, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: 350,
                      child: TextField(
                        controller: _controllerNome,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          filled: true,
                          fillColor: Color(0xFFD9D9D9),
                          hintText: "Nome",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
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

                // Botão de cadastrar
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: Center(
                    child: SizedBox(
                      width: 320,
                      child: ElevatedButton(
                        onPressed: () {
                          _validarCampos(); // Aqui você pode colocar a lógica de cadastrar
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    _mensagemErro,
                    style: TextStyle(color: Colors.red, fontSize: 20),
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
