import 'package:flutter/material.dart';
import 'package:flutter_baitap_chuong4/widget/button_custom.dart';
import '../../../utils/validate.dart';

class FormBook extends StatefulWidget {
  @override
  _FormBookState createState() => _FormBookState();
}

class _FormBookState extends State {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  late final List<String> _services = [
    'Kiểm tra tổng quát',
    'Dịch vụ 1',
    'Dịch vụ 2',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ĐẶT LỊCH HẸN'),
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
                    'Chọn ngày',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  TextFormField(
                    readOnly: true,
                    controller: _dateController,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1990),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        _dateController.text = pickedDate.toString().split(
                          ' ',
                        )[0];
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Selected Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) => Validate.isValidDate(value ?? '')
                        ? null
                        : "Ngày không hợp lệ ",
                  ),

                  SizedBox(height: 16),

                  const Text(
                    "Chọn giờ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  TextFormField(
                    controller: _timeController,
                    decoration: InputDecoration(
                      hintText: "Chọn giờ",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        _timeController.text = pickedTime.format(context);
                      }
                    },
                  ),

                  SizedBox(height: 16),

                  const Text(
                    'Chọn dịch vụ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  DropdownButtonFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    items: _services.map((s) {
                      return DropdownMenuItem(value: s, child: Text(s));
                    }).toList(),
                    onChanged: (value) {
                      // Handle service selection
                    },
                  ),

                  const SizedBox(height: 100),

                  ButtonCustom(
                    text: 'Đặt lịch hẹn',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Lịch hẹn đã được đặt!')),
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
