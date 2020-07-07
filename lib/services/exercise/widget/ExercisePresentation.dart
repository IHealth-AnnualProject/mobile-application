import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExercisePresentation extends StatelessWidget {
  final Widget destination;
  final String titleComponent;
  final String contentComponent;
  final String leadingComponent;

  ExercisePresentation(
      {this.destination, this.titleComponent, this.contentComponent, this.leadingComponent});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => destination,
          ),
        ),
        child: SafeArea(
          child: Container(
            color: Color.fromRGBO(0, 157, 153, 1),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 40.0,
                        ),
                      ],
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(leadingComponent),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  title(
                    content: this.titleComponent,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  content(content: this.contentComponent),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }

  Text title({String content}) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 35),
    );
  }

  Text content({String content}) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 17),
    );
  }
}
