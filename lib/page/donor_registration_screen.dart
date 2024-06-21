import 'package:flutter/material.dart';

class DonorRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Registration'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: DonorRegistrationForm(),
      ),
    );
  }
}

class DonorRegistrationForm extends StatefulWidget {
  @override
  _DonorRegistrationFormState createState() => _DonorRegistrationFormState();
}

class _DonorRegistrationFormState extends State<DonorRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitted = false;
  String _selectedDateOfBirth = '';
  String _selectedLastDonationDate = '';
  String _gender = '';
  String _selectedBloodGroup = '';
  String _phoneNumber = '';
  String _weight = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            TextFormField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                hintText: 'Enter your date of birth (DD/MM/YYYY)',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your date of birth';
                }
                return null;
              },
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDateOfBirth = pickedDate.day.toString().padLeft(2, '0') +
                        '/' +
                        pickedDate.month.toString().padLeft(2, '0') +
                        '/' +
                        pickedDate.year.toString();
                  });
                }
              },
              readOnly: true,
              controller: TextEditingController(text: _selectedDateOfBirth),
            ),
            SizedBox(height: 12.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Gender',
                hintText: 'Select Your Gender',
              ),
              items: <String>['Male', 'Female', 'other']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please select a gender';
                }
                return null;
              },
              onChanged: (value) {
                _gender = value ?? '';
              },
            ),
            SizedBox(height: 12.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Blood Group Required',
                hintText: 'Select blood group required',
              ),
              items: <String>['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please select a blood group';
                }
                return null;
              },
              onChanged: (value) {
                _selectedBloodGroup = value ?? '';
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email address',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your email';
                } else if (!(value?.contains('@') ?? false)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
              ),
              keyboardType: TextInputType.phone,
              maxLength: 10,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your phone number';
                } else if (value!.length != 10) {
                  return 'Phone number must be 10 digits';
                }
                return null;
              },
              onChanged: (value) {
                _phoneNumber = value;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
                hintText: 'Enter your address',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Medical History',
                hintText: 'Enter relevant medical history',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter relevant medical history';
                }
                return null;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Last Donation Date',
                hintText: 'Enter the date of your last donation (DD/MM/YYYY)',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter the date of your last donation';
                }
                return null;
              },
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedLastDonationDate = pickedDate.day.toString().padLeft(2, '0') +
                        '/' +
                        pickedDate.month.toString().padLeft(2, '0') +
                        '/' +
                        pickedDate.year.toString();
                  });
                }
              },
              readOnly: true,
              controller: TextEditingController(text: _selectedLastDonationDate),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Weight',
                hintText: 'Enter your weight',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your weight';
                }
                return null;
              },
              onChanged: (value) {
                _weight = value;
              },
            ),
            SizedBox(height: 12.0),
            CheckboxListTile(
              title: Text('I consent to allow the collection of my personal information and accept the terms and conditions of blood donation.'),
              value: true, // You can manage this state with a variable
              onChanged: (bool? value) {},
            ),
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  setState(() {
                    _isSubmitted = true;
                  });
                  // Process registration here (send data to backend, etc.)
                  // You can replace the below line with actual registration logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Processing Registration'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  // Navigate to home screen after registration
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                }
              },
              style: ButtonStyle(),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
