import 'package:flutter/material.dart';
import 'form_engine/dynamic_form.dart' show DynamicForm;
import 'form_engine/form_controller.dart';
import 'form_engine/form_field_config.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Form Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FormController();
    final fields = [
      FieldConfig.text(
        name: 'username',
        label: 'Username',
        localeMap: {'en': 'Username', 'ar': 'اسم المستخدم'},
        isRequired: true,
        hintText: 'Enter your username',
        hintLocaleMap: {'en': 'Enter your username', 'ar': 'أدخل اسم المستخدم'},
        errorMessage: 'Username is required',
        validator: (value) {
          if (value == null || value.isEmpty) return 'Username is required';
          return null;
        },
        styleConfig: FieldStyleConfig(
          labelColor: Colors.blue,
          borderColor: Colors.blueAccent,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      FieldConfig.date(
        name: 'birthdate',
        label: 'Birth Date',
        localeMap: {'en': 'Birth Date', 'ar': 'تاريخ الميلاد'},
        isRequired: true,
        hintText: 'Select your birth date',
        hintLocaleMap: {'en': 'Select your birth date', 'ar': 'اختر تاريخ ميلادك'},
        errorMessage: 'Birth date is required',
        validator: (value) {
          if (value == null || value.isEmpty) return 'Birth date is required';
          return null;
        },
      ),
      FieldConfig.dropdown(
        name: 'gender',
        label: 'Gender',
        localeMap: {'en': 'Gender', 'ar': 'الجنس'},
        options: ['Male', 'Female', 'Other'],
        hintText: 'Select your gender',
        hintLocaleMap: {'en': 'Select your gender', 'ar': 'اختر جنسك'},
        errorMessage: 'Gender is required',
        validator: (value) {
          if (value == null || value.isEmpty) return 'Gender is required';
          return null;
        },
      ),
      FieldConfig.phone(
        name: 'phone',
        label: 'Phone Number',
        localeMap: {'en': 'Phone Number', 'ar': 'رقم الهاتف'},
        isRequired: true,
        hintText: 'Enter your phone number',
        hintLocaleMap: {'en': 'Enter your phone number', 'ar': 'أدخل رقم هاتفك'},
        errorMessage: 'Phone number is required',
        validator: (value) {
          if (value == null || value.isEmpty) return 'Phone number is required';
          return null;
        },
      ),
      FieldConfig.country(
        name: 'country',
        label: 'Country',
        localeMap: {'en': 'Country', 'ar': 'الدولة'},
        hintText: 'Select your country',
        hintLocaleMap: {'en': 'Select your country', 'ar': 'اختر دولتك'},
        errorMessage: 'Country is required',
        validator: (value) {
          if (value == null || value.isEmpty) return 'Country is required';
          return null;
        },
      ),
      FieldConfig.image(
        name: 'profile_image',
        label: 'Profile Image',
        localeMap: {'en': 'Profile Image', 'ar': 'صورة الملف الشخصي'},
        allowMultipleImages: false,
        errorMessage: 'Profile image is required',
        validator: (value) {
          if (value == null || value.isEmpty) return 'Profile image is required';
          return null;
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Form Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DynamicForm(
          fields: fields,
          controller: controller,
          locale: 'en', // Change to 'ar' for Arabic
          onSubmit: (data) {
            print('Form Submitted:');
            data.forEach((key, value) {
              print('$key: $value');
            });
          },
        ),
      ),
    );
  }
}