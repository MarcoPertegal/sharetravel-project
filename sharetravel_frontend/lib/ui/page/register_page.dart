import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharetravel_frontend/bloc/register_bloc/register_bloc.dart';
import 'package:sharetravel_frontend/repository/register/register_repository.dart';
import 'package:sharetravel_frontend/repository/register/register_repository_impl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formRegister = GlobalKey<FormState>();
  final userTextController = TextEditingController();
  final passTextController = TextEditingController();
  final fullNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final personalDescriptionTextController = TextEditingController();
  final avatarTextController = TextEditingController();

  late RegisterRepository registerRepository;
  late RegisterBloc _registerBloc;

  @override
  void initState() {
    registerRepository = RegisterRepositoryImpl();
    _registerBloc = RegisterBloc(registerRepository);
    super.initState();
  }

  @override
  void dispose() {
    userTextController.dispose();
    passTextController.dispose();
    fullNameTextController.dispose();
    emailTextController.dispose();
    phoneNumberTextController.dispose();
    personalDescriptionTextController.dispose();
    avatarTextController.dispose();
    _registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _registerBloc,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 175, 84),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocConsumer<RegisterBloc, RegisterState>(
              buildWhen: (context, state) {
                return state is RegisterInitial ||
                    state is DoRegisterSuccess ||
                    state is DoRegisterError ||
                    state is DoRegisterLoading;
              },
              builder: (context, state) {
                if (state is DoRegisterSuccess) {
                  return const Text(
                      'Register success'); //aqui es adonde se redirije cuando se loguea
                } else if (state is DoRegisterError) {
                  return const Text('Register error');
                } else if (state is DoRegisterLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(child: _buildLoginForm());
              },
              listener: (BuildContext context, RegisterState state) {},
            ),
          ),
        ),
      ),
    );
  }

  _buildLoginForm() {
    return Form(
      key: _formRegister,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/sharetravel_logo_text.png',
            height: 100,
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
          TextFormField(
            controller: fullNameTextController,
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
                labelText: 'Full name',
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
            controller: emailTextController,
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
                labelText: 'Email',
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
            controller: phoneNumberTextController,
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
                labelText: 'Phone Number',
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
            controller: personalDescriptionTextController,
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
                labelText: 'Personal Description',
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
            controller: avatarTextController,
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
                labelText: 'Avatar',
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
                'Sign Up',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () {
                if (_formRegister.currentState!.validate()) {
                  _registerBloc.add(DoRegisterEvent(
                      userTextController.text,
                      passTextController.text,
                      fullNameTextController.text,
                      emailTextController.text,
                      phoneNumberTextController.text,
                      personalDescriptionTextController.text,
                      avatarTextController.text));
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
