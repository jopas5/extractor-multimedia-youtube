@echo off
:: Forzar a la consola a usar UTF-8 para mostrar tildes y símbolos correctamente
chcp 65001 >nul
title Extractor Multimedia (YT-DLP)
color 0b

:MENU
cls
echo ====================================================
echo              EXTRACTOR MULTIMEDIA UNIVERSAL
echo ====================================================
echo.
echo  [1] Descargar Música de YouTube (Audio MP3)
echo  [2] Descargar Video de YouTube (Formato MP4)
echo  [3] Instalar / Actualizar Herramientas (Winget)
echo  [4] Manual de Uso e Info ℹ️
echo  [5] Salir
echo.
echo ====================================================
echo  Dev Jopa
echo ====================================================
choice /c 12345 /n /m "Selecciona una opción (1 al 5): "

if errorlevel 5 goto SALIR
if errorlevel 4 goto MANUAL
if errorlevel 3 goto CONFIG_BASE
if errorlevel 2 goto MENU_VIDEO
if errorlevel 1 goto MENU_MUSICA

:MENU_MUSICA
cls
echo ====================================================
echo              SELECCIONAR CALIDAD DE AUDIO (MP3)
echo ====================================================
echo.
echo  [1] Calidad Máxima (320 kbps - Excelente sonido)
echo  [2] Calidad Estándar (192 kbps - Recomendado)
echo  [3] Calidad Económica (128 kbps - Ahorra mucho espacio)
echo  [4] Volver al menú principal
echo.
echo ====================================================
choice /c 1234 /n /m "Selecciona la calidad (1, 2, 3 o 4): "

if errorlevel 4 goto MENU
if errorlevel 3 set "cal_audio=9" & goto MUSICA
if errorlevel 2 set "cal_audio=5" & goto MUSICA
if errorlevel 1 set "cal_audio=0" & goto MUSICA

:MUSICA
cls
echo ====================================================
echo              MODO: DESCARGAR AUDIO DE YOUTUBE
echo ====================================================
echo.
set /p link="Pega el enlace de YouTube / YT Music aquí: "
echo.
echo [INFO] Descargando y convirtiendo a MP3...
echo.
yt-dlp -x --audio-format mp3 --audio-quality %cal_audio% --embed-thumbnail --add-metadata -o "%~dp0%%(title)s" "%link%"
goto SEGUIR

:MENU_VIDEO
cls
echo ====================================================
echo              SELECCIONAR CALIDAD DE VIDEO (MP4)
echo ====================================================
echo.
echo  [1] Máxima Calidad Disponible (4K / 2K / 1080p)
echo  [2] Alta Calidad Estándar (Solo 1080p)
echo  [3] Calidad Media HD (Solo 720p)
echo  [4] Volver al menú principal
echo.
echo ====================================================
choice /c 1234 /n /m "Selecciona la calidad (1, 2, 3 o 4): "

if errorlevel 4 goto MENU
if errorlevel 3 set "calidad=bv*[height<=720][ext=mp4]+ba[ext=m4a]/b[ext=720]" & goto VIDEO
if errorlevel 2 set "calidad=bv*[height<=1080][ext=mp4]+ba[ext=m4a]/b[ext=1080]" & goto VIDEO
if errorlevel 1 set "calidad=bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]" & goto VIDEO

:VIDEO
cls
echo ====================================================
echo              MODO: DESCARGAR VIDEO (MP4)
echo ====================================================
echo.
set /p link="Pega el enlace de YouTube aquí: "
echo.
echo [INFO] Descargando video en la calidad seleccionada...
echo.
yt-dlp -f "%calidad%" --embed-thumbnail --add-metadata -o "%~dp0%%(title)s" "%link%"
goto SEGUIR

:CONFIG_BASE
cls
echo ====================================================
echo           INSTALACIÓN DE HERRAMIENTAS BASE (YT)
echo ====================================================
echo.
echo Se usarán comandos Winget para la instalación limpia.
echo.
echo [1/2] Instalando/Actualizando yt-dlp...
winget install yt-dlp --disable-interactivity
echo.
echo [2/2] Instalando/Actualizando FFmpeg...
winget install FFmpeg --disable-interactivity
echo.
echo ====================================================
echo  [OK] Componentes base finalizados.
echo  Reinicia el archivo .bat si es la primera vez que los instalas.
echo ====================================================
echo.
pause
goto MENU

:MANUAL
cls
echo ====================================================
echo              MANUAL DE USO E INFORMACIÓN
echo ====================================================
echo.
echo  ¿DÓNDE SE GUARDAN LAS DESCARGAS?
echo  -> Todos los archivos (MP3 y MP4) se guardan EXACTAMENTE
echo     en la misma carpeta donde esté ejecutándose este archivo .bat
echo.
echo  ¿CÓMO USAR EL EXTRACTOR?
echo  1. Elige qué tipo de archivo deseas bajar (Música o Video).
echo  2. Selecciona la calidad deseada de la lista.
echo  3. Copia el enlace desde tu navegador o aplicación móvil.
echo  4. Haz clic derecho dentro de esta ventana para pegar el link
echo     y presiona Enter.
echo.
echo  REQUISITOS IMPORTANTES:
echo  -> Si es la primera vez que lo usas o da un error de comandos,
echo     ejecuta la Opción [3] para configurar todo automáticamente.
echo.
echo ====================================================
pause
goto MENU

:SEGUIR
echo.
echo ====================================================
echo   [OK] Proceso finalizado. Revisa esta misma carpeta.
echo ====================================================
echo.
choice /c SN /n /m "¿Deseas realizar otra operación? (S/N): "
if errorlevel 2 goto SALIR
if errorlevel 1 goto MENU

:SALIR
cls
echo.
echo ====================================================
echo   ¡Gracias por usar el extractor!
echo   ¡Hasta la próxima! 🚀
echo   Power By Gemini AI 🤖
echo ====================================================
echo.
timeout /t 3 >nul
exit