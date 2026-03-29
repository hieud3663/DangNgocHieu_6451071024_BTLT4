import 'package:flutter/material.dart';
import 'package:flutter_baitap_chuong4/widget/button_custom.dart';
import '../../../utils/validate.dart';

class FormRegisterV2 extends StatefulWidget {
  @override
  _FormRegisterV2State createState() => _FormRegisterV2State();
}

class _FormRegisterV2State extends State<FormRegisterV2> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _checkValidate = false;
  bool _isFormValid = false;

  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateFormValidity);
    _emailController.addListener(_updateFormValidity);
    _passwordController.addListener(_updateFormValidity);
    _confirmPasswordController.addListener(_updateFormValidity);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
      appBar: AppBar(
        title: const Text('Form Đăng Ký Tài Khoản Nâng cao'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Đăng ký Tài khoản",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),

            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Họ và tên'),
                    validator: (value) => Validate.isValidName(value!)
                        ? null
                        : 'Vui lòng nhập họ và tên hợp lệ',
                  ),

                  SizedBox(height: 20.0),

                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) => Validate.isValidEmail(value!)
                        ? null
                        : 'Vui lòng nhập email hợp lệ',
                  ),

                  SizedBox(height: 20.0),

                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: !_showPassword,
                    validator: (value) => Validate.isValidPasswordV2(value!)
                        ? null
                        : 'Mật khẩu phải có ít nhất 8 ký tự, bao gồm cả chữ cái, số và ký tự đặc biệt',
                  ),

                  SizedBox(height: 20.0),

                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Xác nhận mật khẩu',
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: !_showPassword,
                    validator: (value) => value == _passwordController.text
                        ? null
                        : 'Mật khẩu xác nhận không khớp',
                  ),

                  SizedBox(height: 20.0),

                  ButtonCustom(
                    text: 'Đăng Ký',
                    onPressed: _isFormValid
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Đăng ký thành công')),
                              );
                            }
                          }
                        : null,
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
