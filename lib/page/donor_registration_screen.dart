import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  File? _medicalHistoryImage;
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _medicalHistoryImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
              items: <String>['Male', 'Female', 'Other']
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
              onChanged: (value) {
                _email = value ?? '';
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                ),
              ),
              obscureText: _isPasswordHidden,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your password';
                } else if (value!.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              onChanged: (value) {
                _password = value ?? '';
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Re-enter your password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                    });
                  },
                ),
              ),
              obscureText: _isConfirmPasswordHidden,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please confirm your password';
                } else if (value != _password) {
                  return 'Passwords do not match';
                }
                return null;
              },
              onChanged: (value) {
                _confirmPassword = value ?? '';
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
            Text('Blood Group Report Compulsory :'),
            SizedBox(height: 8.0),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: _medicalHistoryImage != null
                    ? Image.file(
                  _medicalHistoryImage!,
                  fit: BoxFit.cover,
                )
                    : Center(
                  child: Text(
                    'Tap to select an image',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
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
                  Navigator.pushReplacementNamed(context, '/login'); // Replace '/login' with your actual login screen route
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
