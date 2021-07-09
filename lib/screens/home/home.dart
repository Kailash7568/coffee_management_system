import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatefulWidget {
 
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
bool loading=false;
final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {


    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return loading ? Loading() : StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              onPressed: () async{
                setState(()=>loading=true);
                await _auth.signOut();
              }, 
              icon: Icon(Icons.person), 
              label: Text('Logout'),
              ),
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('settings'),
                onPressed: ()=> _showSettingsPanel(),
              ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover
            ),
          ),
          child: BrewList(),
          ),
      ),
    );
  }
}