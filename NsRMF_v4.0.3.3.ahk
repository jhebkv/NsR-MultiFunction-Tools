; <COMPILER: v1.1.30.03>
File_Description 	= NsR MultiFunction Tools
File_Version 		= 4.0d build3
Product_Name 		= NsR MF
Product_Version 	= 4.0.3.3
Legal_Copyright 	= JeffArts, NsR MultiFunction © 2019
Legal_Trademarks 	= JeffArts - Jheb Krueger
Copyright 			= Copyright © 2012-2019
Author 				= Jheb Krueger, www.nusareborn.in
Comments 			=
Company_Name 		= JeffArts
Original_Filename 	= NsR MultiFunction.exe
Internal_Name		= NsR MultiFunction
File_Name 			= %Product_Name% - v%File_Version%
RegRead, UAC, HKEY_LOCAL_MACHINE, SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System, EnableLUA
if !A_IsAdmin
{
Log("Not running as admin. Restarting as admin")
if A_IsCompiled
DllCall("shell32\ShellExecuteA","uint",0,"str","RunAs","str",A_ScriptFullPath,"uint",0,"str",A_WorkingDir,"int",1)
else
DllCall("shell32\ShellExecuteA","uint",0,"str","RunAs","str",A_AhkPath,"str","""" . A_ScriptFullPath . """","str",A_WorkingDir,"int",1)
ExitApp
}
Loop %0%
{
GivenPath := %A_Index%
Loop %GivenPath%, 1
LongPath = %A_LoopFileLongPath%
}
Process, priority, , High
SetWorkingDir %A_ScriptDir%
SetBatchLines, -2
SetKeyDelay , -1, -1
SetDefaultMouseSpeed, 0
SendMode, Input
GroupAdd, WC3DOTA , Warcraft III
GroupAdd, WC3DOTA , DOTA 2
GroupAdd, WC3DOTA , Dota 2
#SingleInstance Force
#IfWinActive, ahk_group WC3DOTA
#MaxThreadsPerHotkey 1
#MaxThreadsBuffer On
#MaxMem 1024
#NoEnv
#InstallKeybdHook
#UseHook On
#Persistent
#Warn All, Off
EK 			= {LControl} {RControl} {LAlt} {RAlt} {LShift} {RShift} {LWin} {RWin} {AppsKey} {F1} {F2} {F3} {F4} {F5} {F6} {F7} {F8} {F9} {F10} {F11} {F12} {Left} {Right} {Up} {Down} {Home} {End} {PgUp} {PgDn} {Del} {Ins} {BS} {Capslock} {Numlock} {PrintScreen} {Pause} {Tab} {Space} {Numpad0} {Numpad1} {Numpad2} {Numpad3} {Numpad4} {Numpad5} {Numpad6} {Numpad7} {Numpad8} {Numpad9} {NumLock} {NumpadAdd} {NumpadClear} {NumpadDel} {NumpadDiv} {NumpadDot} {NumpadEnter}
CL			= Nothing|Auto|3Q|3W|3E|3Q Auto|3W Auto|3E Auto
RL			= Main Setting|Invokelist|Chat system|Customkey|Macro & UserCode
My_Temp 	= %A_Temp%\JeffArts\NsRMF
My_Data 	= %A_WorkingDir%\Data
Settings_ 	= %My_Data%\Settings.ini
Logo_ 		= %My_Temp%\Logo.png
fb_ 		= %My_Temp%\fb.png
2fb_ 		= %My_Temp%\fb_.png
tw_ 		= %My_Temp%\tw.png
2tw_ 		= %My_Temp%\tw_.png
tb_ 		= %My_Temp%\tb.png
2tb_		= %My_Temp%\tb_.png
read_ 		= %My_Temp%\readme.txt
log_		= %My_Temp%\log.txt
War_ 		= Software\Blizzard Entertainment\Warcraft III
NsR_ 		= Software\JeffArts\NsR MultiFunction
RegRead, NsRver, HKCU, %NsR_%, Version
If (NsRver="ERROR" or NsRver="" or NsRver<Product_Version)
GoSub, NsRReg
IfNotExist, %My_Data%
FileCreateDir, %My_Data%
IfNotExist, %My_Temp%
FileCreateDir, %My_Temp%
FileInstall, fb.png, %fb_%, 1
FileInstall, tw.png, %tw_%, 1
FileInstall, tb.png, %tb_%, 1
FileInstall, fb_.png, %2fb_%, 1
FileInstall, tw_.png, %2tw_%, 1
FileInstall, tb_.png, %2tb_%, 1
FileInstall, logo.png, %logo_%, 1
FileInstall, readme.txt, %read_%, 1
Menu, Tray, NoStandard
Menu, Tray, Add, &New Profile, New_Profile
Menu, Tray, Add, &Load, Load_Profile
Menu, Tray, Add, &Save, Save_Profile
Menu, Tray, Add, Save &As, Save_ProfileAs
Menu, Tray, Add
Menu, Tray, Add, Warcraft C&hat, WarChat
Menu, Tray, Add, Suspen&d Hotkeys, Suspend_Hotkeys
Menu, Tray, Add, &Pause Hotkeys, Pause_Hotkeys
Menu, Tray, Add
Menu, Tray, Add, Check &Updates, Update_Check
Menu, Tray, Add, Aut&o Update, AutoUpdate_Check
Menu, Tray, Add
Menu, Tray, Add, Se&ttings, Settings
Menu, Tray, Add, E&xit, GuiClose
Menu, Tray, Default, Se&ttings
Menu, File, Add, &New Profile, New_Profile
Menu, File, Add, &Clear Current Profile, Clear_Profile
Menu, File, Add
Menu, File, Add, &Load Profile, Load_Profile
Menu, File, Add, &Save, Save_Profile
Menu, File, Add, Save &As, Save_ProfileAs
Menu, File, Add
Menu, File, Add, E&xit, GuiClose
Menu, Settings, Add, Registr&y Fixer, RegFix
Menu, Settings, Add, Warcraft R&esolution, ResChange
Menu, Settings, Add, Warcraft C&hat, WarChat
Menu, Settings, Add
Menu, Settings, Add, Suspen&d Hotkeys, Suspend_Hotkeys
Menu, Settings, Add, &Pause Hotkeys, Pause_Hotkeys
Menu, About, Add, &How to Use, Readme
Menu, About, Add
Menu, About, Add, Check &Updates, Update_Check
Menu, About, Add, Aut&o Update, AutoUpdate_Check
Menu, About, Add
Menu, About, Add, A&bout, About
Menu, MyMenu, Add, &File, :File
Menu, MyMenu, Add, Se&ttings, :Settings
Menu, MyMenu, Add, &Help, :About
Menu, File, Default, &New Profile
Gui, Menu, MyMenu
GoSub, Ini_Load
GoSub, Gui_Load
GoSub, Hotkey_
GoSub, Control_
WinActivate,Warcraft III
WinWaitActive,Warcraft III
WinGetPos,,, WWX, WHX, Warcraft III
return
Control_:
If (Profile="ERROR" or Profile="")
Profile = General
If Wrc {
SetTimer, CheckWarcraft, 1000
Menu, Settings, Check, Warcraft C&hat
Menu, Tray, Check, Warcraft C&hat
}
If Sus {
Suspend, On
Menu, Settings, Check, Suspen&d Hotkeys
Menu, Tray, Check, Suspen&d Hotkeys
}
If (Hide="ERROR" or Hide="")
GuiControl,, Hide, 0
If !Hide
Gui, Show, xCenter h275 w235, %File_Name% | %Profile%
Else {
RegWrite, REG_DWORD, HKCU, %NsR_%\Config, System Tray, 0
GuiControl,, Hide, 0
}
If Wc3 {
RegWrite, REG_DWORD, HKCU, %NsR_%\Config, Warcraft III, 0
SplitPath, Wcx,, Dwar
Wcx=%Dwar%\war3.exe
If Win
Wco1=-window
If Fps
Wco2=-d3d9
If Ope
Wco4=opengl
If Rec
Run, %Nsr% %Wco1% %Wco2% %Wco3%, %Dwar%
Else
Run, %Wcx% %Wco1% %Wco2% %Wco3%, %Dwar%
}
If (Mou && Win && War)
SetTimer, CheckActiveWar3
If Aut_ {
GoSub, Uche_
Menu, About, Check, Aut&o Update
Menu, Tray, Check, Aut&o Update
SetTimer, AutoC_, 3600000
}
return
WarChat:
Gui, Submit, NoHide
Wrc:=!Wrc
RegWrite, REG_DWORD, HKCU, %NsR_%\Config, Chat, %Wrc%
Menu, Settings, ToggleCheck, Warcraft C&hat
Menu, Tray, ToggleCheck, Warcraft C&hat
If Wrc
SetTimer, CheckWarcraft, 1000
Else {
Suspend, Off
SetTimer, CheckWarcraft, Off
SetTimer, CheckChatting, Off
hWar3Proc:=0
}
return
Hotkey_:
If (Scr && War)
If (Scr!="ERROR")
Hotkey, %Scr%, Score, On
If (Inv)
Loop, 13
If (Ia%A_Index%)
If Ha%A_Index%
If (Ha%A_Index%!="ERROR")
Hotkey, % Ha%A_Index%, IH%A_Index%, On
If (Cha)
Loop, 4
If (Ca%A_Index%)
If (Hc%A_Index%)
If (Hc%A_Index%!="ERROR")
Hotkey, % Hc%A_Index%, Hc%A_Index%, On
If (Cus && War) {
Loop, 12
If (Cs%A_Index%)
If (Hs%A_Index%)
If (Hs%A_Index%!="ERROR")
Hotkey, % Hs%A_Index%, A%A_Index%, On
Loop, 6
If (Ci%A_Index%)
If (Hi%A_Index%)
If (Hi%A_Index%!="ERROR")
Hotkey, % Hi%A_Index%, I%A_Index%, On
}
If (Mac && Mca)
Loop, 4
If (Mc%A_Index%!="ERROR") {
StringLower, Mc%A_Index%, Mc%A_Index%
If (Mc%A_Index%)
Hotkey, % Mc%A_Index%, Mc%A_Index%, On
}
If (Mac && Uca && Uce) {
StringLower, Uce, Uce
StringSplit, Ucode, Uce, `n
Loop, %Ucode0% {
StringSplit, Ucr%A_Index%, Ucode%A_Index%, `=
If (Ucr%A_Index%1)
If (Ucr%A_Index%1!="ERROR")
Hotkey, % Ucr%A_Index%1, UC, On
StringSplit, Uck%A_Index%, Ucr%A_Index%2, `+
}
}
return
Save_Code:
Gui, Submit, NoHide
StringReplace, Uce, Uce, `n, [Break], All
SetTimer, CheckWarcraft, 1000
IniWrite, %Uce%, %ProfileD%, Macro, Usce
return
Ini_Save:
IniWrite, %Profile%, %Settings_%, Profile, Profile_Name
IniWrite, %ProfileD%, %Settings_%, Profile, Profile_Directory
IniWrite, %Inv%, %ProfileD%, Main, Invo
IniWrite, %Cha%, %ProfileD%, Main, Chat
IniWrite, %Cus%, %ProfileD%, Main, Cust
IniWrite, %Mac%, %ProfileD%, Main, Macr
IniWrite, %Del%, %ProfileD%, Main, Dela
IniWrite, %War%, %ProfileD%, Main, Warc
IniWrite, %Dot%, %ProfileD%, Main, DotA
IniWrite, %Scr%, %ProfileD%, Opti, Scor
IniWrite, %Leg%, %ProfileD%, Opti, Lega
IniWrite, %Win%, %ProfileD%, Opti, Wind
IniWrite, %Mou%, %ProfileD%, Opti, Mous
IniWrite, %Mca%, %ProfileD%, Macro, Mact
IniWrite, %Uca%, %ProfileD%, Macro, Usca
StringReplace, Uce, Uce, `n, [Break], All
IniWrite, %Uce%, %ProfileD%, Macro, Usce
IniWrite, %Sin%, %ProfileD%, Invoker, Smin
Loop, 13 {
IniWrite, % Ia%A_Index%, %ProfileD%, Invoker, Iac%A_Index%
IniWrite, % Ha%A_Index%, %ProfileD%, Invoker, HoA%A_Index%
}
Loop, 10
IniWrite, % Ic%A_Index%, %ProfileD%, Invoker, Iau%A_Index%
Loop, 6 {
IniWrite, % Ls%A_Index%, %ProfileD%, Invoker, Lsk%A_Index%
IniWrite, % Ci%A_Index%, %ProfileD%, Custom, Cinv%A_Index%
IniWrite, % Hi%A_Index%, %ProfileD%, Custom, Hoin%A_Index%
}
Loop, 4 {
IniWrite, % Ca%A_Index%, %ProfileD%, Chat, Cac%A_Index%
IniWrite, % Cb%A_Index%, %ProfileD%, Chat, Cal%A_Index%
IniWrite, % Hc%A_Index%, %ProfileD%, Chat, HoC%A_Index%
StringReplace, Ec%A_Index%, Ec%A_Index%, `n , [Break], All
IniWrite, % Ec%A_Index%, %ProfileD%, Chat, Ctx%A_Index%
IniWrite, % Mp%A_Index%, %ProfileD%, Macro, Poin%A_Index%
IniWrite, % Mc%A_Index%, %ProfileD%, Macro, MKey%A_Index%
Z:=A_Index
Loop, 5 {
X:=A_Index . Z
IniWrite, % M%X%, %ProfileD%, Macro, Mrec%X%
}
}
Loop, 12 {
IniWrite, % Cs%A_Index%, %ProfileD%, Custom, Cski%A_Index%
IniWrite, % Hs%A_Index%, %ProfileD%, Custom, Hosk%A_Index%
}
Reload
return
Ini_Load:
IniRead, Profile, %Settings_%, Profile, Profile_Name
IniRead, ProfileD, %Settings_%, Profile, Profile_Directory
If (LongPath!="") {
SplitPath, LongPath,, Profile_D, NsR, Profile
ProfileD = %Profile_D%\%Profile%.NsR
}
IniRead, Inv, %ProfileD%, Main, Invo
IniRead, Cha, %ProfileD%, Main, Chat
IniRead, Cus, %ProfileD%, Main, Cust
IniRead, Mac, %ProfileD%, Main, Macr
IniRead, Del, %ProfileD%, Main, Dela
IniRead, War, %ProfileD%, Main, Warc
IniRead, Dot, %ProfileD%, Main, DotA
IniRead, Scr, %ProfileD%, Opti, Scor
IniRead, Leg, %ProfileD%, Opti, Lega
IniRead, Win, %ProfileD%, Opti, Wind
IniRead, Mou, %ProfileD%, Opti, Mous
IniRead, Mca, %ProfileD%, Macro, Mact
IniRead, Uca, %ProfileD%, Macro, Usca
IniRead, Uce, %ProfileD%, Macro, Usce
If (Uce="ERROR")
Uce=
StringReplace, Uce, Uce, [Break], `n, All
IniRead, Sin, %ProfileD%, Invoker, Smin
Loop, 13 {
IniRead, Ia%A_Index%, %ProfileD%, Invoker, Iac%A_Index%
IniRead, Ha%A_Index%, %ProfileD%, Invoker, HoA%A_Index%
}
Loop, 10
IniRead, Ic%A_Index%, %ProfileD%, Invoker, Iau%A_Index%
Loop, 6 {
IniRead, Ls%A_Index%, %ProfileD%, Invoker, Lsk%A_Index%
StringLower, Ls%A_Index%, Ls%A_Index%
IniRead, Ci%A_Index%, %ProfileD%, Custom, Cinv%A_Index%
IniRead, Hi%A_Index%, %ProfileD%, Custom, Hoin%A_Index%
If (Hi%A_Index%="ERROR")
Hi%A_Index%=
If (Ls%A_Index%="ERROR")
Ls%A_Index%=
}
Loop, 4 {
IniRead, Ca%A_Index%, %ProfileD%, Chat, Cac%A_Index%
IniRead, Cb%A_Index%, %ProfileD%, Chat, Cal%A_Index%
IniRead, Hc%A_Index%, %ProfileD%, Chat, HoC%A_Index%
IniRead, Ec%A_Index%, %ProfileD%, Chat, Ctx%A_Index%
StringReplace, Ec%A_Index%, Ec%A_Index%, [Break], `n, All
If (Ec%A_Index%="ERROR")
Ec%A_Index%=
IniRead, Mp%A_Index%, %ProfileD%, Macro, Poin%A_Index%
IniRead, Mc%A_Index%, %ProfileD%, Macro, MKey%A_Index%
Z:=A_Index
Loop, 5 {
X:=A_Index . Z
IniRead, M%X%, %ProfileD%, Macro, Mrec%X%
}
}
X:=
Z:=
Loop, 12 {
IniRead, Cs%A_Index%, %ProfileD%, Custom, Cski%A_Index%
IniRead, Hs%A_Index%, %ProfileD%, Custom, Hosk%A_Index%
If (Hs%A_Index%="ERROR")
Hs%A_Index%=
}
RegRead, Wcx, HKCU, %War_%, ProgramX
RegRead, Fps, HKCU, %War_%\Video, lockfb
Fps:=!Fps
RegRead, Ope, HKCU, %War_%, Gfx OpenGL
RegRead, Scd, HKCU, %NsR_%, Path
RegRead, Scp, HKCU, %NsR_%, Program
RegRead, Nsr, HKCU, %NsR_%, Reconnect
RegRead, W3l, HKCU, %NsR_%, Warcraft
RegRead, Rec, HKCU, %NsR_%\Config, Reconnect
RegRead, Wc3, HKCU, %NsR_%\Config, Warcraft III
RegRead, Wrc, HKCU, %NsR_%\Config, Chat
RegRead, Sus, HKCU, %NsR_%\Config, Suspend
RegRead, Pau, HKCU, %NsR_%\Config, Pause
RegRead, Hide, HKCU, %NsR_%\Config, System Tray
RegRead, Aut_, HKCU, %NsR_%\Config, AutoUpdate
If !ProfileD && !Profile {
IniRead, Profile, %Settings_%, Profile, PrevProfile_Name
IniRead, ProfileD, %Settings_%, Profile, PrevProfile_Directory
IniWrite, ` , %Settings_%, Profile, PrevProfile_Name
IniWrite, ` , %Settings_%, Profile, PrevProfile_Directory
IniWrite, %Profile%, %Settings_%, Profile, Profile_Name
IniWrite, %ProfileD%, %Settings_%, Profile, Profile_Directory
}
return
Gui_Load:
Gui -MinimizeBox
Gui, Font, S7, Tahoma
Gui, Add, CheckBox, checked%Hide% x16 y254 h20 gTray vHide, Minimize to Tray
Gui, Add, Button, x146 y254 w80 h18 gSubmit, Submit
Gui, Add, Tab, x2 y2 w245 h250 , Settings|Invoker|Chat|Customkey|Macro
Gui, Tab, 1
Gui, Add, Button, x16 y207 w80 h20 gOpen_Warcraft, Warcraft III
Gui, Add, CheckBox, checked%Inv% x16 y37 w80 h20 vInv, Invoker
Gui, Add, CheckBox, checked%Cha% x16 y57 w80 h20 vCha, Chat
Gui, Add, CheckBox, checked%Cus% x16 y77 w80 h20 vCus, Customkey
Gui, Add, CheckBox, checked%Mac% x96 y37 w80 h20 vMac, Macro
Gui, Add, Text, x96 y61 w60, AutoCast (ms)
Gui, Add, Edit, x+5 w55 h18 +Right
Gui, Add, UpDown, w15 h17 +Range1-5000 vDel, %Del%
Gui, Add, Text, x96 y81 w60, ScoreBoard
Gui, Add, Hotkey, x+5 w55 h18 vScr, %Scr%
Gui, Add, Radio, checked%War% x16 y127 w80 h20 gWar vWar, Warcraft III
Gui, Add, Radio, checked%Dot% x16 y147 w80 h20 vDot, DotA 2
Gui, Add, CheckBox, checked%Leg% x16 y167 w80 h20 vLeg, Legacy
Gui, Add, CheckBox, checked%Ope% x116 y127 w80 h20 gOpenGL vOpe, OpenGL
Gui, Add, CheckBox, checked%Fps% x116 y147 w80 h20 gAfps vFps, FPS
Gui, Add, CheckBox, checked%Rec% x116 y167 w80 h20 gReconnect vRec, Reconnect
Gui, Add, CheckBox, checked%Win% x116 y187 w80 h20 gMouseBlck vWin, Windowed
Gui, Add, CheckBox, checked%Mou% x116 y207 w80 h20 gMouseBlck vMou, MouseBlck
Gui, Add, GroupBox, x6 y107 w220 h130 , Game
Gui, Add, GroupBox, x6 y17 w220 h90 , Main
Gui, Tab, 2
Gui, Add, Checkbox, checked%Sin% x200 y187 w15 h15 vSin
Gui, Add, Text, x195 y207 w40 h40 , Smart Invok
Gui, Add, CheckBox, checked%Ia1% x10 y37 w15 h15 vIa1
Gui, Add, CheckBox, checked%Ia2% x10 y57 w15 h15 vIa2
Gui, Add, CheckBox, checked%Ia3% x10 y77 w15 h15 vIa3
Gui, Add, CheckBox, checked%Ia4% x10 y97 w15 h15 vIa4
Gui, Add, CheckBox, checked%Ia5% x10 y117 w15 h15 vIa5
Gui, Add, CheckBox, checked%Ia6% x10 y137 w15 h15 vIa6
Gui, Add, CheckBox, checked%Ia7% x10 y157 w15 h15 vIa7
Gui, Add, CheckBox, checked%Ia8% x10 y177 w15 h15 vIa8
Gui, Add, CheckBox, checked%Ia9% x10 y197 w15 h15 vIa9
Gui, Add, CheckBox, checked%Ia10% x10 y217 w15 h15 vIa10
Gui, Add, DropDownList, choose%Ic1% AltSubmit R5 x25 y37 w65 h20 vIc1, %CL%
Gui, Add, DropDownList, choose%Ic2% AltSubmit R5 x25 y57 w65 h20 vIc2, %CL%
Gui, Add, DropDownList, choose%Ic3% AltSubmit R5 x25 y77 w65 h20 vIc3, %CL%
Gui, Add, DropDownList, choose%Ic4% AltSubmit R5 x25 y97 w65 h20 vIc4, %CL%
Gui, Add, DropDownList, choose%Ic5% AltSubmit R5 x25 y117 w65 h20 vIc5, %CL%
Gui, Add, DropDownList, choose%Ic6% AltSubmit R5 x25 y137 w65 h20 vIc6, %CL%
Gui, Add, DropDownList, choose%Ic7% AltSubmit R5 x25 y157 w65 h20 vIc7, %CL%
Gui, Add, DropDownList, choose%Ic8% AltSubmit R5 x25 y177 w65 h20 vIc8, %CL%
Gui, Add, DropDownList, choose%Ic9% AltSubmit R5 x25 y197 w65 h20 vIc9, %CL%
Gui, Add, DropDownList, choose%Ic10% AltSubmit R5 x25 y217 w65 h20 vIc10, %CL%
Gui, Add, Hotkey, x90 y37 w60 h20 vHa1, %Ha1%
Gui, Add, Hotkey, x90 y57 w60 h20 vHa2, %Ha2%
Gui, Add, Hotkey, x90 y77 w60 h20 vHa3, %Ha3%
Gui, Add, Hotkey, x90 y97 w60 h20 vHa4, %Ha4%
Gui, Add, Hotkey, x90 y117 w60 h20 vHa5, %Ha5%
Gui, Add, Hotkey, x90 y137 w60 h20 vHa6, %Ha6%
Gui, Add, Hotkey, x90 y157 w60 h20 vHa7, %Ha7%
Gui, Add, Hotkey, x90 y177 w60 h20 vHa8, %Ha8%
Gui, Add, Hotkey, x90 y197 w60 h20 vHa9, %Ha9%
Gui, Add, Hotkey, x90 y217 w60 h20 vHa10, %Ha10%
Gui, Add, CheckBox, checked%Ia11% x152 y37 w15 h15 vIa11,
Gui, Add, CheckBox, checked%Ia12% x152 y57 w15 h15 vIa12,
Gui, Add, CheckBox, checked%Ia13% x152 y77 w15 h15 vIa13,
Gui, Add, Hotkey, x170 y37 w50 h20 vHa11, %Ha11%
Gui, Add, Hotkey, x170 y57 w50 h20 vHa12, %Ha12%
Gui, Add, Hotkey, x170 y77 w50 h20 vHa13, %Ha13%
Gui, Add, Hotkey, x158 y107 w30 h20 vLs1, %Ls1%
Gui, Add, Hotkey, x158 y127 w30 h20 vLs2, %Ls2%
Gui, Add, Hotkey, x158 y147 w30 h20 vLs3, %Ls3%
Gui, Add, Hotkey, x158 y167 w30 h20 vLs4, %Ls4%
Gui, Add, Hotkey, x158 y187 w30 h20 vLs5, %Ls5%
Gui, Add, Hotkey, x158 y207 w30 h20 vLs6, %Ls6%
Gui, Add, GroupBox, x6 y17 w220 h220 , Skills
Gui, Tab, 3
Gui, Add, CheckBox, x16 y37 w20 h20 checked%Ca1% vCa1
Gui, Add, CheckBox, x46 y37 w20 h20 checked%Cb1% vCb1
Gui, Add, CheckBox, x16 y87 w20 h20 checked%Ca2% vCa2
Gui, Add, CheckBox, x46 y87 w20 h20 checked%Cb2% vCb2
Gui, Add, CheckBox, x16 y137 w20 h20 checked%Ca3% vCa3
Gui, Add, CheckBox, x46 y137 w20 h20 checked%Cb3% vCb3
Gui, Add, CheckBox, x16 y187 w20 h20 checked%Ca4% vCa4
Gui, Add, CheckBox, x46 y187 w20 h20 checked%Cb4% vCb4
Gui, Add, Hotkey, x16 y57 w50 h20 vHc1, %Hc1%
Gui, Add, Hotkey, x16 y107 w50 h20 vHc2, %Hc2%
Gui, Add, Hotkey, x16 y157 w50 h20 vHc3, %Hc3%
Gui, Add, Hotkey, x16 y207 w50 h20 vHc4, %Hc4%
Gui, Add, Edit, x76 y37 w140 h40 vEc1, %Ec1%
Gui, Add, Edit, x76 y87 w140 h40 vEc2, %Ec2%
Gui, Add, Edit, x76 y137 w140 h40 vEc3, %Ec3%
Gui, Add, Edit, x76 y187 w140 h40 vEc4, %Ec4%
Gui, Add, GroupBox, x6 y17 w220 h220 , Chat
Gui, Tab, 4
Gui, Add, CheckBox, x17 y37 w20 h20 checked%Cs1% vCs1
Gui, Add, CheckBox, x17 y67 w20 h20 checked%Cs2% vCs2
Gui, Add, CheckBox, x17 y97 w20 h20 checked%Cs3% vCs3
Gui, Add, CheckBox, x67 y37 w20 h20 checked%Cs4% vCs4
Gui, Add, CheckBox, x67 y67 w20 h20 checked%Cs5% vCs5
Gui, Add, CheckBox, x67 y97 w20 h20 checked%Cs6% vCs6
Gui, Add, CheckBox, x117 y37 w20 h20 checked%Cs7% vCs7
Gui, Add, CheckBox, x117 y67 w20 h20 checked%Cs8% vCs8
Gui, Add, CheckBox, x117 y97 w20 h20 checked%Cs9% vCs9
Gui, Add, CheckBox, x167 y37 w20 h20 checked%Cs10% vCs10
Gui, Add, CheckBox, x167 y67 w20 h20 checked%Cs11% vCs11
Gui, Add, CheckBox, x167 y97 w20 h20 checked%Cs12% vCs12
Gui, Add, CheckBox, x27 y167 w20 h20 checked%Ci1% vCi1
Gui, Add, CheckBox, x27 y197 w20 h20 checked%Ci2% vCi2
Gui, Add, CheckBox, x87 y167 w20 h20 checked%Ci3% vCi3
Gui, Add, CheckBox, x87 y197 w20 h20 checked%Ci4% vCi4
Gui, Add, CheckBox, x147 y167 w20 h20 checked%Ci5% vCi5
Gui, Add, CheckBox, x147 y197 w20 h20 checked%Ci6% vCi6
Gui, Add, Button, x36 y37 w28 h28 gHs1 vHs1, %Hs1%
Gui, Add, Button, x36 y67 w28 h28 gHs2 vHs2, %Hs2%
Gui, Add, Button, x36 y97 w28 h28 gHs3 vHs3, %Hs3%
Gui, Add, Button, x86 y37 w28 h28 gHs4 vHs4, %Hs4%
Gui, Add, Button, x86 y67 w28 h28 gHs5 vHs5, %Hs5%
Gui, Add, Button, x86 y97 w28 h28 gHs6 vHs6, %Hs6%
Gui, Add, Button, x136 y37 w28 h28 gHs7 vHs7, %Hs7%
Gui, Add, Button, x136 y67 w28 h28 gHs8 vHs8, %Hs8%
Gui, Add, Button, x136 y97 w28 h28 gHs9 vHs9, %Hs9%
Gui, Add, Button, x186 y37 w28 h28 gHs10 vHs10, %Hs10%
Gui, Add, Button, x186 y67 w28 h28 gHs11 vHs11, %Hs11%
Gui, Add, Button, x186 y97 w28 h28 gHs12 vHs12, %Hs12%
Gui, Add, Button, x46 y167 w30 h30 gHi1 vHi1, %Hi1%
Gui, Add, Button, x46 y197 w30 h30 gHi2 vHi2, %Hi2%
Gui, Add, Button, x106 y167 w30 h30 gHi3 vHi3, %Hi3%
Gui, Add, Button, x106 y197 w30 h30 gHi4 vHi4, %Hi4%
Gui, Add, Button, x166 y167 w30 h30 gHi5 vHi5, %Hi5%
Gui, Add, Button, x166 y197 w30 h30 gHi6 vHi6, %Hi6%
Gui, Add, GroupBox, x6 y147 w220 h90 , Inventory
Gui, Add, GroupBox, x6 y17 w220 h130 , Ability
Gui, Tab, 5
Gui, Add, CheckBox, x66 y27 w70 h20 checked%Mca% vMca, Activate
Gui, Add, Hotkey, x16 y47 w30 h20 vMc1, %Mc1%
Gui, Add, Hotkey, x66 y47 w30 h20 vM11, %M11%
Gui, Add, Hotkey, x96 y47 w30 h20 vM21, %M21%
Gui, Add, Hotkey, x126 y47 w30 h20 vM31, %M31%
Gui, Add, Hotkey, x156 y47 w30 h20 vM41, %M41%
Gui, Add, Hotkey, x186 y47 w30 h20 vM51, %M51%
Gui, Add, Hotkey, x16 y67 w30 h20 vMc2, %Mc2%
Gui, Add, Hotkey, x66 y67 w30 h20 vM12, %M12%
Gui, Add, Hotkey, x96 y67 w30 h20 vM22, %M22%
Gui, Add, Hotkey, x126 y67 w30 h20 vM32, %M32%
Gui, Add, Hotkey, x156 y67 w30 h20 vM42, %M42%
Gui, Add, Hotkey, x186 y67 w30 h20 vM52, %M52%
Gui, Add, Hotkey, x16 y87 w30 h20 vMc3, %Mc3%
Gui, Add, Hotkey, x66 y87 w30 h20 vM13, %M13%
Gui, Add, Hotkey, x96 y87 w30 h20 vM23, %M23%
Gui, Add, Hotkey, x126 y87 w30 h20 vM33, %M33%
Gui, Add, Hotkey, x156 y87 w30 h20 vM43, %M43%
Gui, Add, Hotkey, x186 y87 w30 h20 vM53, %M53%
Gui, Add, Hotkey, x16 y107 w30 h20 vMc4, %Mc4%
Gui, Add, Hotkey, x66 y107 w30 h20 vM14, %M14%
Gui, Add, Hotkey, x96 y107 w30 h20 vM24, %M24%
Gui, Add, Hotkey, x126 y107 w30 h20 vM34, %M34%
Gui, Add, Hotkey, x156 y107 w30 h20 vM44, %M44%
Gui, Add, Hotkey, x186 y107 w30 h20 vM54, %M54%
Gui, Add, CheckBox, x49 y48 w15 h15 checked%Mp1% vMp1
Gui, Add, CheckBox, x49 y68 w15 h15 checked%Mp2% vMp2
Gui, Add, CheckBox, x49 y88 w15 h15 checked%Mp3% vMp3
Gui, Add, CheckBox, x49 y108 w15 h15 checked%Mp4% vMp4
Gui, Add, CheckBox, x66 y147 w70 h20 checked%Uca% vUca, Activate
Gui, Add, Edit, x16 y167 w200 h60 vUce, %Uce%
Gui, Add, Button, x136 y147 w80 h18 gSave_Code, Save
Gui, Add, GroupBox, x6 y137 w220 h100 , UserCode
Gui, Add, GroupBox, x6 y17 w220 h120 , Macro
return
New_Profile:
IniWrite, ` , %Settings_%, Profile, Profile_Name
IniWrite, ` , %Settings_%, Profile, Profile_Directory
IniWrite, ` , %Settings_%, Profile, PrevProfile_Name
IniWrite, ` , %Settings_%, Profile, PrevProfile_Directory
Reload
return
Clear_Profile:
IniWrite, ` , %Settings_%, Profile, Profile_Name
IniWrite, ` , %Settings_%, Profile, Profile_Directory
IniWrite, %Profile%, %Settings_%, Profile, PrevProfile_Name
IniWrite, %ProfileD%, %Settings_%, Profile, PrevProfile_Directory
Reload
return
Save_Profile:
Gui, Submit, NoHide
If (Profile="General") or (Profile="ERROR")
GoSub, Save_ProfileAs
Else
GoSub, Ini_Save
return
Save_ProfileAs:
Gui, Submit, NoHide
Prev_Profile:=Profile
Prev_ProfileD:=ProfileD
FileSelectFile, ProfileD, S 1 2 8 16, %My_Data%, Save Profile As, *.NsR
SplitPath, ProfileD,, Profile_D, NsR, Profile
ProfileD = %Profile_D%\%Profile%.NsR
If (ProfileD="\.NsR") {
ProfileD:=Prev_ProfileD
Profile:=Prev_Profile
}
If (ProfileD!="ERROR")
GoSub, Ini_Save
return
Load_Profile:
Gui, Submit, NoHide
Prev_Profile:=Profile
Prev_ProfileD:=ProfileD
FileSelectFile, ProfileD, 1 2 8 16, %My_Data%, Select Profile, *.NsR
SplitPath, ProfileD,, Profile_D, NsR, Profile
ProfileD = %Profile_D%\%Profile%.NsR
If (ProfileD="\.NsR") {
ProfileD:=Prev_ProfileD
Profile:=Prev_Profile
}
If (ProfileD!="ERROR") {
IniWrite, %Profile%, %Settings_%, Profile, Profile_Name
IniWrite, %ProfileD%, %Settings_%, Profile, Profile_Directory
}
Reload
return
Suspend_Hotkeys:
Sus:=!Sus
RegWrite, REG_DWORD, HKCU, %NsR_%\Config, Suspend, %Sus%
Menu, Settings, ToggleCheck, Suspen&d Hotkeys
Menu, Tray, ToggleCheck, Suspen&d Hotkeys
Suspend, Toggle
return
Pause_Hotkeys:
Pau:=!Pau
RegWrite, REG_DWORD, HKCU, %NsR_%\Config, Pause, %Pau%
Menu, Settings, ToggleCheck, &Pause Hotkeys
Menu, Tray, ToggleCheck, &Pause Hotkeys
Pause, Toggle
return
Uche_:
UrlDownloadToFile, https://github.com/jhebkv/NsR-MultiFunction-Tools/raw/master/version.txt, %My_Temp%\currentversion.txt
FileReadLine, Latest_Version, %My_Temp%\currentversion.txt, 1
If (Product_Version < Latest_Version) {
MsgBox, 4, Check for Update, %File_Description% - v%Latest_Version% is available! `nWould you like to download new version?
IfMsgBox, Yes
{
Run, https://www.jeffarts.cf/
}
}
return
AutoC_:
GoSub, Uche_
return
Update_Check:
GoSub, Uche_
If (Product_Version = Latest_Version) or (Product_Version > Latest_Version)
MsgBox, 64, Info, Your %File_Description% is up to date!, 5
return
AutoUpdate_Check:
Aut_:=!Aut_
RegWrite, REG_DWORD, HKCU, %NsR_%\Config, AutoUpdate, %Aut_%
If Aut_ {
GoSub, Uche_
SetTimer, AutoC_, 3600000
}
Else
SetTimer, AutoC_, Off
Menu, About, ToggleCheck, Aut&o Update
Menu, Tray, ToggleCheck, Aut&o Update
return
Settings:
Gui, Show, xCenter h275 w235, %File_Name% | %Profile%
return
Reconnect:
Gui, Submit, NoHide
RegWrite, REG_DWORD, HKCU, %NsR_%\Config, Reconnect, %Rec%
return
Tray:
Gui, Submit, NoHide
If Hide
GuiControl,, Submit, Submit + Hide
Else
GuiControl,, Submit, Submit
RegWrite, REG_DWORD, HKCU, %NsR_%\Config, System Tray, %Hide%
return
Afps:
Gui, Submit, NoHide
If Fps
Fps:=0
Else
Fps:=1
RegWrite, REG_DWORD, HKCU, %War_%\Video, lockfb, %Fps%
return
OpenGL:
Gui, Submit, NoHide
RegWrite, REG_DWORD, HKCU, %War_%, Gfx OpenGL, %Ope%
return
Mouseblck:
Gui, Submit, NoHide
If (Mou && Win && War)
SetTimer, CheckActiveWar3
Else {
SetTimer, CheckActiveWar3,off
SetTimer, CheckInactiveWar3,Off
DllCall("ClipCursor", UInt, 0)
_locked:=0
}
return
ResChange:
Gui 4:Default
Gui, +AlwaysOnTop -MinimizeBox
SysGet, SysWidth, 0
SysGet, SysHeight, 1
Gui, Add, edit, w80 +Center
Gui, Add, UpDown, vWarw Range480-3000, %SysWidth%
Gui, Add, edit, yp x+5 w80 +Center
Gui, Add, UpDown, vWarh Range480-2000, %SysHeight%
Gui, Add, button,x10 w80, Change
Gui, Add, button,x+5 w80, Cancel
Gui, Show,, Warcraft ResChanger
return
4ButtonChange:
Gui, Submit, NoHide
RegWrite, REG_DWORD, HKCU, %War_%\Video, ResWidth, %Warw%
RegWrite, REG_DWORD, HKCU, %War_%\Video, ResHeight, %Warh%
Gui, Destroy
return
4GuiClose:
4ButtonCancel:
Gui, Destroy
return
Readme:
Gui 5:Default
Gui, +OwnDialogs -MinimizeBox +AlwaysOnTop
IniRead, Rea, %read_%, 1, How to use
StringReplace, Rea, Rea, [Break], `n, All
Gui, Font, S7, Tahoma
Gui, Add, Text, x136 y20, How to Use :
Gui, Add, DropDownList, choose%Htu% AltSubmit R5 x206 y17 w140 h10 gReadme2 vHtu, %RL%
Gui, Add, Edit, x16 y47 w330 h160 +ReadOnly vRea, %Rea%
Gui, Add, Button, x256 y227 w90 h20 , Ok
Gui, Add, GroupBox, x6 y7 w350 h215 , Readme
Gui, Show, xCenter h255 w360, How To Use
return
Readme2:
Gui, Submit, NoHide
IniRead, Rea, %read_%, %Htu%, How to use
StringReplace, Rea, Rea, [Break], `n, All
GuiControl,, Rea, %Rea%
return
5ButtonOk:
Gui, Destroy
return
About:
Gui, Submit, NoHide
Gui 3:Default
Gui, +OwnDialogs -MinimizeBox +AlwaysOnTop
Gui, Font, S7, Tahoma
Gui, Add, Text, x86 y27 w90 h60 , Program Name`nProgram Version`nAuthor`nCopyright`nRelease Date
Gui, Add, Text, x176 y27 w170 h60 , :  NsR MultiFunction`n:  %Product_Version%`n:  Jheb Krueger`n:  JeffArts`, NsR MF (c) 2019`n:  July`, 2019
Gui, Add, Text, x286 y117 w60 h80 +Left, NusaReborn`nyayuhhz`nAucT`nbakulsoak`nDSampoerna`nNSR-Superior`nsnackkulit
Gui, Add, Text, x176 y117 w100 h80 +Right, GProxy :`nChat Suspend :`nResolution Changer :`nTester :
Gui, Add, Text, x16 y117 w130 h130 , NsR MultiFunction/NsR MF (NusaReborn MultiFunction) is a tool that contains some features to costumize your Warcraft III keys (ex: Ability and Inventory) and Combine Invoker skills on DotA (Defense of the Ancients). Compatible with DOTA 2 created and designed by Jheb Krueger
Gui, Add, Button, x256 y227 w90 h20, Ok
Gui, Add, Text, x166 y207 w80 h20 , Contact me	:
Gui, Add, Text, x246 y207 w100 h20 cBlue glink1 vURL_link1, www.nusareborn.in
Gui, Add, Picture, x16 y27 w60 h60 , %Logo_%
Gui, Add, Picture, x166 y227 w20 h20 glink2 vURL_link2, %fb_%
Gui, Add, Picture, x196 y227 w20 h20 glink3 vURL_link3, %tw_%
Gui, Add, Picture, x226 y227 w20 h20 glink4 vURL_link4, %tb_%
Gui, Add, GroupBox, x6 y7 w350 h90 , Program Details
Gui, Add, GroupBox, x6 y97 w150 h150 , About Me
Gui, Add, GroupBox, x166 y97 w190 h110 , Thanks to
Process, Exist
PID_This := ErrorLevel
WinGet, Hw_Gui, ID, Ahk_Class AutoHotkeyGui AHK_PID %PID_This%
WM_SETCURSOR = 0x20
OnMessage(WM_SETCURSOR, "HandleMessage")
WM_MOUSEMOVE = 0x200
OnMessage(WM_MOUSEMOVE, "HandleMessage")
Gui, Show, xCenter h255 w360, About Me
return
Link1:
Run, http://goo.gl/04dm5a
return
Link2:
Run, http://fb.com/jhebkv
return
Link3:
Run, http://twitter.com/jhebkv
return
Link4:
Run, http://jhebkv.tumblr.com
return
3GuiClose:
3GuiEscape:
3ButtonOk:
Gui, Destroy
return
Open_Warcraft:
Gui, Submit, NoHide
RegRead, ProgramX, HKCU, %War_%, ProgramX
SplitPath, ProgramX,, Dwar
If !Dwar
GoSub, RegFix
Else {
If War {
RegWrite, REG_DWORD, HKCU, %NsR_%\Config, Warcraft III, 1
GoSub, Submit
}
}
return
Submit:
Gui, Submit, NoHide
GoSub, Save_Profile
return
RegFix:
Gui +OwnDialogs
Gui, Submit, NoHide
RegRead, ProgramX, HKCU, %War_%, ProgramX
SplitPath, ProgramX,, Dwar
FileSelectFolder, Dwar, *%Dwar%, 0, Select Warcraft III Folder | %File_Name%
IfExist, %Dwar%\war3.exe
{
RegWrite, REG_SZ, HKCU, %War_%, Program, %Dwar%\Warcraft III.exe
RegWrite, REG_SZ, HKCU, %War_%, ProgramX, %Dwar%\Frozen Throne.exe
RegWrite, REG_SZ, HKCU, %War_%, InstallPath, %Dwar%
RegWrite, REG_SZ, HKCU, %War_%, InstallPathX, %Dwar%
RegWrite, REG_SZ, HKCU, %War_%, War3CD, %Dwar%
RegWrite, REG_SZ, HKCU, %War_%, War3XCD, %Dwar%
RegWrite, REG_SZ, HKCU, %War_%\String, UserBnet, Jheb-Krueger
RegWrite, REG_SZ, HKCU, %War_%\String, UserLocal, Jheb Krueger
RegWrite, REG_SZ, HKCU, %NsR_%, Warcraft, %Dwar%\war3.exe
RegWrite, REG_SZ, HKCU, %NsR_%, Reconnect, %Dwar%\NusaReconnect.exe
FileInstall, NusaReconnect.exe, %Dwar%\NusaReconnect.exe, 1
GoSub, NsRReg
}
Else If Dwar=
return
Else
MsgBox, 16, ERROR, War3.exe not found.
return
NsRReg:
RegWrite, REG_SZ, HKCU, %NsR_%, Path, %A_ScriptDir%
RegWrite, REG_SZ, HKCU, %NsR_%, Version, %Product_Version%
RegWrite, REG_SZ, HKCU, %NsR_%, Program, %A_ScriptFullPath%
RegWrite, REG_SZ, HKCR, .NsR,, JeffArts.NsRMF
RegWrite, REG_SZ, HKCR, JeffArts.NsRMF\shell\open\command,, "%A_ScriptFullPath%" "`%1"
RegWrite, REG_SZ, HKCR, JeffArts.NsRMF\DefaultIcon,, %A_ScriptFullPath%,1
RegWrite, REG_SZ, HKCR, Applications\%A_ScriptName%\shell\open\command,, "%A_ScriptFullPath%" "`%1"
RegWrite, REG_SZ, HKCR, Applications\%A_ScriptName%\DefaultIcon,, %A_ScriptFullPath%,1
RegWrite, REG_SZ, HKCU, Software\Classes\.NsR,, JeffArts.NsRMF
RegWrite, REG_SZ, HKCU, Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.NsR\OpenWithList, a, %A_ScriptName%
RegWrite, REG_SZ, HKCU, Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.NsR\UserChoice, Progid, Applications\%A_ScriptName%
return
War:
Gui, Submit, NoHide
WinActivate,Warcraft III
WinWaitActive,Warcraft III
WinGetPos,,, WWX, WHX, Warcraft III
RegRead, ProgramX, HKCU, %War_%, ProgramX
SplitPath, ProgramX,, Dwar
If !Dwar
GoSub, RegFix
return
Score:
gui,submit,nohide
WinGetPos,,, WW, WH, Warcraft III
D:=Del/3
x:=WW*189/192
y:=WH*.075
MouseGetPos, x0, y0
MouseMove, %x%, %y%
Sleep, %D%
MouseMove, %x%, %y%
Sleep, %D%
MouseClick,L,%x%,%y%
Sleep, %D%
MouseMove, %x0%, %y0%
return
IG_(Z, X, Str1, Y, A, B, C)
{
Global War,Dot,Leg,Del,Ls1,Ls2,Ls3,Ls4,Ls5,Ls6,SP,SPC,SPA,SPB,RStat_
If !RStat_
SPC:=Z
GoSub, SP_Check
D:=Del/4
If (Leg && Dot) or War {
Spell:=Str1
Cast:=Y
Invoke:="r"
3Q:="q" "q" "q"
3W:="w" "w" "w"
3E:="e" "e" "e"
}
Else If (Dot && !Leg) {
Spell:=A . B . C
If (SPC=SPA)
Cast:=Ls4
If (SPC=SPB)
Cast:=Ls5
Invoke:=Ls6
3Q:=Ls1 . Ls1 . Ls1
3W:=Ls2 . Ls2 . Ls2
3E:=Ls3 . Ls3 . Ls3
}
If !SP {
If !RStat_ {
RStat_=1
SetTimer, RStats, 2000
Send, % Spell
Sleep, %D%
Send, % Invoke
Sleep, %D%
}
}
If (X=2 or SP)
Send, % Cast . "{LButton}"
Else If X=3
Send, % 3Q
Else If X=4
Send, % 3W
Else If X=5
Send, % 3E
Else If (X=6) {
Send, % 3Q
Sleep, %D%
Send, % Cast . "{LButton}"
}
Else If (X=7) {
Send, % 3W
Sleep, %D%
Send, % Cast . "{LButton}"
}
Else If (X=8) {
Send, % 3E
Sleep, %D%
Send, % Cast . "{LButton}"
}
Sleep, %D%
Send, {f1}
}
RStats:
RStat_=0
SetTimer, RStats, Off
return
SP_Check:
If Sin && Inv {
If (SPA!=SPC) {
If (SPA!="") {
If (SPB!=SPC) {
If (SPB!="") {
SPB:=% SPA
SPA:=% SPC
SP:=0
}
Else {
SPB:=% SPC
SP:=0
}
}
Else
SP:=1
}
Else {
SPA:=% SPC
SP:=0
}
}
Else
SP:=1
}
Else
SP:=0
return
IH1:
IG_(1, Ic1, "qwe", "b", Ls1, Ls2, Ls3)
return
IH2:
IG_(2, Ic2, "eew", "d", Ls3, Ls3, Ls2)
return
IH3:
IG_(3, Ic3, "qqe", "g", Ls1, Ls1, Ls3)
return
IH4:
IG_(4, Ic4, "www", "c", Ls2, Ls2, Ls2)
return
IH5:
IG_(5, Ic5, "eeq", "f", Ls3, Ls3, Ls1)
return
IH6:
IG_(6, Ic6, "qqw", "v", Ls1, Ls1, Ls2)
return
IH7:
IG_(7, Ic7, "eee", "t", Ls3, Ls3, Ls3)
return
IH8:
IG_(8, Ic8, "wwq", "x", Ls2, Ls2, Ls1)
return
IH9:
IG_(9, Ic9, "wwe", "z", Ls2, Ls2, Ls3)
return
IH10:
IG_(10, Ic10, "qqq", "y", Ls1, Ls1, Ls1)
return
IDH_(Str1, A) {
Global War
Global Dot
Global Leg
If (War) or (Dot && Leg)
D:=Str1
Else If (Dot && !Leg)
D:=A
Send, % D D D
}
IH11:
IDH_("q", Ls1)
return
IH12:
IDH_("w", Ls2)
return
IH13:
IDH_("e", Ls3)
return
CH_(X1, X2, Y1, Y2) {
If X1 {
If X2 {
StringReplace, Y1, Y1, `n, {Enter}{Shift Down}{Enter}{Shift Up}, All
Send, {Shift Down}{Enter}{Shift Up}
Send, % Y1
Send, {Enter}
}
Else {
StringReplace, Y1, Y1, `n, {Enter}{Enter}, All
Send, % "{Enter}" Y1 "{Enter}"
}
}
Else
Send, % "{" Y2 "}"
}
Hc1:
CH_(Ca1, Cb1, Ec1, Hc1)
return
Hc2:
CH_(Ca2, Cb2, Ec2, Hc2)
return
Hc3:
CH_(Ca3, Cb3, Ec3, Hc3)
return
Hc4:
CH_(Ca4, Cb4, Ec4, Hc4)
return
GA_(Xx, Yy) {
global WWX,WHX,Del
D:=Del/4
MouseGetPos, X1, Y1
sleep %D%
if !WWX
gosub war
X:=WWX*Xx
Y:=WHX*Yy
sleep %D%
MouseMove,%X%,%Y%
sleep %D%
MouseClick,L,%X%,%Y%
MouseClick,L,%X%,%Y%
sleep %D%
MouseMove,%X1%,%Y1%
}
A1:
GA_(.79, .81)
exit
A2:
GA_(.79, .88)
exit
A3:
GA_(.79, .95)
exit
A4:
GA_(.84, .81)
exit
A5:
GA_(.84, .88)
exit
A6:
GA_(.84, .95)
exit
A7:
GA_(.9, .81)
exit
A8:
GA_(.9, .88)
exit
A9:
GA_(.9, .95)
exit
A10:
GA_(.95, .81)
exit
A11:
GA_(.95, .88)
exit
A12:
GA_(.95, .95)
exit
IH_(X) {
Send, % "{" X "}"
}
I1:
IH_("Numpad1")
return
I2:
IH_("Numpad2")
return
I3:
IH_("Numpad4")
return
I4:
IH_("Numpad5")
return
I5:
IH_("Numpad7")
return
I6:
IH_("Numpad8")
return
Hs_(X) {
Global EK
Gui, Submit, NoHide
GuiControl,, %X%, ?
BlockInput, On
Input, %X%, C L1 * M, %EK%
BlockInput, Off
%X% := (ErrorLevel <> "Max") ? SubStr(ErrorLevel, 8) : %X%
GuiControl,, %X%, % %X%
}
Hi1:
Hs_("Hi1")
return
Hi2:
Hs_("Hi2")
return
Hi3:
Hs_("Hi3")
return
Hi4:
Hs_("Hi4")
return
Hi5:
Hs_("Hi5")
return
Hi6:
Hs_("Hi6")
return
Hs1:
Hs_("Hs1")
return
Hs2:
Hs_("Hs2")
return
Hs3:
Hs_("Hs3")
return
Hs4:
Hs_("Hs4")
return
Hs5:
Hs_("Hs5")
return
Hs6:
Hs_("Hs6")
return
Hs7:
Hs_("Hs7")
return
Hs8:
Hs_("Hs8")
return
Hs9:
Hs_("Hs9")
return
Hs10:
Hs_("Hs10")
return
Hs11:
Hs_("Hs11")
return
Hs12:
Hs_("Hs12")
return
Mac_(X) {
Global Del
D:=Del/2
Loop, 5 {
If !M%A_Index%%X% or A_Index=6
Break
StringLower, M%A_Index%%X%, M%A_Index%%X%
Send, % "{" M%A_Index%%X% "}"
If (Mp%X%) {
Sleep,%D%
Send, {Click}
}
Sleep, %D%
}
}
Mc1:
Mac_("1")
return
Mc2:
Mac_("2")
return
Mc3:
Mac_("3")
return
Mc4:
Mac_("4")
return
UC:
X:=1
Y:=1
Loop, %Ucode0% {
If (Ucr%Y%1=A_ThisHotkey) {
Loop, % Uck%Y%0 {
Uck:=Uck%Y%%X%
Send, % "{" Uck "}"
Sleep, %Del%
X:=X+1
}
}
Y:=Y+1
}
return
GuiClose:
ExitApp
return
HandleMessage(p_w, p_l, p_m, p_hw)
{
Global   WM_SETCURSOR, WM_MOUSEMOVE, fb_, tw_, tb_, 2fb_, 2tw_, 2tb_
Static   URL_hover, h_cursor_hand, h_old_cursor, CtrlIsURL, CtrlISIMG, LastCtrl
If (p_m = WM_SETCURSOR)
{
If URL_hover
Return, true
}
Else If (p_m = WM_MOUSEMOVE)
{
StringRight, CtrlIsIMG, A_GuiControl, 5
StringLeft, CtrlIsURL, A_GuiControl, 3
If (CtrlIsURL = "URL")
{
If URL_hover=
{
If (CtrlIsIMG = "Link2")
GuiControl,, URL_Link2, %2fb_%
Else If (CtrlIsIMG = "Link3")
GuiControl,, URL_Link3, %2tw_%
Else If (CtrlIsIMG = "Link4")
GuiControl,, URL_Link4, %2tb_%
Else If (CtrlIsIMG = "Link1")
{
Gui, Font, cRed S7 underline, Tahoma
GuiControl, Font, %A_GuiControl%
LastCtrl = %A_GuiControl%
}
h_cursor_hand := DllCall("LoadCursor", "uint", 0, "uint", 32649)
URL_hover := true
}
h_old_cursor := DllCall("SetCursor", "uint", h_cursor_hand)
}
Else
{
If URL_hover
{
Gui, Font, s7 normal cBlue, Tahoma
GuiControl,, URL_Link2, %fb_%
GuiControl,, URL_Link3, %tw_%
GuiControl,, URL_Link4, %tb_%
GuiControl, Font, %LastCtrl%
DllCall("SetCursor", "uint", h_old_cursor)
URL_hover=
}
}
}
}
CheckWarcraft:
Log("Checking Warcraft III")
IfWinNotExist, ahk_class Warcraft III
Return
SetTimer, CheckWarcraft, Off
Log("Warcraft III found. Waiting 5 seconds...")
Sleep, 5000
IfWinExist, ahk_class Warcraft III
{
WinGet, pid, PID
Log("Warcraft III still found")
if hWar3Proc > 0
DllCall("CloseHandle", "UInt", hWar3Proc)
hWar3Proc := DllCall("OpenProcess", "UInt", 0x0010 | 0x0400, "Int", 0, "UInt", pid)
if (hWar3Proc = 0 || ErrorLevel)
{
Log("Failed to open war3 process with code: " . A_LastError)
SetTimer, CheckWarcraft, On
Return
}
chatAddr := GetChatAddr(pid)
if (chatAddr < 0)
{
Log("Failed to get chat address")
if (chatAddr = -1)
SetTimer, CheckWarcraft, On
Return
}
Log("Got chat address: " . chatAddr)
SetTimer, CheckChatting, 100
}
else
{
Log("Warcraft III no longer found")
SetTimer, CheckWarcraft, On
}
Return
GetChatAddr(pid)
{
hSnapshot := DllCall("CreateToolhelp32Snapshot", "UInt", 0x08, "UInt", pid)
if (hSnapshot < 0 || ErrorLevel)
{
Log("Failed to take module snapshot with code: " . A_LastError)
Return -2
}
VarSetCapacity(me32, 548)
NumPut(548, me32)
if DllCall("Module32First", "UInt", hSnapshot, "UInt", &me32)
{
VarSetCapacity(szModule, 256)
Loop
{
DllCall("RtlMoveMemory", "Str", szModule, "UInt", &me32 + 32, "UInt", 256)
Log("Found module: " . szModule)
if (szModule = "Game.dll")
{
DllCall("CloseHandle", "UInt", hSnapshot)
VarSetCapacity(szExePath, 260)
DllCall("RtlMoveMemory", "Str", szExePath, "UInt", &me32 + 288, "UInt", 260)
Log("Path of game.dll: " . szExePath)
FileGetVersion,version,%szExePath%
if (InStr(version, "1.24."))
offset := 0xAE8450
else if (version = "1.26.0.6401")
offset := 0xAD15F0
else
{
Log("Warcraft III version: " . version . " is not supported")
Return -2
}
Return NumGet(me32, 20, "UInt") + offset
}
if !DllCall("Module32Next", "UInt", hSnapshot, "UInt", &me32)
Break
}
}
DllCall("CloseHandle", "UInt", hSnapshot)
Log("game.dll was not found")
Return -1
}
CheckChatting:
if ManualSuspend
return
if ReadChatState(hWar3Proc, chatAddr, chatState)
{
if chatState
Suspend, On
else
Suspend, Off
}
else
{
SetTimer, CheckChatting, Off
DllCall("CloseHandle", "UInt", hWar3Proc)
hWar3Proc := 0
SetTimer, CheckWarcraft, On
Suspend, Off
}
Return
ReadChatState(handle, chatAddr, ByRef chatState)
{
if (DllCall("ReadProcessMemory", "UInt", handle, "UInt", chatAddr, "UInt*", chatState, "UInt", 4, "UInt", 0) = 0 || ErrorLevel)
{
Log("Can not read memory location: " . chatAddr . ". Last chat state: " . chatState)
Return 0
}
Return 1
}
DebugPrivilegesEnable()
{
Log("In DebugPrivilegesEnable")
Process, Exist
h := DllCall("OpenProcess", "UInt", 0x0400, "Int", false, "UInt", ErrorLevel)
if (!h || ErrorLevel)
Log("OpenProcess failed with code: " . A_LastError)
success := DllCall("Advapi32.dll\OpenProcessToken", "UInt", h, "UInt", 32, "UIntP", t)
if (!success || ErrorLevel)
Log("OpenProcessToken failed with code: " . A_LastError)
VarSetCapacity(ti, 16, 0)
NumPut(1, ti, 0)
sucecss := DllCall("Advapi32.dll\LookupPrivilegeValueA", "UInt", 0, "Str", "SeDebugPrivilege", "Int64P", luid)
if (!success || ErrorLevel)
Log("LookupPrivilegeValue failed with code: " . A_LastError)
NumPut(luid, ti, 4, "int64")
NumPut(2, ti, 12)
success := DllCall("Advapi32.dll\AdjustTokenPrivileges", "UInt", t, "Int", false, "UInt", &ti, "UInt", 0, "UInt", 0, "UInt", 0)
if (!success || ErrorLevel)
Log("AdjustTokenPrivileges failed with code: " . A_LastError)
else
Log("AdjustTokenPrivileges succeeded with code: " . A_LastError)
DllCall("CloseHandle", "UInt", h)
}
CheckActiveWar3:
hWnd := WinActive("ahk_classWarcraft III")
if hWnd
{
SetTimer,CheckActiveWar3,Off
if GetWindowClientRect(hWnd,rect) && DllCall("ClipCursor","UInt",&rect)
{
_locked := 1
SetTimer,CheckInactiveWar3
}
else
SetTimer,CheckActiveWar3
}
Return
CheckInactiveWar3:
IfWinNotActive,ahk_id%hWnd%
{
SetTimer,CheckInactiveWar3,Off
if DllCall("ClipCursor")
{
_locked := 0
SetTimer,CheckActiveWar3
}
else
SetTimer,CheckInactiveWar3
}
Return
GetWindowClientRect(hWnd,ByRef rect)
{
if !hWnd
Return,0
VarSetCapacity(cRect,16)
if !DllCall("GetClientRect","UInt",hWnd,"UInt",&cRect)
Return,0
global cWidth := NumGet(cRect,8,"Int") - NumGet(cRect,0,"Int")
global cHeight := NumGet(cRect,12,"Int") - NumGet(cRect,4,"Int")
VarSetCapacity(rect,16)
if !DllCall("GetWindowRect","UInt",hWnd,"UInt",&rect)
Return,0
wWidth := NumGet(rect,8,"Int") - NumGet(rect,0,"Int")
margin := (wWidth - cWidth)//2
NumPut(NumGet(rect,8,"Int") - margin,rect,8,"Int")
NumPut(NumGet(rect,12,"Int") - margin,rect,12,"Int")
NumPut(NumGet(rect,8,"Int") - cWidth,rect,0,"Int")
NumPut(NumGet(rect,12,"Int") - cHeight,rect,4,"Int")
global left := NumGet(rect,0,"Int")
global top := NumGet(rect,4,"Int")
Return,1
}
Log(txt)
{
FileAppend, %txt%, %log_%
}