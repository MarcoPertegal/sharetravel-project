import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharetravel_frontend/bloc/user_details_bloc/user_details_bloc.dart';
import 'package:sharetravel_frontend/model/response/user_details_response.dart';
import 'package:sharetravel_frontend/repository/user_details/user_details_repository.dart';
import 'package:sharetravel_frontend/repository/user_details/user_details_repository_impl.dart';
import 'package:sharetravel_frontend/ui/page/login_page.dart';
import 'package:sharetravel_frontend/ui/widget/user_profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final UserDetailsBloc _userDetailsBloc;
  late UserDetailsRepository userDetailsRepository;

  @override
  void initState() {
    userDetailsRepository = UserDetailsRepositoryImpl();
    _userDetailsBloc = UserDetailsBloc(userDetailsRepository);
    _userDetailsBloc.add(DoUserDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userDetailsBloc,
      child: Scaffold(
        body: BlocBuilder<UserDetailsBloc, UserDetailsState>(
          builder: (context, state) {
            if (state is DoUserDetailsLoading) {
              return CircularProgressIndicator();
            } else if (state is DoUserDetailsSuccess) {
              UserDetailsResponse userDetails = state.userDetailsResponse;
              return UserProfileWidget(userDetails: userDetails);
            } else if (state is DoUserDetailsError) {
              return Text('Error: ${state.errorMessage}');
            } else {
              return Text('Unexpected State');
            }
          },
        ),
      ),
    );
  }
}
