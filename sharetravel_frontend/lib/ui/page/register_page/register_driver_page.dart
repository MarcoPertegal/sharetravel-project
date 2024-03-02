import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharetravel_frontend/bloc/register_driver_bloc/register_driver_bloc.dart';
import 'package:sharetravel_frontend/repository/register/register_driver/register_driver_repository.dart';
import 'package:sharetravel_frontend/repository/register/register_driver/register_driver_repository_impl.dart';
import 'package:sharetravel_frontend/ui/page/home_page.dart';

class RegisterDriverPage extends StatefulWidget {
  const RegisterDriverPage({super.key});

  @override
  State<RegisterDriverPage> createState() => _RegisterDriverPageState();
}

class _RegisterDriverPageState extends State<RegisterDriverPage> {
  final _formDriverRegister = GlobalKey<FormState>();
  final userTextController = TextEditingController();
  final passTextController = TextEditingController();
  final fullNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final personalDescriptionTextController = TextEditingController();
  final avatarTextController = TextEditingController();

  late RegisterDriverRepository registerDriverRepository;
  late RegisterDriverBloc _registerDriverBloc;

  @override
  void initState() {
    registerDriverRepository = RegisterDriverRepositoryImpl();
    _registerDriverBloc = RegisterDriverBloc(registerDriverRepository);
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
    _registerDriverBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _registerDriverBloc,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 175, 84),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<RegisterDriverBloc, RegisterDriverState>(
              builder: (context, state) {
                if (state is DoRegisterDriverSuccess) {
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomePage(), //aqui es adonde se redirije cuando se loguea
                      ),
                    );
                  }); //aqui es adonde se redirije cuando se loguea
                } else if (state is DoRegisterDriverError) {
                  return const Text('Register error');
                } else if (state is DoRegisterDriverLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(child: _buildRegisterDriverForm());
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildRegisterDriverForm() {
    return Form(
      key: _formDriverRegister,
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
            obscureText: true,
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
            maxLines: 3, // Numero de lineas
            onChanged: (value) {
              // Aqui se puede meter validación
            },
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
              fillColor: Colors.white,
            ),
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
                if (_formDriverRegister.currentState!.validate()) {
                  _registerDriverBloc.add(DoRegisterDriverEvent(
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
