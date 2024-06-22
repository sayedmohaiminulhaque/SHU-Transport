import 'package:flutter/material.dart';
import "package:url_launcher/url_launcher.dart";
class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {

  Future _launchurl(String url) async{
    final Uri _url = Uri.parse(url);
    if(!await launchUrl(_url)) {
      throw Exception("Could not launch the url");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About us'
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('Image/busLocation2.png'),
              Text("SHU Transport",
              style: TextStyle(
                fontSize: 25.0,
               fontWeight: FontWeight.bold
              ),
              ),
              Text("Version 1.0.0",
                style: TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic
                ),
              ),
              SizedBox(height: 25,),
              Text("Developed by",
                style: TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic
                ),
              ),
              Text("Team Bahon",
                style: TextStyle(
                    fontSize: 20.0,
                ),
              ),
              SizedBox(height: 25,),
              Text("Rate us",
                style: TextStyle(
                  color: Colors.blue,
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic
                ),
              ),
              SizedBox(height: 25,),
              Text("Follow us by",
                style: TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic
                ),
              ),
              IconButton(onPressed: (){
                _launchurl('https://www.facebook.com/emran.shu');
              }, icon: Icon(
                Icons.facebook
              ),
                color: Colors.blue,
              )

            ],
          ),
        ),
      ),
    );
  }
}
