import 'package:flutter/cupertino.dart';

class Sliders extends StatelessWidget {
  String image;
  String text;
  Sliders({required this.image, required this.text,});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage(image)),
          SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.all(20),
              child: Text (text, textAlign: TextAlign.center,  style: TextStyle(fontSize: 18),)
          )
        ],
        // ),
      ),
    );
  }
}

