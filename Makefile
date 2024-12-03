run:
	flutter run --dart-define-from-file=./.env
runp:
	flutter run --profile --dart-define-from-file=./.env
builda:
	flutter build apk --dart-define-from-file=./.env
buildi:
	flutter build ipa --dart-define-from-file=./.env
gen:
	dart run build_runner watch --delete-conflicting-outputs
l10n:
	flutter gen-l10n
