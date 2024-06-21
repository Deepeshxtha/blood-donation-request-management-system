import 'dart:io';

import 'package:flutter/material.dart';

class RequestBloodDashboard extends StatelessWidget {
  final Map<String, dynamic> requestData;
  final File? uploadedPhoto; // Assuming you're using dart:io File for the image
  final String? status;

  const RequestBloodDashboard({
    Key? key,
    required this.requestData,
    this.uploadedPhoto,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Blood Dashboard'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20.0),
            _buildDetailsList(),
            SizedBox(height: 20.0),
            if (uploadedPhoto != null) _buildUploadedPhoto(),
            SizedBox(height: 20.0),
            _buildStatusWidget(status),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Request Details',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(thickness: 1.5),
      ],
    );
  }

  Widget _buildDetailsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailItem('Full Name', requestData['fullName']),
        _buildDetailItem('Hospital Name', requestData['hospitalName']),
        _buildDetailItem('Blood Group', requestData['bloodGroup']),
        _buildDetailItem('Contact Number', requestData['contactNumber']),
        _buildDetailItem('Date Needed', requestData['dateNeeded']),
        _buildDetailItem('Quantity Needed', requestData['quantityNeeded']),
        _buildDetailItem('Doctor\'s Name', requestData['doctorName']),
        _buildDetailItem('Patient\'s Name', requestData['patientName']),
        _buildDetailItem('Relationship to Patient', requestData['relationshipToPatient']),
        _buildDetailItem('Additional Information', requestData['additionalInfo']),
      ],
    );
  }

  Widget _buildDetailItem(String label, dynamic value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            '${value ?? ''}',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadedPhoto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Uploaded Photo:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          height: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: FileImage(uploadedPhoto!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 12.0),
      ],
    );
  }

  Widget _buildStatusWidget(String? status) {
    Color statusColor = Colors.grey;
    String statusText = 'Pending';

    if (status != null) {
      switch (status.toLowerCase()) {
        case 'fulfilled':
          statusColor = Colors.green;
          statusText = 'Fulfilled';
          break;
        case 'pending':
          statusColor = Colors.yellow;
          statusText = 'Pending';
          break;
      // Add more status cases as needed
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'Status: $statusText',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
