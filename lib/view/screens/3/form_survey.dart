import 'package:flutter/material.dart';
import 'package:flutter_baitap_chuong4/widget/button_custom.dart';
import '../../../utils/validate.dart';

class FormSurvey extends StatefulWidget {
  @override
  _FormSurveyState createState() => _FormSurveyState();
}

class _FormSurveyState extends State {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final Map<String, bool> _hobbies = {
    'Phim ảnh (Movies)': false,
    'Thể thao (Sports)': false,
    'Âm nhạc (Music)': false,
    'Du lịch (Travel)': false,
  };

  final Map<String, IconData> _hobbiesIcon = {
    'Phim ảnh (Movies)': Icons.movie,
    'Thể thao (Sports)': Icons.sports_soccer,
    'Âm nhạc (Music)': Icons.music_note,
    'Du lịch (Travel)': Icons.luggage,
  };

  String? _satisfactionLevel = null;
  final Map<String, IconData> _satisfactionOptions = {
    'Hài lòng (Satisfied)': Icons.sentiment_satisfied,
    'Bình thường (Neutral)': Icons.sentiment_neutral,
    'Không hài lòng (Dissatisfied)': Icons.sentiment_dissatisfied,
  };

  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey'),
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
                  FormField<Map<String, bool>>(
                    initialValue: _hobbies,
                    validator: (value) =>
                        Validate.isCheckboxChecked(value ?? {})
                        ? null
                        : "Vui lòng chọn ít nhất một sở thích",

                    builder: (state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SỞ THÍCH (INTERESTS)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ..._hobbies.keys.map((hobbie) {
                            return CheckboxListTile(
                              value: _hobbies[hobbie],
                              onChanged: (value) {
                                setState(() {
                                  _hobbies[hobbie] = value ?? false;
                                });
                                state.didChange(_hobbies);
                              },
                              secondary: Icon(_hobbiesIcon[hobbie]),
                              title: Text(hobbie),
                            );
                          }),
                          SizedBox(height: 16),
                          const Text(
                            'MỨC ĐỘ HÀI LÒNG (SATISFACTION LEVEL)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ..._satisfactionOptions.keys.map((o) {
                            return RadioListTile(
                              value: o,
                              groupValue: _satisfactionLevel,
                              onChanged: (value) => setState(() {
                                _satisfactionLevel = value as String?;
                              }),
                              secondary: Icon(_satisfactionOptions[o]),
                              title: Text(o),
                              controlAffinity: ListTileControlAffinity.trailing,
                            );
                          }),

                          
                          if (state.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                state.errorText ?? '',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16),

                  const Text(
                    'GHI CHÚ THÊM (ADDITIONAL NOTES)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  TextFormField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      hintText: 'Ghi chú thêm...',
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: 16),
                    maxLines: 3,
                  ),

                  const SizedBox(height: 16),

                  ButtonCustom(
                    text: 'Gửi khảo sát',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Khảo sát đã được gửi!')),
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
