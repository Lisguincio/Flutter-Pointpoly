import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget{
  final VoidCallback onPressed;
  final String buttonText;
  final String tooltip;
  final Color color;
  final double width;
  final double height;


  Button(this.width, this.height, this.color,this.buttonText , this.onPressed,{this.tooltip = ""}); //Costruttore

  @override
  Widget build(BuildContext context){
    return Tooltip(
      message: this.tooltip,
      child: SizedBox(
        width: width,
        height: height,
        child: RaisedButton(
          onPressed: this.onPressed,
          color: this.color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5) )),
          child:Text(
            this.buttonText,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white
            )
          ),
        ),
      )
    );
    
    
    
  }
  }

