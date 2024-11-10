// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'theme.dart';
import 'reading.dart';

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
              SizedBox(height: 10),
              Text(
                'Good Fortune!',
                style: TextStyle(
                  color: textColor(context),
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'What you want to know?',
                style: TextStyle(
                  color: textColor(context),
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 15),
              Text(
                'Select your horoscope:',
                style: TextStyle(
                  color: textColor(context),
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 15.0),
              SizedBox(
                height: 540.0,
                child: GridView.count(
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: [
                    _buildHoroscopeButton(context, 'Pisces',
                        _selectedSign == 'Pisces', _onSelected),
                    _buildHoroscopeButton(context, 'Aries',
                        _selectedSign == 'Aries', _onSelected),
                    _buildHoroscopeButton(context, 'Taurus',
                        _selectedSign == 'Taurus', _onSelected),
                    _buildHoroscopeButton(context, 'Gemini',
                        _selectedSign == 'Gemini', _onSelected),
                    _buildHoroscopeButton(context, 'Cancer',
                        _selectedSign == 'Cancer', _onSelected),
                    _buildHoroscopeButton(
                        context, 'Leo', _selectedSign == 'Leo', _onSelected),
                    _buildHoroscopeButton(context, 'Virgo',
                        _selectedSign == 'Virgo', _onSelected),
                    _buildHoroscopeButton(context, 'Libra',
                        _selectedSign == 'Libra', _onSelected),
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
              ),
              _buildBottomButton(context),
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
            fontSize: 18.0,
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
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4c4b4a) : const Color(0xFFf2f2f2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/signs/$sign.png',
              height: 85.0,
              width: 85.0,
            ),
            SizedBox(height: 8.0),
            Text(
              sign,
              style: TextStyle(
                color:
                    isSelected ? CupertinoColors.white : CupertinoColors.black,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildBottomButton(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    child: CupertinoButton(
      color: const Color(0xFF1f9a61),
      child: Text(
        'Get Your Reading',
        style: TextStyle(
          color: CupertinoColors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => Reading(),
          ),
        );
      },
    ),
  );
}
