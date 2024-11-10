// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/cupertino.dart';
import 'theme.dart';
import 'package:logger/logger.dart';
import 'reading.dart';
import '/services/gemini_service.dart'; // Add this import
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedSign = '';
  bool _isLoading = false;
  String _horoscopeText = '';

  void _onSelected(String sign) {
    setState(() {
      _selectedSign = sign;
    });
  }

  Future<void> _generateHoroscope() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final horoscope = await GeminiService.getHoroscopeReading(_selectedSign);
      setState(() {
        _horoscopeText = horoscope;
      });
    } catch (e) {
      Logger().e('Error generating horoscope: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> _checkInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _showNoInternetDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('No Internet Connection'),
        content: Text('Please check your internet connection and try again.'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _navigateToReading() async {
    final hasInternet = await _checkInternet();

    if (!hasInternet) {
      _showNoInternetDialog();
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _generateHoroscope();
      if (!mounted) return;

      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => Reading(
            selectedSign: _selectedSign,
            horoscopeText: _horoscopeText,
            onBack: () {
              setState(() {
                _selectedSign = '';
              });
            },
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
              SizedBox(height: 25),
              Text(
                'Good Fortune!',
                style: TextStyle(
                  color: textColor(context),
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'What you want to know?',
                style: TextStyle(
                    color: textColor(context),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 35),
              Text(
                'Select your sign:',
                style: TextStyle(
                    color: textColor(context),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
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

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: CupertinoButton(
        color: const Color(0xFF1f9a61),
        onPressed:
            _selectedSign.isEmpty || _isLoading ? null : _navigateToReading,
        child: _isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CupertinoActivityIndicator(
                    color: CupertinoColors.black,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Reading your futune...',
                    style: TextStyle(
                      color: CupertinoColors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Text(
                'Get Your Reading',
                style: TextStyle(
                  color: _selectedSign.isEmpty
                      ? CupertinoColors.black
                      : CupertinoColors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
