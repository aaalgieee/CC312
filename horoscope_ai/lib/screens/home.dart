// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedSign = '';
  String _selectedReading = '';

  void _onSelected(String sign) {
    setState(() {
      _selectedSign = sign;
    });
  }

  void onSelected(String reading) {
    setState(() {
      _selectedReading = reading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor(context),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                'Good Fortune!',
                style: TextStyle(
                  color: textColor(context),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'What you want to know?',
                style: TextStyle(
                  color: textColor(context),
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(context, 'Horoscope',
                      _selectedReading == 'Horoscope', onSelected),
                  _buildButton(context, 'Palmistry',
                      _selectedReading == 'Palmistry', onSelected),
                  _buildButton(context, 'Physiognomy',
                      _selectedReading == 'Physiognomy', onSelected),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Select your horoscope',
                style: TextStyle(
                  color: textColor(context),
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: [
                  _buildHoroscopeButton(context, 'Pisces',
                      _selectedSign == 'Pisces', _onSelected),
                  _buildHoroscopeButton(
                      context, 'Aries', _selectedSign == 'Aries', _onSelected),
                  _buildHoroscopeButton(context, 'Taurus',
                      _selectedSign == 'Taurus', _onSelected),
                  _buildHoroscopeButton(context, 'Gemini',
                      _selectedSign == 'Gemini', _onSelected),
                  _buildHoroscopeButton(context, 'Cancer',
                      _selectedSign == 'Cancer', _onSelected),
                  _buildHoroscopeButton(
                      context, 'Leo', _selectedSign == 'Leo', _onSelected),
                  _buildHoroscopeButton(
                      context, 'Virgo', _selectedSign == 'Virgo', _onSelected),
                  _buildHoroscopeButton(
                      context, 'Libra', _selectedSign == 'Libra', _onSelected),
                  _buildHoroscopeButton(context, 'Scorpio',
                      _selectedSign == 'Scorpio', _onSelected),
                  _buildHoroscopeButton(context, 'Sagittarius',
                      _selectedSign == 'Sagittarius', _onSelected),
                  _buildHoroscopeButton(context, 'Capricorn',
                      _selectedSign == 'Capricorn', _onSelected),
                  _buildHoroscopeButton(context, 'Aquarius',
                      _selectedSign == 'Aquarius', _onSelected),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String reading, bool isSelected,
      Function(String) onSelected) {
    return GestureDetector(
      onTap: () => onSelected(reading),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4c4b4a) : const Color(0xFFf2f2f2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          reading,
          style: TextStyle(
            color: isSelected ? CupertinoColors.white : CupertinoColors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHoroscopeButton(BuildContext context, String sign,
      bool isSelected, Function(String) onSelected) {
    return GestureDetector(
      onTap: () => onSelected(sign),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4c4b4a) : const Color(0xFFf2f2f2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          sign,
          style: TextStyle(
            color: isSelected ? CupertinoColors.white : CupertinoColors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
