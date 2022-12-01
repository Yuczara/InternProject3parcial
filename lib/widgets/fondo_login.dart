import 'package:flutter/material.dart';

class FondoLogin extends StatelessWidget {

final Widget child;

  const FondoLogin({Key? key,required this.child}): super (key: key);
  @override

  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      //color: Colors.red,
      child: Stack(
        children: [
          _purpleBox(),
          SafeArea(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 30),
              child: Icon(
                Icons.cell_tower_rounded,
                color: Colors.white,
                size: 80,
            ),
            ),
          ),
          this.child,
        ],
      ),
    );
  }
}
class _purpleBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height *0.4,
      //color: Colors.indigo.shade900,
    decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/banner2.jpg'),
          //image: NetworkImage('https://mti.com/wp-content/uploads/2017/06/Datacentre-networking-banner.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            child: _Esfera(),
            top: 90,
            left: 30,
          ),
          Positioned(
            child: _Esfera(),
            top: -40,
            left: -30,
          ),
          Positioned(
            child: _Esfera(),
            top: -50,
            right: -20,
          ),
          Positioned(
            child: _Esfera(),
            bottom: -50,
            left: 10,
          ),
          Positioned(
            child: _Esfera(),
            bottom: 120,
            right: 20,
          ),
        ],        
      ),
    );
  }
}

class _Esfera extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
      color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}