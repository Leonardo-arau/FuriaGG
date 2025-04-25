import 'package:flutter/material.dart';

// Tela de login
class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Fundo com imagem personalizada
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("imagens/FuriaGG_Prototipo.jpg"),
            fit: BoxFit.cover,
          )
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
                      fontSize: 32,
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
                          )
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
                        )
                      ),
                    ),
                  ),
                ),

                // Botão de login
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom:10),
                  child: Center(
                  child: SizedBox(
                    width: 320,
                    child: ElevatedButton(
                      onPressed: () {
                        // Aqui você pode colocar a lógica de login
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
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
                        color: const Color.fromARGB(255, 3, 3, 3)
                      ),
                    ),
                    onTap: () {
                      // Aqui você pode redirecionar para a tela de cadastro
                    },
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
