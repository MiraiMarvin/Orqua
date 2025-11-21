@echo off
echo ========================================
echo ShopFlutter - Lancement SANS Firebase
echo ========================================
echo.
echo Ce script lance l'app SANS authentification
echo pour tester rapidement le catalogue, panier, etc.
echo.
echo ATTENTION: Vous devez d'abord desactiver l'auth!
echo Consultez ETAT_ACTUEL.md pour les instructions
echo.
pause

echo.
echo [1/2] Nettoyage...
call flutter clean

echo.
echo [2/2] Lancement...
call flutter run -d chrome

pause

