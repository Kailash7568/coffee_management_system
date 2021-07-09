import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

final AuthService _auth = AuthService();
final _formKey = GlobalKey<FormState>();
bool loading=false;
 //text field state
 String email ='';
 String password='';
 String error='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register to Brew Crew'),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: (){
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        // ignore: deprecated_member_use
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                validator: (val)=> val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                    setState(() => email=val);
                },
                decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
          const Radius.circular(5.0),
        ),
                borderSide: BorderSide(color: Colors.white,width: 2.0,),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
          const Radius.circular(5.0),
        ),
                borderSide: BorderSide(color: Colors.pink,width: 2.0)
              )
            ),
              ),
               SizedBox(height: 20.0,),
               TextFormField(
                 obscureText: true,
                 validator: (val)=> val.length<6 ? 'Enter a password 6+ chars long' : null,
                 onChanged: (val){
                    setState(() => password=val);
                 },
                 decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
          const Radius.circular(5.0),
        ),
                borderSide: BorderSide(color: Colors.white,width: 2.0,),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
          const Radius.circular(5.0),
        ),
                borderSide: BorderSide(color: Colors.pink,width: 2.0)
              )
            ),
               ),
               SizedBox(height: 20.0,),
               RaisedButton(
                 color: Colors.pink[400],
                 child: Text(
                   'Register',
                   style: TextStyle(
                     color: Colors.white,
                   ),
                 ),
                 onPressed: ()async{
                   if(_formKey.currentState.validate()){
                     setState(()=>loading=true);
                     dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                     if(result==null){
                       setState((){
                         error='Please supply a valid email';
                         loading=false;
                       });
                     } 
                   }
                 },
               ),
               SizedBox(height: 20.0,),
               Text(
                 error,
                 style: TextStyle(color: Colors.red,fontSize: 14.0),
               )
            ],
            ),
        )
      ),
    );
  }
}