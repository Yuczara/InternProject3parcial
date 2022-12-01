import 'package:flutter/material.dart';

class FondoHuawei extends StatelessWidget {

final Widget child;

  const FondoHuawei({Key? key,required this.child}): super (key: key);
  @override

  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      //color: Colors.red,
      child: Stack(
        children: [
          _purpleBox(),
          this.child,
          ]
        
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
      height: size.height *0.22,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/banner.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
