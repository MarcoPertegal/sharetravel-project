import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharetravel_frontend/bloc/login_bloc/login_bloc.dart';
import 'package:sharetravel_frontend/repository/auth/auth_repository.dart';
import 'package:sharetravel_frontend/repository/auth/auth_repository_impl.dart';
import 'package:sharetravel_frontend/ui/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formLogin = GlobalKey<FormState>();
  final userTextController = TextEditingController();
  final passTextController = TextEditingController();

  late AuthRepository authRepository;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _loginBloc = LoginBloc(authRepository);
    super.initState();
  }

  @override
  void dispose() {
    userTextController.dispose();
    passTextController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _loginBloc,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 175, 84),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<LoginBloc, LoginState>(
            buildWhen: (context, state) {
              return state is LoginInitial ||
                  state is DoLoginSuccess ||
                  state is DoLoginError ||
                  state is DoLoginLoading;
            },
            builder: (context, state) {
              if (state is DoLoginSuccess) {
                return const Text(
                    'Login success'); //aqui es adonde se redirije cuando se loguea
              } else if (state is DoLoginError) {
                return const Text('Login error');
              } else if (state is DoLoginLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Center(child: _buildLoginForm());
            },
            listener: (BuildContext context, LoginState state) {},
          ),
        ),
      ),
    );
  }

  _buildLoginForm() {
    return Form(
      key: _formLogin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/sharetravel_logo.png',
            height: 300,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: userTextController,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 252, 163, 17), width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                labelText: 'Username',
                filled: true,
                fillColor: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: passTextController,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 252, 163, 17), width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: double.infinity,
            height: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 252, 163, 17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () {
                if (_formLogin.currentState!.validate()) {
                  _loginBloc.add(DoLoginEvent(
                      userTextController.text, passTextController.text));
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Center(
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                          color: Color.fromARGB(255, 252, 163, 17),
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
