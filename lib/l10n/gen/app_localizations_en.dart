import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Med Verify';

  @override
  String get languageName => 'English';

  @override
  String get thatsAnError => 'That\'s an error';

  @override
  String get requestedPageNotFound => 'The requested page was not found.';

  @override
  String get thatsAllWeKnow => 'That\'s all we know.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get confirmationCode => 'CONFIRMATION CODE';

  @override
  String get didntReceiveCode => 'Didn\'t receive the code?';

  @override
  String sendAgain(int seconds) {
    String _temp0 = intl.Intl.pluralLogic(
      seconds,
      locale: localeName,
      other: 'Send again in $seconds secs',
      one: 'Send again in 1 sec',
      zero: 'Send again',
    );
    return '$_temp0';
  }

  @override
  String get emailConfirmationCodeSent =>
      'A confirmation has been sent to your email. Please enter it to continue.';

  @override
  String get loginTermsCondition =>
      'By continuing, you accept privacy policy, and terms & conditions';

  @override
  String get createAnAccountButton => 'Create Account';

  @override
  String get orLabel => 'OR';

  @override
  String get address => 'Address';

  @override
  String get pairNewDevice => 'Pair new device';

  @override
  String get nearbyDevices => 'Nearby Devices';

  @override
  String get wellDiscoverDevices =>
      'We\'ll try to discover compatible devices and you can select a device to connect';

  @override
  String get deviceControls => 'Device Controls';

  @override
  String get deviceUsage => 'Device Usage';

  @override
  String get deviceSettings => 'Device Settings';

  @override
  String get searching => 'Searching...';

  @override
  String get addressIsRequired => 'Address is required';

  @override
  String get nameIsRequired => 'Name is required';

  @override
  String get availableToConnect => 'Available to connect';

  @override
  String get connected => 'Connected';

  @override
  String get available => 'Available';

  @override
  String get addressInvalid => 'Please make sure entered address is correct';

  @override
  String get nameInvaid => 'Please make sure entered name is correct';

  @override
  String get youCanPairDevice =>
      'You can pair a new device by tapping the button below';

  @override
  String get areYouSureSignout => 'Are you sure you want to sign out?';

  @override
  String get home => 'Home';

  @override
  String get shareWifi => 'Share Wi-Fi';

  @override
  String get shareWifiDescription =>
      'Provie a Wi-Fi credentials to allow the device to join';

  @override
  String get networkName => 'Network name';

  @override
  String get password => 'password';

  @override
  String get securityType => 'Security type';

  @override
  String get places => 'Places';

  @override
  String get addPlace => 'Add Place';

  @override
  String get addDevice => 'Add Device';

  @override
  String get addRoom => 'Add Room';

  @override
  String get noPlacesToShow => 'No Places to show';

  @override
  String get unnamedPlace => 'Unnamed Place';

  @override
  String get provideTheDocumentUrl => 'Provide the document URL';

  @override
  String get makeSureUrlIsValid => 'Make sure the URL is valid';

  @override
  String get unnamedRoom => 'Unnamed Room';

  @override
  String get unnamedDevice => 'Unnamed Device';

  @override
  String get noDevicesAvailable => 'No Devices available';

  @override
  String get noRoomsToShow => 'No Rooms to show';

  @override
  String get username => 'Username';

  @override
  String get joinNetwork => 'Join Network';
}
