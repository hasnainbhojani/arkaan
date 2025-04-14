import 'package:flutter/material.dart';

class Policy extends StatefulWidget {
  const Policy({super.key});

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  var desc = '''Privacy Policy for Rehnuma e Hajj Ziyarat
Last Updated: 03/03/2025

1. Introduction
Welcome to Rehnuma e Hajj Ziyarat (here after referred to as “we,” “us,” or “our”). We are committed to protecting the privacy of our website visitors and users. This Privacy Policy outlines the information we collect, how we use it, and the choices you have concerning your data.

2. Information We Collect
a. Personal Information: We may collect personal information when you interact with our website, such as when you request your own music, subscribe to newsletters, participate in contests or surveys, or contact us. This information may include:
Name
Email address
Phone number
Address
User-generated content (e.g., comments, reviews)
b. Automatically Collected Information: We may also collect certain information automatically when you visit our website, including:
IP address
Browser type
Device information
Usage data (e.g., pages visited, time spent on the website)

3. How We Use Your Information
We use the collected information for the following purposes:
To provide and maintain our website’s functionality.
To communicate with you, respond to your inquiries, and provide customer support.
To personalize your experience on our website.
To send you newsletters, updates, and promotional materials (you can opt out at any time).
To analyze website usage and improve our services.
To comply with legal obligations.

4. Data Security
We take reasonable steps to protect your personal information from unauthorized access, disclosure, alteration, or destruction. However, please be aware that no method of transmission over the internet or electronic storage is entirely secure.

5. Cookies and Tracking Technologies
We use cookies and similar tracking technologies to enhance your browsing experience and collect information about your usage of our website. You can manage your cookie preferences through your browser settings.

6. Third-Party Links
Our website may contain links to third-party websites. We are not responsible for their privacy practices or content. We encourage you to review the privacy policies of these websites before providing any personal information.

7. Your Choices
You have the following rights regarding your personal information:
Access: You can request access to the personal information we hold about you.
Correction: You can request corrections to any inaccuracies in your personal information.
Deletion: You can request the deletion of your personal information, subject to legal restrictions.
Opt-Out: You can opt out of receiving marketing communications from us.

8. Changes to This Privacy Policy
We may update this Privacy Policy from time to time to reflect changes in our practices or for legal reasons. We will notify you of any significant changes via email or by prominently posting a notice on our website.

9. Contact Us
If you have any questions or concerns regarding this Privacy Policy or your personal information, please contact us at [Contact Information].
By using our website or app, you agree to the terms outlined in this Privacy Policy.

     ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                desc,
                style: TextStyle(color: Colors.white, fontSize: 18),
                softWrap: true,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
