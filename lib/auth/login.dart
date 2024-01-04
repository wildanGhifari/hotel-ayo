import 'package:flutter/material.dart';
import 'package:hotel_ayo/app.dart';
import 'package:hotel_ayo/service/login_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _controllerUsername = TextEditingController();
  final _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              height: 560,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _imageOverlay(),
                  _formContainer(),
                ],
              ),
            ),
            const Spacer(),
            const SizedBox(height: 47),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: TextButton(
                onPressed: () => {},
                child: const Text("Not a member? Sign up here"),
              ),
            )
          ],
        ),
      ),
    );
  }

  _fieldUsername() {
    return TextField(
      decoration: const InputDecoration(labelText: "Username"),
      controller: _controllerUsername,
      keyboardType: TextInputType.text,
    );
  }

  _fieldPassword() {
    return TextField(
      decoration: const InputDecoration(labelText: "Password"),
      controller: _controllerPassword,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
    );
  }

  _btnLogin() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        onPressed: () async {
          String username = _controllerUsername.text;
          String password = _controllerPassword.text;
          await LoginService().login(username, password).then(
                (value) => {
                  if (value == true)
                    {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const App()),
                      )
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              const Text('Username atau Password tidak valid!'),
                          action: SnackBarAction(
                            label: 'Retry',
                            onPressed: () {
                              _controllerUsername.text = '';
                              _controllerPassword.text = '';
                            },
                          ),
                        ),
                      ),
                    }
                },
              );
        },
        child: const Text("Login"),
      ),
    );
  }

  _formContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Text(
                "Welcome back, Let’s find a new staying experience!",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _fieldUsername(),
                  const SizedBox(height: 16),
                  _fieldPassword(),
                  const SizedBox(height: 24),
                  _btnLogin()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _imageOverlay() {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 328,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Image(
              height: double.maxFinite,
              width: double.maxFinite,
              image: NetworkImage(
                "https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8aG90ZWwlMjByb29tfGVufDB8fDB8fHww",
              ),
              fit: BoxFit.cover, //fill type of image inside aspectRatio
            ),
            Opacity(
              opacity: 0.64,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 384,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade900,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
