<p align="center">
<img src="assets/app/icon.png" width="150"  alt="logo">
</p>

# FoodDash App

## Compilar android

```bash
flutter build apk --release
```

## Compilar ios

```bash
flutter build ios --release
```

## Cambiar icono de la app

```bash
flutter pub run flutter_launcher_icons
```

## Cambiar splashscreen

```bash
dart run flutter_native_splash:create
```

## Cambiar nombre de la app

```bash
flutter pub run rename_app:main all="SnappyShop"
```

## Cambiar bundle Id

```bash
flutter pub run change_app_package_name:main com.joseperezgil.fooddash
```

## Firebase

```bash
flutterfire configure
```

## Google maps api key

### Android

Copiar archivo local.defaults.properties y renombrar como secrets.properties y asignar la api key

### Ios

Crear archivo Secrets.plist.example y renombrarlo Secrets.plist y asignar la api key
