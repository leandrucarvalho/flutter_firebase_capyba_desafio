import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailConfirmationPage extends StatefulWidget {
  final String email;

  const EmailConfirmationPage({Key? key, required this.email})
      : super(key: key);

  @override
  EmailConfirmationPageState createState() => EmailConfirmationPageState();
}

class EmailConfirmationPageState extends State<EmailConfirmationPage> {
  void _resendConfirmationEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        if (user.emailVerified) {
          showMessage('E-mail ja foi verificado!');
        } else {
          await user.sendEmailVerification();
          showMessage('E-mail de confirmação reenviado com sucesso!');
        }
      } else {
        showMessage('Erro: Usuário não autenticado.');
      }
    } on FirebaseAuthException catch (e) {
      showMessage(
          'Erro durante o reenvio do e-mail de confirmação: ${e.message}');
    } catch (e) {
      showMessage('Erro durante o reenvio do e-mail de confirmação: $e');
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmação de E-mail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Um e-mail de confirmação foi enviado para o seguinte endereço: ${user!.email}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              widget.email,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Por favor, verifique sua caixa de entrada e siga as instruções para confirmar seu e-mail.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _resendConfirmationEmail,
              child: Text(user.emailVerified
                  ? 'Reenviar E-mail de Confirmação'
                  : 'Enviar E-mail de Confirmação'),
            ),
          ],
        ),
      ),
    );
  }
}
