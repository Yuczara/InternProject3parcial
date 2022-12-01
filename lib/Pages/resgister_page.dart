import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/services/auth_service.dart';
import 'package:productos_app/widgets/card_container.dart';
import 'package:productos_app/widgets/fondo_login.dart';
import 'package:provider/provider.dart';
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FondoLogin(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 250,
              ),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                      ),
                    Text(
                      'Crear Cuenta',
                      style: Theme.of(context).textTheme.headline4),
                    SizedBox(
                      height: 30,
                      ),
                      ChangeNotifierProvider(
                        create: (_) => LoginFormProvider(),
                        child: _LoginForm()
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              TextButton(
                child: Text('Login',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                ),
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'),       
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple
                  ),
                ),focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple
                  ),
                ),
                hintText: 'correo.ejemplo@gmail.com',
                labelText: 'Correo electrónico: ',
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                prefix: Icon(
                  Icons.alternate_email_sharp,
                  color:Colors.deepPurple,
                )
              ),
              onChanged: (value) => loginForm.email=value,
              validator: (value){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                ? null
                : 'El correo no es válido';
              },  
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple
                  ),
                ),focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple
                  ),
                ),
                hintText: '**********',
                labelText: 'Contraseña: ',
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                prefix: Icon(
                  Icons.lock_outline,
                  color:Colors.deepPurple,
                )
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value){
                if (value != null && value.length >=6){
                  return null;
                }
                return 'La contraseña debe tener al menos 6 caracteres';
              },
            ),
            SizedBox(height: 30,),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.deepPurple,
              disabledColor: Colors.grey,
              elevation: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 15,
                ),
                child: Text(
                  loginForm.isLoading ? 'Espere...'
                  :'Ingresar',
                  style:TextStyle(
                    color:Colors.white,
                  ),
                ),
              ),
              onPressed: loginForm.isLoading
              ? null
              :()async
              {
                FocusScope.of(context).unfocus();
                final authService = Provider.of<AuthService>(context,listen: false);
                if(!loginForm.isValidForm())return;
                loginForm.isLoading = true;
                //await Future.delayed(Duration(seconds: 2));

                final String? resp = await authService.crearUsuario(
                  loginForm.email, loginForm.password);

                  if(resp == null){
                    Navigator.pushReplacementNamed(context, 'home');
                  }else{
                    print(resp);
                  }

                
              },
            )
          ],
        ),
      )
    );
  }
}