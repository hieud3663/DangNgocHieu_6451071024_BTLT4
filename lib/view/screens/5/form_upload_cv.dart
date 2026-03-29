import 'package:flutter/material.dart';
import 'package:flutter_baitap_chuong4/widget/button_custom.dart';
import '../../../utils/validate.dart';
import 'package:file_picker/file_picker.dart';

class FormUploadCV extends StatefulWidget {
  @override
  _FormUploadCVState createState() => _FormUploadCVState();
}

class _FormUploadCVState extends State {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _fileName;
  bool _agreeTerms = false;

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
      appBar: AppBar(
        title: const Text('BÀI 5: Form upload hồ sơ'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Họ và tên',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('Full Name'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => Validate.isValidName(value!)
                        ? null
                        : 'Họ và tên không hợp lệ',
                  ),

                  SizedBox(height: 16),

                  const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('Email'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => Validate.isValidEmail(value!)
                        ? null
                        : 'Email không hợp lệ',
                  ),

                  SizedBox(height: 16),

                  const Text(
                    'File Picker',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'CV (Định dạng: PDF, DOCX)',
                    style: TextStyle(fontSize: 16),
                  ),

                  TextFormField(
                    controller: TextEditingController(text: _fileName ?? ''),
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Chọn file CV của bạn',
                      border: OutlineInputBorder(),
                      suffix: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ElevatedButton.icon(
                          onPressed: _pickFile,
                          icon: Icon(Icons.upload_file, size: 16),
                          label: Text('Chọn Tệp CV'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            minimumSize: Size(0, 32),
                          ),
                        ),
                      ),
                    ),
                    validator: (value) =>
                        _fileName != null ? null : 'Vui lòng upload CV của bạn!',
                  ),

                  const SizedBox(height: 16),

                  CheckboxListTile(
                    title: const Text('Tôi xác nhận thông tin là chính xác'),
                    value: _agreeTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeTerms = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),

                  const SizedBox(height: 100),

                  ButtonCustom(
                    text: "Nộp hồ sơ", 
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Hồ sơ đã được nộp!')),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
