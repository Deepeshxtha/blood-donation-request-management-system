import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RequestBloodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Blood'),
        backgroundColor: Colors.blue, // Set AppBar background color
      ),
      body: Container(
        color: Colors.grey[200], // Set background color of the page
        padding: EdgeInsets.all(16.0),
        child: RequestBloodForm(),
      ),
    );
  }
}

class RequestBloodForm extends StatefulWidget {
  @override
  _RequestBloodFormState createState() => _RequestBloodFormState();
}

class _RequestBloodFormState extends State<RequestBloodForm> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _hospitalName = '';
  String _bloodGroup = '';
  String _contactNumber = '';
  DateTime? _dateNeeded;
  String _quantityNeeded = '';
  String _doctorName = '';
  String _patientName = '';
  String _relationshipToPatient = '';
  String _additionalInfo = '';
  bool _isSubmitted = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateNeeded ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dateNeeded) {
      setState(() {
        _dateNeeded = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isSubmitted ? _buildSubmissionSuccess(context) : _buildForm();
  }

  Widget _buildForm() {
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
              onSaved: (value) => _fullName = value ?? '',
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Hospital Name',
                hintText: 'Enter hospital name',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter hospital name';
                }
                return null;
              },
              onSaved: (value) => _hospitalName = value ?? '',
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
                setState(() {
                  _bloodGroup = value ?? '';
                });
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Contact Number',
                hintText: 'Enter your contact number',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your contact number';
                } else if (value.length != 10) {
                  return 'Contact number must be 10 digits';
                }
                return null;
              },
              onSaved: (value) => _contactNumber = value ?? '',
            ),
            SizedBox(height: 12.0),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date Needed',
                  hintText: 'Select the date needed',
                ),
                child: Text(
                  _dateNeeded == null
                      ? 'Select Date'
                      : '${_dateNeeded!.toLocal()}'.split(' ')[0],
                  style: TextStyle(
                    color: _dateNeeded == null ? Colors.grey[600] : Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Quantity Needed',
                hintText: 'Enter the quantity needed',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter the quantity needed';
                }
                return null;
              },
              onSaved: (value) => _quantityNeeded = value ?? '',
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Doctor\'s Name',
                hintText: 'Enter the doctor\'s name',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter the doctor\'s name';
                }
                return null;
              },
              onSaved: (value) => _doctorName = value ?? '',
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Patient\'s Name',
                hintText: 'Enter the patient\'s name',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter the patient\'s name';
                }
                return null;
              },
              onSaved: (value) => _patientName = value ?? '',
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Relationship to Patient',
                hintText: 'Enter your relationship to the patient',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your relationship to the patient';
                }
                return null;
              },
              onSaved: (value) => _relationshipToPatient = value ?? '',
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Additional Information',
                hintText: 'Enter any additional information',
              ),
              onSaved: (value) => _additionalInfo = value ?? '',
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  setState(() {
                    _isSubmitted = true;
                  });

                  Navigator.pushReplacementNamed(
                    context,
                    '/requestBloodDashboard',
                    arguments: {
                      'fullName': _fullName,
                      'hospitalName': _hospitalName,
                      'bloodGroup': _bloodGroup,
                      'contactNumber': _contactNumber,
                      'dateNeeded': _dateNeeded == null
                          ? ''
                          : '${_dateNeeded!.toLocal()}'.split(' ')[0],
                      'quantityNeeded': _quantityNeeded,
                      'doctorName': _doctorName,
                      'patientName': _patientName,
                      'relationshipToPatient': _relationshipToPatient,
                      'additionalInfo': _additionalInfo,
                    },
                  );
                }
              },
              style: ButtonStyle(
              ),
              child: Text('Request Blood'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmissionSuccess(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 64.0,
          ),
          SizedBox(height: 16.0),
          Text(
            'Blood Request Submitted Successfully!',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/requestBloodDashboard');
            },
            child: Text('Go to Dashboard'),
          ),
        ],
      ),
    );
  }
}
