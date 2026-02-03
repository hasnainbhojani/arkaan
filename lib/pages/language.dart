import 'package:flutter/material.dart';
import 'package:hajj/widgets/bottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:hajj/services/language_service.dart';

class LanguageSelectorPage extends StatefulWidget {
  const LanguageSelectorPage({super.key});

  @override
  State<LanguageSelectorPage> createState() => _LanguageSelectorPageState();
}

class _LanguageSelectorPageState extends State<LanguageSelectorPage> {
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    // Initialize with current language if exists
    final currentLang = context.read<LanguageService>().currentLanguage;
    _selectedLanguage = currentLang.isNotEmpty ? currentLang : null;
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
        leading: languageService.currentLanguage.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildLanguageTile('ગુજરાતી', 'gujarati'),
                _buildLanguageTile('English', 'english'),
                _buildLanguageTile('اردو', 'urdu'),
                _buildLanguageTile('Roman', 'roman'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _saveSelection,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Save Selection',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(String title, String value) {
    return ListTile(
      title: Text(title),
      leading: Radio<String>(
        value: value,
        groupValue: _selectedLanguage,
        onChanged: (String? newValue) {
          setState(() {
            _selectedLanguage = newValue;
          });
        },
      ),
    );
  }

  Future<void> _saveSelection() async {
    if (_selectedLanguage == null || _selectedLanguage!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a language')),
      );
      return;
    }

    final languageService = context.read<LanguageService>();
    await languageService.setLanguage(_selectedLanguage!);

    if (!mounted) return;

    // Clear existing routes and navigate to home
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => navMenu()),
      (route) => false,
    );
  }
}
