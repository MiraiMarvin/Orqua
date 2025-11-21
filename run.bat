@echo off
echo ================================
echo ShopFlutter - Setup et Lancement
echo ================================
echo.

echo [1/4] Installation des dependances...
call flutter pub get
if %errorlevel% neq 0 (
    echo Erreur lors de l'installation des dependances
    pause
    exit /b %errorlevel%
)
echo.

echo [2/4] Generation des mocks pour les tests...
call flutter pub run build_runner build --delete-conflicting-outputs
echo.

echo [3/4] Verification du code...
call flutter analyze
echo.

echo [4/4] Lancement de l'application Web...
echo.
echo L'application va s'ouvrir dans votre navigateur Chrome
echo Si vous n'avez pas configure Firebase, l'authentification ne marchera pas
echo Consultez FIREBASE_SETUP.md pour configurer Firebase
echo.
pause

call flutter run -d chrome

pause

