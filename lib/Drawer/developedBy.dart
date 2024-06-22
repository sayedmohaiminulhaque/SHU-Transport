import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../webView.dart';

class DevelopedBy extends StatefulWidget {
  const DevelopedBy({Key? key}) : super(key: key);

  @override
  State<DevelopedBy> createState() => _DevelopedByState();
}

class _DevelopedByState extends State<DevelopedBy> {

  void _launchUrl(String host) async{
    Uri url = Uri.parse(host);
    if(await canLaunchUrl(url)){
      await launchUrl(url,
        mode: LaunchMode.platformDefault,
      );
    }else{
      throw "Can't launch profile";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Developed By"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .95,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25.0,),
                    CircleAvatar(                                                // Ahta-Shamul Hoque Emran
                      radius: 60,
                      backgroundImage: AssetImage("Image/emran.jpg"),
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      "Ahta-Shamul Hoque Emran",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      "Department of CSE,SHU",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Session: 2019-20",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),Text(
                      "email: emranhaquee@gmail.com",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              _launchUrl("https://www.linkedin.com/in/emranhaque/");
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) => mWebView(address: "https://www.linkedin.com/in/emranhaque/")));

                            },
                            iconSize: 25.0,
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/linkedin.png"),
                            )),

                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => mWebView(address: "https://github.com/Emran-Haque")));

                            },
                            iconSize: 25.0,
                            icon:  CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/GitHub.png"),
                            )),

                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => mWebView(address: "https://www.facebook.com/emran.shu/")));
                            },
                            iconSize: 25.0,
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/Facebook.png"),
                            )),
                        IconButton(
                            onPressed: () {

                            },
                            iconSize: 25.0,
                            icon:  CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/instagram.png"),
                            )),
                        IconButton(
                            onPressed: () {
                              _launchUrl("https://twitter.com/ASH_Emran");
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) => mWebView(address: "https://twitter.com/ASH_Emran")));
                            },
                            iconSize: 25.0,
                            icon:  CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/twitter.png"),
                            )),
                      ],
                    )
                  ],
                ),
              ),
             SizedBox(height: 10.0,),
             Container(                                                             // Sayed Mohaiminul Haque
                width: MediaQuery.of(context).size.width * .95,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25.0,),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("Image/siam.jpg"),
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      "Sayed Mohaiminul Haque",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      "Department of CSE,SHU",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Session: 2019-20",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),Text(
                      "email: mohaiminul.shu.cse@gmail.com",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              _launchUrl("https://www.linkedin.com/in/sayed-mohaiminul-haque");
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) => mWebView(address: "https://www.linkedin.com/in/sayed-mohaiminul-haque")));
                            },
                            iconSize: 25.0,
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/linkedin.png"),
                            )),

                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => mWebView(address: "https://github.com/smh32")));
                            },
                            iconSize: 25.0,
                            icon:  CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/GitHub.png"),
                            )),

                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => mWebView(address: "https://www.facebook.com/smhsiam32")));
                            },
                            iconSize: 25.0,
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/Facebook.png"),
                            )),
                        IconButton(
                            onPressed: () {

                            },
                            iconSize: 25.0,
                            icon:  CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/instagram.png"),
                            )),
                        IconButton(
                            onPressed: () {
                              _launchUrl("https://twitter.com/smhsiam32?t=UyB8go6u2_7gX2B0EFxeqg&s=09");
                              // Navigator.of(context)
                              //     .push(MaterialPageRoute(builder: (context) => mWebView(address: "https://twitter.com/smhsiam32?t=UyB8go6u2_7gX2B0EFxeqg&s=09")));
                            },
                            iconSize: 25.0,
                            icon:  CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/twitter.png"),
                            )),
                      ],
                    )
                  ],
                ),
              ),
             SizedBox(height: 10.0,),
             Container(                                                                        //Manik Karmakar
                width: MediaQuery.of(context).size.width * .95,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25.0,),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("Image/manik.jpg"),
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      "Manik Karmakar Joy",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      "Department of CSE,SHU",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Session: 2019-20",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),Text(
                      "email: manikkarmakar565@gmail.com",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                            },
                            iconSize: 25.0,
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/linkedin.png"),
                            )),

                        IconButton(
                            onPressed: () {
                            },
                            iconSize: 25.0,
                            icon:  CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/GitHub.png"),
                            )),

                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => mWebView(address: "https://www.facebook.com/manikkarmakar.joy")));
                            },
                            iconSize: 25.0,
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/Facebook.png"),
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => mWebView(address: "https://instagram.com/manik_karmakar_joy?igshid=NGExMmI2YTkyZg==")));
                            },
                            iconSize: 25.0,
                            icon:  CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/instagram.png"),
                            )),
                        IconButton(
                            onPressed: () {

                            },
                            iconSize: 25.0,
                            icon:  CircleAvatar(
                              radius: 15.0,
                              backgroundImage: AssetImage("Image/twitter.png"),
                            )),

                      ],
                    )
                  ],
                ),
              ),

              SizedBox(height: 10.0,)
            ],
          ),
        ),
      ),
    );
  }
}
