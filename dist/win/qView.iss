#define MyAppName "qView (VRC metadata)"
#define MyAppId "qViewVRC"
#define MyAppPublisher "jurplel and qView contributors"
#define MyAppURL "https://github.com/research-outpost/qView"
#define MyAppExeName "qView.exe"

; Update these when building
#define MyAppVersion "7.1-vrc1"
#define MyAppYear "2026"

[Setup]
AppId={{FA2AFA6F-5366-443F-B2EB-1DC357F1E31E}
AppName={#MyAppName}
AppPublisher={#MyAppPublisher}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\qView-VRC
LicenseFile=../../LICENSE
#if "MyArch" == "x86"
OutputBaseFilename=qView-{#MyAppVersion}-win32
#elif "MyArch" == "arm64"
OutputBaseFilename=qView-{#MyAppVersion}-winarm64
#else
OutputBaseFilename=qView-{#MyAppVersion}-win64
#endif
SetupIconFile=qView.ico
WizardSmallImageFile=wiz-small.bmp
WizardImageFile=wiz.bmp
UninstallDisplayName={#MyAppName}
UninstallDisplayIcon={app}\{#MyAppExeName}
VersionInfoVersion=7.1.1.0
AppCopyright=Copyright © 2018-{#MyAppYear}, {#MyAppPublisher}
MinVersion=0,6.1
DisableProgramGroupPage=yes
ChangesAssociations=yes
Compression=lzma
SolidCompression=yes
PrivilegesRequiredOverridesAllowed=dialog
#if "MyArch" == "x86"
ArchitecturesAllowed=x86
#elif "MyArch" == "arm64"
ArchitecturesInstallIn64BitMode=arm64
ArchitecturesAllowed=arm64
#else
ArchitecturesInstallIn64BitMode=x64
ArchitecturesAllowed=x64
#endif

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "startentry"; Description: "Create a start menu shortcut"; GroupDescription: "{cm:AdditionalIcons}";
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "fileassociation"; Description: "Create file associations"; GroupDescription: "Other:"; Flags: unchecked

[Files]
#if "MyArch" == "x86"
Source: "qView-Win32/*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs
#elif "MyArch" == "arm64"
Source: "qView-WinArm64/*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs
#else
Source: "qView-Win64/*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs
#endif
Source: "qView.VisualElementsManifest.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "win-tile-m.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "win-tile-s.png"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: startentry
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Registry]
; Key that specifies exe path to file associations
Root: HKA; Subkey: "SOFTWARE\Classes\{#MyAppId}.1"; Flags: uninsdeletekey; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\{#MyAppId}.1\shell\open\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Tasks: fileassociation

; File associations that point to the above key
Root: HKA; Subkey: "SOFTWARE\Classes\.bmp\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.cur\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.gif\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.icns\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.ico\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.jpeg\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.jpg\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.jpe\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.jfi\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.jfif\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.pbm\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.pgm\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.png\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.ppm\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.svg\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.svgz\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.tif\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.tiff\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.wbmp\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.webp\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.xbm\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.xpm\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
; plugins
Root: HKA; Subkey: "SOFTWARE\Classes\.ani\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.apng\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.avif\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.avifs\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.bw\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.exr\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.hdr\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.heic\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.heif\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.jxl\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.kra\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.ora\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.pcx\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.pic\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.psd\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.ras\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey. Subkey: "SOFTWARE\Classes\.rgb\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.rgba\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.sgi\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.tga\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation
Root: HKA; Subkey: "SOFTWARE\Classes\.xcf\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppId}.1"; ValueData: ""; Flags: uninsdeletevalue; Tasks: fileassociation

; Capabilities keys for default programs/apps to work
Root: HKA; Subkey: "Software\{#MyAppId}"; Flags: uninsdeletekey; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities"; ValueType: string; ValueName: "ApplicationName"; ValueData: "{#MyAppName}"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities"; ValueType: string; ValueName: "ApplicationDescription"; ValueData: "Practical and minimal image viewer"; Tasks: fileassociation

Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".bmp"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".cur"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".gif"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".icns"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".ico"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".jpeg"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".jpg"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".jpe"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".jfi"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".jfif"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".pbm"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".pgm"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".png"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".ppm"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".svg"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".svgz"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".tif"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".tiff"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".wbmp"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".webp"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".xbm"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".xpm"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
; plugins
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".ani"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".apng"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".avif"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".avifs"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".bw"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".exr"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".hdr"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".heic"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".heif"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".jxl"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".kra"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".ora"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".pcx"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".pic"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".psd"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".ras"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".rgb"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".rgba"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".sgi"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".tga"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation
Root: HKA; Subkey: "Software\{#MyAppId}\Capabilities\FileAssociations"; ValueType: string; ValueName: ".xcf"; ValueData: "{#MyAppId}.1"; Tasks: fileassociation

Root: HKA; Subkey: "Software\RegisteredApplications"; ValueType: string; ValueName: "qViewVRC"; ValueData: "Software\qViewVRC\Capabilities"; Flags: uninsdeletevalue; Tasks: fileassociation
