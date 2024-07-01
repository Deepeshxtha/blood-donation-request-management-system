import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'page/login_page.dart';
import 'page/donor_registration_screen.dart';
import 'page/request_blood_screen.dart';
import 'page/maps_screen.dart';
import 'page/request_blood_dashboard_screen.dart';
import 'page/custom_navigation_bar.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(BloodBankApp());
}

class BloodBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Bank Management System',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/login', // Set initial route to login page
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => MyHomePage(), // Define home route
        '/donorRegistration': (context) => DonorRegistrationScreen(),
        '/requestBlood': (context) => RequestBloodScreen(),
        '/mapsScreen': (context) => MapScreen(),
        '/requestBloodDashboard': (context) => RequestBloodDashboard(
          requestData: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>,
        ),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Blood Bank Management System',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/first.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CustomNavigationBar(), // Add custom navigation bar here
                  _buildWelcomeSection(context),
                  _buildSectionBox(context, 'Features', Icons.assignment, _buildFeaturesSection(context)),
                  _buildSectionBox(context, 'Why Donate Blood?', Icons.favorite, _buildWhyDonateBloodSection(context)),
                  _buildSectionBox(context, 'Requirements for Donating Blood', Icons.check_circle, _buildRequirementsSection(context)),
                  _buildSectionTitle('Requested Blood Details'),
                  _buildRequestedBloodDetailsSection(),
                  SizedBox(height: 20.0),
                  Container(
                    color: Colors.blueGrey,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      children: [
                        Text(
                          '© 2024 BBMS. All Rights Reserved.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionBox(BuildContext context, String title, IconData icon, Widget content) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        childrenPadding: EdgeInsets.all(16.0),
        expandedAlignment: Alignment.centerLeft,
        children: [
          content,
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/donorRegistration');
              },
              icon: Icon(Icons.person_add),
              label: Text('Register as a Donor'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/requestBlood');
              },
              icon: Icon(Icons.local_hospital),
              label: Text('Request Blood'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/mapsScreen');
              },
              icon: Icon(Icons.map),
              label: Text('View Blood Requests on Map'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFeatureItem(context, Icons.phone, 'Contact Numbers of Hospitals in Nepal'),
          _buildFeatureItem(context, Icons.person, 'Number of Donors Registered'),
          _buildFeatureItem(context, Icons.local_hospital, 'Number of Blood Requests'),
          _buildFeatureItemWithImage(context, Icons.group, 'Compatible Blood Groups', 'assets/images/comp.jpeg'),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(text),
        childrenPadding: EdgeInsets.all(16.0),
        expandedAlignment: Alignment.centerLeft,
        children: [
          // Place your detailed information here
          Text('This is the detailed information about $text.'),
        ],
      ),
    );
  }

  Widget _buildFeatureItemWithImage(BuildContext context, IconData icon, String text, String imagePath) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  constraints: BoxConstraints(maxWidth: double.infinity, maxHeight: double.infinity),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: ExpansionTile(
          leading: Icon(icon),
          title: Text(text),
          childrenPadding: EdgeInsets.all(16.0),
          expandedAlignment: Alignment.centerLeft,
          children: [
            // Place your detailed information here
            Image.asset(
              imagePath,
              fit: BoxFit.contain,
              width: double.infinity,
              height: 200,
            ),
            SizedBox(height: 8.0),
            Text('This is the detailed information about $text.'),
          ],
        ),
      ),
    );
  }

  Widget _buildWhyDonateBloodSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Why Donate Blood?',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'Blood donation helps save lives. Your donation can make a big difference to someone in need.',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Benefits for the Donor:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          _buildBenefitItem(Icons.favorite, 'Reduces Risk of Heart Disease'),
          _buildBenefitItem(Icons.autorenew, 'Enhances Production of New Blood Cells'),
          _buildBenefitItem(Icons.accessibility, 'Helps in Weight Management'),
          _buildBenefitItem(Icons.health_and_safety, 'May Lower Cancer Risk'),
          SizedBox(height: 8.0),
          Text(
            'Psychological Benefits:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          _buildBenefitItem(Icons.volunteer_activism, 'Acts of Kindness and Charity'),
          _buildBenefitItem(Icons.groups, 'Community Engagement'),
          SizedBox(height: 8.0),
          Text(
            'Benefits for the Recipient:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          _buildBenefitItem(Icons.sanitizer, 'Saves Lives'),
          _buildBenefitItem(Icons.medical_services, 'Supports Complex Medical and Surgical Procedures'),
          SizedBox(height: 8.0),
          Text(
            'Benefits to Society:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          _buildBenefitItem(Icons.people, 'Ensures Availability of Blood'),
          _buildBenefitItem(Icons.support, 'Improves Healthcare Standards'),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
    );
  }

  Widget _buildRequirementsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Requirements for Donating Blood:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          _buildRequirementItem(Icons.cake, 'Age: 18-65 years'),
          _buildRequirementItem(Icons.fitness_center, 'Weight: At least 50kg'),
          _buildRequirementItem(Icons.health_and_safety, 'Good General Health'),
          _buildRequirementItem(Icons.fastfood, 'No Heavy Meals Before Donation'),
          _buildRequirementItem(Icons.access_time, 'Adequate Sleep Before Donation'),
          _buildRequirementItem(Icons.water_drop, 'Stay Hydrated'),
          _buildRequirementItem(Icons.no_drinks, 'No Alcohol 24 Hours Before Donation'),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
    );
  }

  Widget _buildRequestedBloodDetailsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRequestedBloodItem(
            'Patient Name: shyam shyam',
            'Blood Group: O+',
            'Hospital Name: Bir Hospital',
            'Contact Number: 9876543210',
            'Date Needed: 2024-07-01',
          ),
          _buildRequestedBloodItem(
            'Patient Name: Ram Ram',
            'Blood Group: A-',
            'Hospital Name: ashok Clinic',
            'Contact Number: 9876543211',
            'Date Needed: 2024-07-05',
          ),
        ],
      ),
    );
  }

  Widget _buildRequestedBloodItem(
      String patientName,
      String bloodGroup,
      String hospitalName,
      String contactNumber,
      String dateNeeded,
      ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              patientName,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(bloodGroup),
            Text(hospitalName),
            Text(contactNumber),
            Text(dateNeeded),
          ],
        ),
      ),
    );
  }
}
