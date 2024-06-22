import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class mWebView extends StatefulWidget {
  final  address;
  const mWebView({Key? key,this.address}) : super(key: key);

  @override
  State<mWebView> createState() => _mWebViewState();
}


class _mWebViewState extends State<mWebView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            if(await WebViewController().canGoBack()){
              WebViewController().goBack();
              return false;
            }
            else{
              return true;
            }
          },

          child: WebViewWidget(
            controller: WebViewController()
             ..loadRequest(Uri.parse(widget.address))
          ),
        ),
      ),
    );
  }
}
