@echo off
:: Windows Visual Performance Optimizer
:: Run as Administrator
echo.
echo Starting visual optimization...
echo.

:: Set Visual Effects to Best Performance
echo [1/35] Setting Visual Effects to Best Performance...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1

:: Disable Window Animations
echo [2/35] Disabling Window Animations...
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1

:: Disable Taskbar Animations
echo [3/35] Disabling Taskbar Animations...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Menu Show/Hide Animations
echo [4/35] Disabling Menu Animations...
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1

:: Disable Smooth Scrolling
echo [5/35] Disabling Smooth Scrolling...
reg add "HKCU\Control Panel\Desktop" /v SmoothScroll /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Selection Fade Effect
echo [6/35] Disabling Selection Fade Effect...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Listview Shadow
echo [7/35] Disabling Listview Shadow...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Transparency Effects
echo [8/35] Disabling Transparency Effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Aero Peek
echo [9/35] Disabling Aero Peek...
reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Window Snap
echo [10/35] Disabling Window Snap...
reg add "HKCU\Control Panel\Desktop" /v WindowArrangementActive /t REG_SZ /d 0 /f >nul 2>&1

:: Disable Snap Assist
echo [11/35] Disabling Snap Assist...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SnapAssist /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Peek at Desktop
echo [12/35] Disabling Peek at Desktop...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisablePreviewDesktop /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Show Window Contents While Dragging
echo [13/35] Disabling Show Window Contents While Dragging...
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f >nul 2>&1

:: Disable Cursor Shadow
echo [14/35] Disabling Cursor Shadow...
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul 2>&1

:: Disable Icon Shadows
echo [15/35] Disabling Icon Shadows...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Thumbnails - Show Icons Only
echo [16/35] Disabling Thumbnails...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v IconsOnly /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Thumbnail Cache
echo [17/35] Disabling Thumbnail Cache...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisableThumbnailCache /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Thumbnail Preview on Taskbar
echo [18/35] Disabling Taskbar Thumbnail Previews...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ExtendedUIHoverTime /t REG_DWORD /d 10000 /f >nul 2>&1

:: Disable Font Smoothing
echo [19/35] Disabling Font Smoothing...
reg add "HKCU\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 0 /f >nul 2>&1

:: Disable Smooth Edges of Screen Fonts
echo [20/35] Disabling Smooth Screen Fonts...
reg add "HKCU\Control Panel\Desktop" /v FontSmoothingType /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Drop Shadows for Icon Labels
echo [21/35] Disabling Drop Shadows for Icons...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Animations in Start Menu
echo [22/35] Disabling Start Menu Animations...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Live Tiles
echo [23/35] Disabling Live Tiles...
reg add "HKCU\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v NoTileApplicationNotification /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Notification Center Animations
echo [24/35] Disabling Action Center Animations...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Lock Screen Animations
echo [25/35] Disabling Lock Screen Animations...
reg add "HKLM\Software\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Windows Spotlight
echo [26/35] Disabling Windows Spotlight...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenOverlayEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Windows Tips and Suggestions
echo [27/35] Disabling Windows Tips...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Wallpaper JPEG Quality Reduction
echo [28/35] Setting Wallpaper Quality to Maximum...
reg add "HKCU\Control Panel\Desktop" /v JPEGImportQuality /t REG_DWORD /d 100 /f >nul 2>&1

:: Disable Background Apps
echo [29/35] Disabling Background Apps...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1

:: Set Solid Color Background (No Wallpaper for Performance)
echo [30/35] Optimizing Desktop Background...
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "" /f >nul 2>&1

:: Disable Desktop Icons Auto-Arrange
echo [31/35] Disabling Desktop Auto-Arrange...
reg add "HKCU\Software\Microsoft\Windows\Shell\Bags\1\Desktop" /v FFlags /t REG_DWORD /d 1075839525 /f >nul 2>&1

:: Disable Visual Effects on Buttons and Windows
echo [32/35] Disabling Button/Window Visual Effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax" /v DefaultApplied /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation" /v DefaultApplied /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations" /v DefaultApplied /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\CursorShadow" /v DefaultApplied /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Fade or Slide Effects
echo [33/35] Disabling Fade/Slide Effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DragFullWindows" /v DefaultApplied /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DropShadow" /v DefaultApplied /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Balloon Tips
echo [34/35] Disabling Balloon Tips...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableBalloonTips /t REG_DWORD /d 0 /f >nul 2>&1

:: Set Theme to Windows Classic Colors
echo [35/35] Optimizing Color Scheme...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes" /v CurrentTheme /t REG_SZ /d "%windir%\resources\Themes\aero.theme" /f >nul 2>&1

:: Restart Explorer to Apply Changes
echo.
echo Restarting Windows Explorer to apply changes...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

