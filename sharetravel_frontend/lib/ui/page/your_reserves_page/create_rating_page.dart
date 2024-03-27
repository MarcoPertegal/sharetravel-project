import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharetravel_frontend/bloc/create_rating/create_rating_bloc.dart';
import 'package:sharetravel_frontend/bloc/create_trip_bloc/create_trip_bloc.dart';
import 'package:sharetravel_frontend/repository/create_rating/create_rating_repository.dart';
import 'package:sharetravel_frontend/repository/create_rating/create_rating_repository_impl.dart';
import 'package:sharetravel_frontend/ui/page/confirmation_page.dart';
import 'package:sharetravel_frontend/ui/page/error_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CreateRatingPage extends StatefulWidget {
  final String driverId;
  const CreateRatingPage({Key? key, required this.driverId}) : super(key: key);

  @override
  State<CreateRatingPage> createState() => _CreateRatingPageState();
}

class _CreateRatingPageState extends State<CreateRatingPage> {
  final _formCreateRating = GlobalKey<FormState>();
  final feedbackTextController = TextEditingController();

  late CreateRatingRepository createRatingRepository;
  late CreateRatingBloc _createRatingBloc;

  double ratingValue = 3.0; // Valor predeterminado para la calificación

  @override
  void initState() {
    createRatingRepository = CreateRatingRepositoryImpl();
    _createRatingBloc = CreateRatingBloc(createRatingRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _createRatingBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<CreateRatingBloc, CreateRatingState>(
              builder: (context, state) {
                if (state is DoCreateRatingSuccess) {
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConfirmationPage(
                            confirmationMessage: 'Driver rated successfully'),
                      ),
                    );
                  });
                } else if (state is DoCreateRatingError) {
                  final errorMessage =
                      state.errorMessage.replaceFirst('Exception: ', '');
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ErrorPage(errorMessage: errorMessage)),
                    );
                  });
                } else if (state is DoCreateTripLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(child: _buildCreateRatingForm());
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateRatingForm() {
    return Form(
      key: _formCreateRating,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          RatingBar.builder(
            initialRating: ratingValue,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 40,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (value) {
              setState(() {
                ratingValue = value;
              });
            },
          ),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: feedbackTextController,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 175, 84), width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                labelText: 'Feedback',
                filled: true,
                fillColor: const Color.fromARGB(255, 218, 255, 232)),
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
                backgroundColor: Color.fromARGB(255, 0, 175, 84),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: const Text(
                'Send Rating',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () {
                if (_formCreateRating.currentState!.validate()) {
                  _createRatingBloc.add(DoCreateRatingEvent(ratingValue,
                      feedbackTextController.text, widget.driverId));
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
