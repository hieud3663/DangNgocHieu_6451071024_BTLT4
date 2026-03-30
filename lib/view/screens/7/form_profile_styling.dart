import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baitap_chuong4/utils/validate.dart';
import 'package:flutter_baitap_chuong4/widget/alertdialog_custom.dart';
import 'package:flutter_baitap_chuong4/widget/button_custom.dart';
import 'package:flutter_baitap_chuong4/widget/inputdecoration_custom.dart';

class FormProfileStyling extends StatefulWidget {
  @override
  _FormProfileStylingState createState() => _FormProfileStylingState();
}

class _FormProfileStylingState extends State<FormProfileStyling> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _selectedGender = ValueNotifier<String?>(null);

  final _listGender = ['Male', 'Female', 'Other'];
  
  String _fileName = 'No file selected';


Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Styling'), key: _scaffoldKey),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
                radius: 50,
              ),

              SizedBox(height: 16),

              ButtonCustom(
                text: 'Change Avatar',
                onPressed: _pickFile,
                color: Colors.blue,
                width: 150,
              ),

              SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green, width: 2),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecorationCustom(
                        labelText: "Full Name",
                        hintText: "Nhập họ và tên của bạn",
                        prefixIcon: Icons.person,
                      ).build(),
                      validator: (value) => Validate.isValidName(value!)
                          ? null
                          : "Vui lòng nhập họ và tên",
                    ),

                    SizedBox(height: 16),

                    TextFormField(
                      controller: _bioController,
                      decoration: InputDecorationCustom(
                        labelText: "Bio",
                        hintText: "Nhập mô tả về bạn",
                        prefixIcon: Icons.info,
                      ).build(),
                      validator: (value) => Validate.isValidBio(value!)
                          ? null
                          : "Vui lòng nhập mô tả về bạn",
                    ),

                    SizedBox(height: 16),

                    DropdownButtonFormField(
                      value: _selectedGender.value,
                      items: _listGender
                          .map(
                            (gender) => DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender.value = value;
                        });
                      },
                      decoration: InputDecorationCustom(
                        labelText: "Gender",
                        prefixIcon: Icons.wc,
                      ).build(),
                      validator: (value) =>
                          value != null ? null : "Vui lòng chọn giới tính",
                    ),

                    SizedBox(height: 16),

                    ButtonCustom(
                      text: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialogCustom()
                          ).then((value) {
                            if (value == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Profile updated successfully!')),
                              );
                            }
                          });
                        }
                      },
                      color: Colors.green,
                    ),

                    SizedBox(height: 16),

                    ButtonCustom(
                      text: 'Cancel',
                      onPressed: () {
                        _nameController.clear();
                        _bioController.clear();
                        _selectedGender.value = null;
                      },
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
