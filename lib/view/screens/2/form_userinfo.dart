import 'package:flutter/material.dart';
import '../../../utils/validate.dart';

class FormUserInfoScreen extends StatefulWidget {
  @override
  _FormUserInfoScreenState createState() => _FormUserInfoScreenState();
}

class _FormUserInfoScreenState extends State {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String? _selectedGender;
  final _maritalStatuses = ['Độc thân', 'Kết hôn', 'Ly hôn'];
  final _selectedMaritalStatus = ValueNotifier<String?>(null);

  final _incomeRange = RangeValues(0, 50); //đơn vị triệu VND
  double _selectedIncome = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form thông tin cá nhân'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      key: _scaffoldKey,
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Họ và tên", hintText: "Nhập họ và tên của bạn"),
                    validator: (value) => Validate.isValidName(value!)
                        ? null
                        : "Vui lòng nhập họ và tên",
                  ),

                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Tuổi",
                      hintText: "Nhập tuổi của bạn",
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        Validate.isValidAge(value!) ? null : "Tuổi phải > 8",
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField(
                    items: ['Nam', 'Nữ']
                        .map(
                          (gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          ),
                        )
                        .toList(),
                    decoration: InputDecoration(labelText: "Giới tính"),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Tình trạng hôn nhân",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  Column(
                    children: _maritalStatuses
                        .map(
                          (status) => RadioListTile<String>(
                            value: status,
                            groupValue: _selectedMaritalStatus.value,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedMaritalStatus.value = value;
                              });
                            },
                            title: Text(status),
                          ),
                        )
                        .toList(),
                  ),

                  Text(
                    "Mức thu nhập: ${_selectedIncome.toInt()} triệu VND",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  Slider(
                    value: _selectedIncome.toDouble(),
                    min: _incomeRange.start,
                    max: _incomeRange.end,
                    divisions: 10,
                    label: '${_selectedIncome.toInt()} triệu VND',
                    onChanged: (value) => setState(() {
                      _selectedIncome = value;
                    }),
                  ),
                ],
              ),
            ),
            
          ],

        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.save),
        tooltip: "Lưu",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
