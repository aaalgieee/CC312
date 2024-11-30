# Horoscope AI - Flutter Mobile App
A modern Flutter application that generates AI-powered horoscope readings using Google's Gemini API.

# 📱 App Overview
The app provides personalized horoscope readings based on zodiac signs with these key features:

- iOS-style Cupertino design
- AI-powered horoscope generation
- Intuitive zodiac sign selection
- Share functionality
- Light/dark theme support
# 🔧 Technical Architecture

## Core Components

*home*.dart

- Main screen with zodiac sign selection grid
- iOS-style interface with Cupertino widgets
- Responsive layout handling

``` dart
class HomePage extends ConsumerWidget {
  // Main interface showing:
  // - "Good Fortune!" header
  // - "What do you want to know?" subheader
  // - Grid of zodiac signs
  // - Generate button
```

*gemini_service*.dart

- Handles AI integration with Google's Gemini
- Manages API calls and response processing
- Error handling and retries

*providers*.dart

- State management using Riverpod
- Manages:
    - Selected zodiac sign
    - Loading states
    - Horoscope text
    - Generation process

**UI Components**
- **Home Screen**: Displays zodiac sign selection grid
- **Reading Screen**: Shows generated horoscope with share capability
- **Theme Management**: Custom light/dark mode implementation.

# 📂 Project Structure

```
lib/
├── screens/
│   ├── home.dart         # Main selection screen
│   ├── reading.dart      # Horoscope display
│   ├── onboarding.dart   # Welcome screen
│   └── theme.dart        # Theme configuration
├── services/
│   └── gemini_service.dart # AI integration
└── providers.dart        # State management
```

# 🚀 Getting Started
1. Clone the repository
2. Create .env file with your Gemini API key
3. Install dependencies:
```
flutter pub get
```
4. Run the app:
``` bash
flutter run
```

# 🛠️ Dependencies
- **flutter_riverpod**: State management
- **google_generative_ai**: Gemini API integration
- **flutter_dotenv**: Environment configuration
- **share_plus**: Share functionality
- **flutter_markdown**: Text formatting

# 💡 Features
- **Zodiac Selection**: Interactive grid of 12 zodiac signs
- **AI Integration**: Personalized readings using Gemini
- **Share Capability**: Share horoscopes with others
- **Modern Design**: Clean, iOS-style interface
- **Error Handling**: Graceful error management
- Loading States: Smooth loading transitions

