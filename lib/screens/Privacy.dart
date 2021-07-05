import "package:flutter/material.dart";

class Privacy extends StatelessWidget{
  static String routeName="/privacy";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: SingleChildScrollView(
      child:
      Padding(padding: EdgeInsets.all(15),
      child: Column(
        children:[ 
          SizedBox(
            height: 60
          ),
          Text("Privacy Policy for Big Midas Pvt. Ltd.", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 30
          ),
          Text("At Big Midas, accessible from www.bigmidas.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Big Midas and how we use it.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(height: 15,),
          Text("If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.",style: TextStyle(fontSize: 15, color: Colors.black) ),
          SizedBox(height: 15,),
          Text("This Privacy Policy applies only to our online activities and is valid for visitors to our website & app with regards to the information that they shared and/or collect in Big Midas. This policy is not applicable to any information collected offline or via channels other than this website & app.",style: TextStyle(fontSize: 15, color: Colors.black) ),
          SizedBox(
            height: 30
          ),
          Text("Consent", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("Information You Provide To Us", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("We may ask you to provide us with certain Protected Information. We may collect this information through various means and in various places through the Services, including account registration forms, contact us forms, or when you otherwise interact with us. When you sign up to use the Services, you create a user profile. We shall ask you to provide only such Protected Information which is for lawful purpose connected with our Services and necessary to be collected by us for such purpose.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 15
          ),
           Text("The current data fields that might be requested for are:", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 15
          ),
          Text("▪ Email", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 10
          ),
          Text("▪ Password", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 10
          ),
          Text("▪ Name", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 10
          ),
          Text("▪ Address", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 10
          ),
          Text("▪ Mobile phone Number", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 10
          ),
          Text("▪ Zip Code", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 10
          ),
          Text("▪ Location", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 10
          ),
          SizedBox(
            height: 30
          ),
          Text("Information we collect", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("In addition to any Protected Information or other information that you choose to submit to us, we and our TPSP may use a variety of technologies that automatically (or passively) collect certain information whenever you visit or interact with the Services (“Usage Information”). This Usage", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 15
          ),
          Text("Information may include the browser that you are using, the URL that referred you to our Services, all of the areas within our Services that you visit, and the time of day, among other information. In addition, we collect your Device Identifier for your Device. A Device Identifier is a number that is automatically assigned to your Device used to access the Services, and our computers identify your Device by its Device Identifier.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 15
          ),
          Text(" In addition, tracking information is collected as you navigate through our Services, including, but not limited to geographic areas. The driver’s mobile phone will send your GPS coordinates, during the ride, to our servers. Most GPS enabled mobile devices can define one’s location to within 50 feet.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 15
          ),
          Text("In case you use your account to book a cab ride for someone else from your contact list using the Services, we will be collecting and storing such contact information and share the ride details with that selected contact.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 15
          ),
          Text("Usage Information may be collected using a cookie. If you do not want information to be collected through the use of cookies, your browser allows you to deny or accept the use of cookies. Cookies can be disabled or controlled by setting a preference within your web browser or on your Device. \n\n If you choose to disable cookies or flash cookies on your Device, some features of the Services may not function properly or may not be able to customize the delivery of information to you. The \n\n\nCompany cannot control the use of cookies (or the resulting information) by third parties, and use of third party cookies is not covered by our Privacy Policy.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("Information Collected By Mobile Applications", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("Our Services are primarily provided through the Mobile Application. We may collect and use technical data and related information, including but not limited to, technical information about your device, system and application software, and peripherals, that is gathered periodically to facilitate the provision of software updates, product support and other services to you (if any) related to such Mobile Applications.\n▪ When you use any of our Mobile Applications, the Mobile Application may automatically collect and store some or all of the following information from your mobile device (“Mobile Device Information”), in addition to the Device Information, including without limitation:\n▪ Your geolocation\n▪ Information to allow us to personalize the services and content available through the Mobile Application\n▪ Data from SMS/ text messages upon receiving Device permissions for the purposes of (i) issuing and receiving one time passwords and other device verification, and (ii) automatically filling verification details during financial transactions, either through us or a third-party service provider, in accordance with applicable law. We do not share or transfer SMS/ text message data to any third party other than as provided under this Privacy Policy.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("Location Information Collected From Big Midas Vendor App", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("From big midas vendor app we are collecting the drivers location throughout even when the app is in background of running in fore-background.\n\nWe are collecting the liver location of the driver and using it the customers can see the nearby drivers in the customer app.\n\nWe are collecting the store and service provider location from the vendor app so we can show their location in the customer app.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("Location Information Collected From Big Midas Customer App", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("From big midas customer app we are asking users to enter their current location or some other location to show them the nearby service providers, vehicle providers, and store providers.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("Direct Information Collected By Drivers", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("This Privacy Policy shall not cover the usage of any information about you which is obtained by the driver or the company to which the driver belongs, while providing you a ride on a cab booked using the Services, or otherwise, which is not provided by us.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("How we use your information", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("We use the information we collect in various ways, including to:\n\n•	Provide, operate, and maintain our website & app\n\n•	Improve, personalize, and expand our website & app\n\n•	Understand and analyze how you use our website & app\n\n•	Develop new products, services, features, and functionality\n\n•	Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the website & app, and for marketing and promotional purposes\n\n•	Send you emails\n\n•	Find and prevent fraud\n\n", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 15
          ),
          Text("(a) WHEN YOU AGREE TO RECEIVE INFORMATION FROM THIRD PARTIES.\n\nYou may be presented with an opportunity to receive information and/or marketing offers directly from third parties. If you do agree to have your Protected Information shared, your Protected Information will be disclosed to such third parties and all information you disclose will be subject to the privacy policy and practices of such third parties. We are not responsible for the privacy policies and practices of such third parties and, therefore, you should review the privacy policies and practices of such third parties prior to agreeing to receive such information from them. If you later decide that you no longer want to receive communication from a third party, you will need to contact that third party directly.\n\n(b) ADMINISTRATIVE AND LEGAL REASONS\n\nWe cooperate with Government and law enforcement officials and private parties to enforce and comply with the law. Thus, we may access, use, preserve, transfer and disclose your information (including Protected Information, IP address, Device Information or geo-location data), to Government or law enforcement officials or private parties as we reasonably determine is necessary and appropriate: (i) to satisfy any applicable law, regulation, subpoenas, Governmental requests or legal process; (ii) to protect and/or defend the Terms and Conditions for online and mobile Services or other policies applicable to any online and mobile Services, including investigation of potential violations thereof; (iii) to protect the safety, rights, property or security of the Company, our Services or any third party; (iv) to protect the safety of the public for any reason;", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("Change Of Information And Cancellation Of Account", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("(a) You are responsible for maintaining the accuracy of the information you submit to us, such as your contact information provided as part of account registration. If your Protected Information changes, or if you no longer desire our Services, you may correct, delete inaccuracies, or amend information by making the change on our member information page or by contacting us through through email address mentioned on our website or Mobile Application. We will make good faith efforts to make requested changes in our then active databases as soon as reasonably practicable.\n\n(b) You may also cancel or modify your communications that you have elected to receive from the Services by following the instructions contained within an e-mail or by logging into your user account and changing your communication preferences.\n\n(c) If upon modifying or changing the information earlier provided to Us, we find it difficult to permit access to our Services to you due to insufficiency/ inaccuracy of the information, we may, in our sole discretion terminate your access to the Services by providing you a written notice to this effect on your registered email id.\n\n(d) If you wish to cancel your account or request that we no longer use your information to provide you services, contact us through through email address mentioned on the trip bill received. We will retain your Protected Information and Usage Information (including geo-location) for as long as your account with the Services is active and as needed to provide you services. Even after your account is terminated, we will retain your Protected Information and Usage Information (including geo-location, trip history, and transaction history) as needed to comply with our legal and regulatory obligations, resolve disputes, conclude any activities related to cancellation of an account, investigate or prevent fraud and other inappropriate activity, to enforce our agreements, and for other business reason. After a period of time, your data may be anonymized and aggregated, and then may be held by us as long as necessary for us to provide our Services effectively, but our useof the anonymized data will be solely for analytic purposes.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("Security", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("The Protected Information and Usage Information we collect is securely stored within our databases, and we use standard, industry-wide, commercially reasonable security practices such as encryption, firewalls and SSL (Secure Socket Layers) for protecting your information. However, as effective as encryption technology is, no security system is impenetrable. We cannot guarantee the security of our databases, nor can we guarantee that information you supply won't be intercepted while being transmitted to us over the Internet or wireless communication, and any information you transmit to the Company you do at your own risk. We recommend that you not disclose your password to anyone.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("Advertising Partners Privacy Policies", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("You may consult this list to find the Privacy Policy for each of the advertising partners of Big Midas.\n\nThird-party ad servers or ad networks uses technologies like cookies, JavaScript, or Web Beacons that are used in their respective advertisements and links that appear on Big Midas, which are sent directly to users' browser. They automatically receive your IP address when this occurs. These technologies are used to measure the effectiveness of their advertising campaigns and/or to personalize the advertising content that you see on website & apps that you visit.\n\nNote that Big Midas has no access to or control over these cookies that are used by third-party advertisers.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("Third Party Privacy Policies", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("Big Midas's Privacy Policy does not apply to other advertisers or website & apps. Thus, we are advising you to consult the respective Privacy Policies of these third-party ad servers for more detailed information. It may include their practices and instructions about how to opt-out of certain options.\n\nYou can choose to disable cookies through your individual browser options. To know more detailed information about cookie management with specific web browsers, it can be found at the browsers' respective website & apps.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("CCPA Privacy Rights (Do Not Sell My Personal Information)", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("Under the CCPA, among other rights, Indian consumers have the right to:\n\nRequest that a business that collects a consumer's personal data disclose the categories and specific pieces of personal data that a business has collected about consumers.\n\nRequest that a business delete any personal data about the consumer that a business has collected.\n\nRequest that a business that sells a consumer's personal data, not sell the consumer's personal data.\n\nIf you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("GDPR Data Protection Rights", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("We would like to make sure you are fully aware of all of your data protection rights. Every user is entitled to the following:\n\nThe right to access – You have the right to request copies of your personal data. We may charge you a small fee for this service.\n\nThe right to rectification – You have the right to request that we correct any information you believe is inaccurate. You also have the right to request that we complete the information you believe is incomplete.\n\nThe right to erasure – You have the right to request that we erase your personal data, under certain conditions.\n\nThe right to restrict processing – You have the right to request that we restrict the processing of your personal data, under certain conditions.\n\nThe right to object to processing – You have the right to object to our processing of your personal data, under certain conditions.\n\nThe right to data portability – You have the right to request that we transfer the data that we have collected to another organization, or directly to you, under certain conditions.\n\nIf you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("Children's Information", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("Another part of our priority is adding protection for children while using the internet. We encourage parents and guardians to observe, participate in, and/or monitor and guide their online activity.\n\nBig Midas does not knowingly collect any Personal Identifiable Information from children under the age of 13. If you think that your child provided this kind of information on our website & app, we strongly encourage you to contact us immediately and we will do our best efforts to promptly remove such information from our records.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("Grievance Officer", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("Big Midas hereby appoints Big Midas Support Manager as the grievance officer for the purposes of the rules drafted under the Information Technology Act, 2000, who may be contacted at support@bigmidas.com. You may address any grievances you may have in respect of this privacy policy or usage of your Protected Information or other data to him.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          Text("Changes To The Privacy Policy", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w800 ),),
          SizedBox(
            height: 15
          ),
          Text("From time to time, we may update this Privacy Policy to reflect changes to our information practices. Any changes will be effective immediately upon the posting of the revised Privacy Policy.\n\nIf we make any material changes, we will notify you by email (sent to the e-mail address specified in your account) or by means of a notice on the Services prior to the change becoming effective.\n\nWe encourage you to periodically review this page for the latest information on our privacy practices.", style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(
            height: 30
          ),
          

          
        ]
      )
    )
    )
    );
    throw UnimplementedError();
  }
}