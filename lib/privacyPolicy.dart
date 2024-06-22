import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text('Privacy Policy for SHU Transport Mobile Application \nEffective Date: [23.07.2023] \nAt SHU Transport, we respect and protect your privacy. This Privacy Policy explains how we collect, use, and disclose personal information when you use our mobile application ("App").\nInformation We Collect\n1.1 Personal Information: We may collect personal information such as your name, email address and phone number, when you create an account or use our App.\n1.2 Location Data: To provide our transportation services, we may collect and process your devices location data while the App is running in the background.\nHow We Use Your Information\n2.1 Providing Services: We use your personal information to offer and maintain our transportation services, process bookings, and communicate important updates.\n2.2 Improving the App: Your feedback helps us enhance and optimize our App. We may use anonymous usage data to identify trends and areas for improvement.\n2.3 Marketing: With your consent, we may send you promotional materials and special offers.\nInformation Sharing and Disclosure\n3.1 Service Providers: We may share your personal information with trusted third-party service providers to help us operate, maintain, and improve our services.\n3.2 Legal Requirements: We may disclose your information if required by law, to protect our rights, or in response to a legal request.\n3.3 Business Transfers: In the event of a merger, acquisition, or sale of assets, your personal information may be transferred as part of the transaction.\nYour Choices\n4.1 Account Information: You can review and update your account information in the Apps settings.\n4.2 Location Services: You may enable or disable location services through your device settings or App permissions.\n4.3 Marketing Communications: You can opt-out of marketing communications by following the instructions provided in each message.\nData Security\nWe implement reasonable security measures to protect your personal information from unauthorized access and misuse.\nChanges to the Privacy Policy\nWe may update this Privacy Policy from time to time. Any significant changes will be communicated through the App or via email.\n\nContact Us:\nIf you have any questions or concerns about this Privacy Policy, please contact us at [emranhaquee@gmail.com].\nBy using SHU Transport App, you consent to the terms of this Privacy Policy and the collection and use of your personal information as described herein'
          ),
      ),
        ),
    ));
  }
}
