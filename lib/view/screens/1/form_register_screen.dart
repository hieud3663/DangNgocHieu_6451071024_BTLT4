import 'package:flutter/material.dart';
import 'package:flutter_baitap_chuong4/widget/button_custom.dart';
import '../../../utils/validate.dart';

class FormRegisterScreen extends StatefulWidget {
  @override
  _FormRegisterScreenState createState() => _FormRegisterScreenState();
}

class _FormRegisterScreenState extends State<FormRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _checkValidate = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateFormValidity);
    _emailController.addListener(_updateFormValidity);
    _passwordController.addListener(_updateFormValidity);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateFormValidity() {
    final isValid =
        Validate.isValidName(_nameController.text.trim()) &&
        Validate.isValidEmail(_emailController.text.trim()) &&
        Validate.isValidPassword(_passwordController.text) &&
        _checkValidate;

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Đăng Ký Tài Khoản'), centerTitle: true, backgroundColor: Colors.blue,),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Align(
              child: Text("Đã có tài khoản? Đăng nhập", style: TextStyle(color: Colors.blue)),
              alignment: Alignment.centerRight
            ),
            SizedBox(height: 16.0),

            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
            ),
            Text("Account Circle", style: TextStyle(color: Colors.blue),),
            SizedBox(height: 16.0),

            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Họ và tên',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => Validate.isValidName(value!)
                        ? null
                        : 'Vui lòng nhập họ và tên hợp lệ',
                  ),

                  SizedBox(height: 16.0),

                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => Validate.isValidEmail(value!)
                        ? null
                        : 'Vui lòng nhập email hợp lệ'
                  ),

                  SizedBox(height: 16.0),

                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) => Validate.isValidPassword(value!)
                        ? null
                        : 'Mật khẩu phải có ít nhất 8 ký tự',
                  ),

                  SizedBox(height: 32.0),

                  CheckboxListTile(
                    title: Text("Tôi đồng ý với các điều khoản"),
                    value: _checkValidate,
                    onChanged: (newValue) {
                      setState(() {
                        _checkValidate = newValue ?? false;
                      });
                      _updateFormValidity();
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),

                  SizedBox(height: 16.0),

                  ButtonCustom(
                    text: 'Đăng Ký',
                    onPressed: _isFormValid
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Đăng ký thành công!')),
                              );
                            }
                          }
                        : null,
                    color: _isFormValid ? Colors.blue : Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
