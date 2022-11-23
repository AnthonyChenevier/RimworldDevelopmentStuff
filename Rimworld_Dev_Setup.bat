@ECHO OFF

REM Get the rimworld unity version and debug directory from parameter or prompt
SETLOCAL ENABLEDELAYEDEXPANSION

ECHO Setting up...
SET RIMWORLD_INSTALL_DIR=%~1
SET RIMWORLD_BACKUP_DIR=%~2
SET RIMWORLD_UNITY_VERSION=%~3

IF "%RIMWORLD_INSTALL_DIR%"=="" (
	ECHO No Arguments provided. Using defaults...
	SET RIMWORLD_INSTALL_DIR=C:\steam\steamapps\common\Rimworld
	SET RIMWORLD_BACKUP_DIR=E:\Rimworld_Backup
	SET RIMWORLD_UNITY_VERSION=2019.4.30f1
)

SET UNITY_INSTALL_DIR=C:\Program Files\Unity\Hub\Editor\%RIMWORLD_UNITY_VERSION%\Editor
SET WINDOWS_PLAYER_DIR=%UNITY_INSTALL_DIR%\Data\PlaybackEngines\windowsstandalonesupport\Variations\win64_development_mono
SET EXE_PATH=%WINDOWS_PLAYER_DIR%\WindowsPlayer.exe
SET UNITYPLAYER_DLL_PATH=%WINDOWS_PLAYER_DIR%\UnityPlayer.dll
SET WINPIX_DLL_PATH=%WINDOWS_PLAYER_DIR%\WinPixEventRuntime.dll
SET BOOT_CONFIG_FOLDER=%RIMWORLD_INSTALL_DIR%\RimWorldWin64_Data


FOR /F %%I IN (%RIMWORLD_INSTALL_DIR%\version.txt) DO ( SET RIMWORLD_VERSION_STEAM=%%I )
ECHO Setup complete.
GOTO MENU

:BACKUP
ECHO Creating backup copy of Rimworld...
SET BACKUP_DIR=%RIMWORLD_BACKUP_DIR%\%RIMWORLD_VERSION_STEAM%
IF EXIST "%BACKUP_DIR%" (
	ECHO Backup copy of current install already exists
	SET /P DEL_OLD=Delete and re-create^(Y/N^):   
	IF /I !DEL_OLD!==Y (
		ECHO Deleting old version...
		DEL /S /Q "%BACKUP_DIR%" 1>NUL
		RMDIR /S /Q "%BACKUP_DIR%" 1>NUL
	) ELSE GOTO MENU
) 
ECHO Creating new debug copy of Rimworld...
MKDIR "%BACKUP_DIR%" 1>NUL
XCOPY /I /Y /E "%RIMWORLD_INSTALL_DIR%" "%BACKUP_DIR%" 1>NUL
ECHO.
ECHO Backup complete. Returning to menu...
GOTO MENU


:DELETE_BACKUP
SET BACKUP_DIR=%RIMWORLD_BACKUP_DIR%\%RIMWORLD_VERSION_STEAM%
ECHO Current backup directory is '%BACKUP_DIR%'
SET /P DEL_OLD=Delete this backup ^(Y/N^):   
IF /I !DEL_OLD!==Y (
	ECHO Deleting old version...
	DEL /S /Q "%BACKUP_DIR%" 1>NUL
	RMDIR /S /Q "%BACKUP_DIR%" 1>NUL
) ELSE GOTO MENU

GOTO MENU




:MAKE_DEBUG
SET /P DEBUG=Set Rimworld to debug mode ^(1^) or normal mode ^(2^). 3 to exit:
IF /I %DEBUG%==1 GOTO DBG
IF /I %DEBUG%==2 GOTO NML
IF /I %DEBUG%==3 GOTO MENU
GOTO MENU

:DBG
ECHO Modifying boot.config
RENAME %BOOT_CONFIG_FOLDER%\boot.config boot.tmp
FOR /F %%I IN (%BOOT_CONFIG_FOLDER%\boot.tmp) DO (
	SET foo=%%I
	IF !foo!==wait-for-managed-debugger=0 (SET foo=wait-for-managed-debugger=1)
	IF !foo!==player-connection-debug=0 (SET foo=player-connection-debug=1)
	ECHO !foo! >> %BOOT_CONFIG_FOLDER%\boot.config
) 
DEL %BOOT_CONFIG_FOLDER%\boot.tmp
ECHO Setting up debugging files for selected Rimworld install...

RENAME "%RIMWORLD_INSTALL_DIR%\RimWorldWin64.exe" "RimWorldWin64.exe.original"
COPY "%EXE_PATH%" "%RIMWORLD_INSTALL_DIR%"
RENAME "%RIMWORLD_INSTALL_DIR%\WindowsPlayer.exe" "RimWorldWin64.exe"

RENAME "%RIMWORLD_INSTALL_DIR%\UnityPlayer.dll" "UnityPlayer.dll.original"
COPY "%UNITYPLAYER_DLL_PATH%" "%RIMWORLD_INSTALL_DIR%"

COPY "%WINPIX_DLL_PATH%" "%RIMWORLD_INSTALL_DIR%"
GOTO MENU

:NML
ECHO Modifying boot.config
RENAME %BOOT_CONFIG_FOLDER%\boot.config boot.tmp
FOR /F %%I IN (%BOOT_CONFIG_FOLDER%\boot.tmp) DO (
	SET foo=%%I
	IF !foo!==wait-for-managed-debugger=1 (SET foo=wait-for-managed-debugger=0)
	IF !foo!==player-connection-debug=1 (SET foo=player-connection-debug=0)
	ECHO !foo! >> %BOOT_CONFIG_FOLDER%\boot.config
) 
DEL %BOOT_CONFIG_FOLDER%\boot.tmp
ECHO Removing debugging files for selected Rimworld install...

DEL %RIMWORLD_INSTALL_DIR%\RimWorldWin64.exe
DEL %RIMWORLD_INSTALL_DIR%\UnityPlayer.dll
DEL %RIMWORLD_INSTALL_DIR%\WinPixEventRuntime.dll

RENAME "%RIMWORLD_INSTALL_DIR%\RimWorldWin64.exe.original" "RimWorldWin64.exe"
RENAME "%RIMWORLD_INSTALL_DIR%\UnityPlayer.dll.original" "UnityPlayer.dll"
GOTO MENU


:COPY_MODS
ECHO Copy mods...

GOTO MENU




:MENU
ECHO.
ECHO.
ECHO Rimworld Modding Environment Setup Tool
ECHO =======================================
ECHO.
ECHO 1 - Create local backup/development copy of Rimworld from Steam
ECHO 2 - Delete local backup/development copy of Rimworld
ECHO 3 - Make Rimworld compatible with VS/Unity debugging tools
ECHO 4 - Copy steam mods to local backup
ECHO 5 - Exit
ECHO.

SET /P M=Type 1, 2, 3, 4 or 5 and then press ENTER:  

IF %M%==1 GOTO BACKUP
IF %M%==2 GOTO DELETE_BACKUP
IF %M%==3 GOTO MAKE_DEBUG
IF %M%==4 GOTO COPY_MODS
IF %M%==5 GOTO EOF
GOTO MENU
:EOF