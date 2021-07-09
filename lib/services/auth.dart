//this auth.dart is for our auth service

import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  
  final FirebaseAuth _auth= FirebaseAuth.instance; //instance of firebase authentication, this object allow us to communicate with firebase auth on backend
  
  //create user obj based on FirebaseUser
  UserClass _userFromFirebaseUser(User user){
      return user!=null ? UserClass(uid: user.uid) :null;
  }

  //auth change user stream
  Stream<UserClass> get user{
    return _auth.authStateChanges()
     .map(_userFromFirebaseUser);
  }


  //sign in anon
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user=result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in with email & password
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email.trim(),password: password.trim());
      User user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //register with email & password
  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email.trim(),password: password.trim());
      User user=result.user;

      //when there's registration of new user we  create a ducument for that user
      await DatabaseService(uid:user.uid).updateUserData('0','new crew member',100);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}