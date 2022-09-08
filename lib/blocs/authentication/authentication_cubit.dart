import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../network/models/user_model.dart';
import '../../network/services/database_service.dart';
import '../../network/services/navigation_service.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  late final FirebaseAuth _auth;
  late final DatabaseService _databaseService;
  late final NavigationService _navigationService;

  late UserModel userModel;

  AuthenticationCubit() : super(AuthenticationInitial()) {
    _auth = FirebaseAuth.instance;
    _databaseService = GetIt.instance.get<DatabaseService>();
    _navigationService = GetIt.instance.get<NavigationService>();

    // Listening to firebase and checking if user exist
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        log('Logged In Success');

        DocumentSnapshot documentSnapshot =
            await _databaseService.getUserInfo(user.uid);

        Map<String, dynamic> userData =
            documentSnapshot.data() as Map<String, dynamic>;

        log('====================================');
        log(userData.toString());
        userModel = UserModel.fromJson({
          'uid': user.uid,
          'name': userData['name'],
          'email': userData['email'],
          'role': userData['role'],
          'is_booking': userData['is_booking'],
        });

        _navigationService.removeAndNavigateToRoute('/home');
        log('====================================');
      } else {
        _navigationService.removeAndNavigateToRoute('/login');

        log('Not Authenticated');
      }
    });
  }

  // Create an object from cubit
  static AuthenticationCubit get(context) => BlocProvider.of(context);

  // Login
  Future<void> loginUsingEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // log('${_auth.currentUser}');
    } on FirebaseAuthException {
      log("Error logging user into Firebase");
    } catch (e) {
      // General Exception
      log(e.toString());
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
