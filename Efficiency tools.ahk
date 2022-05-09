;感谢来自https://autohotkey.com/board/topic/83100-laptop-screen-brightness/ 提供的亮度控制功能

;下面两行作用为设置图标，现已注释

;SetWorkingDir %A_ScriptDir%	;设置工作路径

;Menu, Tray, Icon, 滚轮控制图标.ico, ,1	;设置图标文件，图标文件不能为英文

;全局变量

global NextWhellTime := A_TickCount ;上次响应时间初始化为脚本执行时间，提供滚轮加速支持

;提示定时消失

RemoveToolTip:

ToolTip

return

/*

;测试当前指向窗口的ID

+^q::

CoordMode,Mouse,Screen	;全局获取模式

MouseGetPos, , , id,	;获得指针指向窗口的ID

WinGetClass, class, ahk_id %id%	;获得窗口ID对应的窗口类

ToolTip, %class%	;以提示方式显示窗口类

Return

;测试某个全局变量值用

+^z::

ToolTip, 你好中文：%NextWhellTime%	;以提示方式显示窗口类

Return

;滚轮渐进增速测试

WheelUp::

IfWinActive, ahk_class Notepad

{

send, a

if (A_TickCount - NextWhellTime < 100)

{

send, b

}

if (A_TickCount - NextWhellTime < 50)

{

send, c

}

if (A_TickCount - NextWhellTime < 20)

{

send, d

}

NextWhellTime := A_TickCount

}

else

{

send, {WheelUp}

}

Return

*/

;滚轮控制音量和亮度

;bate 5	加入亮度调整、加入提示功能

WheelUp::

CoordMode,Mouse,Screen	;全局获取模式

MouseGetPos, xpos, ypos, id,	;获得指针指向窗口的屏幕度坐标和ID

WinGetClass, class, ahk_id %id%	;获得窗口ID对应的窗口类

if (ypos < 81)

{

TimeSpan := A_TickCount - NextWhellTime

if (TimeSpan < 100)

{

MoveBRightness(5)

}

else if (TimeSpan < 300)

{

MoveBRightness(3)

}

else

{

MoveBRightness(1)

}

NextWhellTime := A_TickCount ;刷新激活时间

}

else if((class = "Shell_TrayWnd") or (class = "WorkerW"))

{

send, {Volume_Up 1}

if (A_TickCount - NextWhellTime < 200)

{

send, {Volume_Up 1}

}

if (A_TickCount - NextWhellTime < 150)

{

send, {Volume_Up 1}

}

if (A_TickCount - NextWhellTime < 100)

{

send, {Volume_Up 1}

}

if (A_TickCount - NextWhellTime < 50)

{

send, {Volume_Up 1}

}

if (A_TickCount - NextWhellTime < 20)

{

send, {Volume_Up 1}

}

if (A_TickCount - NextWhellTime < 10)

{

send, {Volume_Up 1}

}

NextWhellTime := A_TickCount ;刷新激活时间

}

else

{

send, {WheelUp}

}



Return



WheelDown::

CoordMode,Mouse,Screen	;全局获取模式

MouseGetPos, xpos, ypos, id,	;获得指针指向窗口的屏幕度坐标和ID

WinGetClass, class, ahk_id %id%	;获得窗口ID对应的窗口类

if (ypos < 81)

{

TimeSpan := A_TickCount - NextWhellTime

if (TimeSpan < 100)

{

MoveBRightness(-5)

}

else if (TimeSpan < 300)

{

MoveBRightness(-3)

}

else

{

MoveBRightness(-1)

}

NextWhellTime := A_TickCount ;刷新激活时间

}

else if((class = "Shell_TrayWnd") or (class = "WorkerW"))

{

send, {Volume_Down 1}

if (A_TickCount - NextWhellTime < 200)

{

send, {Volume_Down 1}

}

if (A_TickCount - NextWhellTime < 150)

{

send, {Volume_Down 1}

}

if (A_TickCount - NextWhellTime < 100)

{

send, {Volume_Down 1}

}

if (A_TickCount - NextWhellTime < 50)

{

send, {Volume_Down 1}

}

if (A_TickCount - NextWhellTime < 20)

{

send, {Volume_Down 1}

}

if (A_TickCount - NextWhellTime < 10)

{

send, {Volume_Down 1}

}

NextWhellTime := A_TickCount ;刷新激活时间

}

else

{

send, {WheelDown}

}



Return



/*

;bate 1	直接进行热键替换

+WheelUp::Volume_Up

+WheelDown::Volume_Down



;bate 2	任务栏激活时有效

WheelUp::

IfWinActive, ahk_class Shell_TrayWnd

{

send, {Volume_Up}

}

else

{

send, {WheelUp}

}

Return

WheelDown::

IfWinActive, ahk_class Shell_TrayWnd

{

send, {Volume_Down}

}

else

{

send, {WheelDown}

}

Return



;bate 3	指针指向任务栏和桌面时有效

WheelUp::

CoordMode,Mouse,Screen	;全局获取模式

MouseGetPos, , , id,	;获得指针指向窗口的ID

WinGetClass, class, ahk_id %id%	;获得窗口ID对应的窗口类

if((class = "Shell_TrayWnd") or (class = "WorkerW"))

{

send, {Volume_Up}

}

else

{

send, {WheelUp}

}

Return

WheelDown::

CoordMode,Mouse,Screen	;全局获取模式

MouseGetPos, , , id,	;获得指针指向窗口的ID

WinGetClass, class, ahk_id %id%	;获得窗口ID对应的窗口类

if((class = "Shell_TrayWnd") or (class = "WorkerW"))

{

send, {Volume_Down}

}

else

{

send, {WheelDown}

}

Return



;bate 4	滚轮加速检测，滚动越快，调整越快

WheelUp::

CoordMode,Mouse,Screen	;全局获取模式

MouseGetPos, , , id,	;获得指针指向窗口的ID

WinGetClass, class, ahk_id %id%	;获得窗口ID对应的窗口类

if((class = "Shell_TrayWnd") or (class = "WorkerW"))

{

send, {Volume_Up 1}

if (A_TickCount - NextWhellTime < 200)

{

send, {Volume_Up 1}

}

if (A_TickCount - NextWhellTime < 150)

{

send, {Volume_Up 1}

}

if (A_TickCount - NextWhellTime < 100)

{

send, {Volume_Up 1}

}

if (A_TickCount - NextWhellTime < 50)

{

send, {Volume_Up 1}

}

if (A_TickCount - NextWhellTime < 20)

{

send, {Volume_Up 1}

}

if (A_TickCount - NextWhellTime < 10)

{

send, {Volume_Up 1}

}

NextWhellTime := A_TickCount ;刷新激活时间

}

else

{

send, {WheelUp}

}

Return



WheelDown::

CoordMode,Mouse,Screen	;全局获取模式

MouseGetPos, , , id,	;获得指针指向窗口的ID

WinGetClass, class, ahk_id %id%	;获得窗口ID对应的窗口类

if((class = "Shell_TrayWnd") or (class = "WorkerW"))

{

send, {Volume_Down 1}

if (A_TickCount - NextWhellTime < 200)

{

send, {Volume_Down 1}

}

if (A_TickCount - NextWhellTime < 150)

{

send, {Volume_Down 1}

}

if (A_TickCount - NextWhellTime < 100)

{

send, {Volume_Down 1}

}

if (A_TickCount - NextWhellTime < 50)

{

send, {Volume_Down 1}

}

if (A_TickCount - NextWhellTime < 20)

{

send, {Volume_Down 1}

}

if (A_TickCount - NextWhellTime < 10)

{

send, {Volume_Down 1}

}

NextWhellTime := A_TickCount ;刷新激活时间

}

else

{

send, {WheelDown}

}

Return

*/







MoveBrightness(IndexMove)

{



VarSetCapacity(SupportedBRightness, 256, 0)

VarSetCapacity(SupportedBRightnessSize, 4, 0)

VarSetCapacity(BRightnessSize, 4, 0)

VarSetCapacity(BRightness, 3, 0)



hLCD := DllCall("CreateFile"

, Str, "\\.\LCD"

, UInt, 0x80000000 | 0x40000000 ;Read | Write

, UInt, 0x1 | 0x2  ; File Read | File Write

, UInt, 0

, UInt, 0x3        ; open any existing file

, UInt, 0

, UInt, 0)



if hLCD != -1

{

DevVideo := 0x00000023, BuffMethod := 0, Fileacces := 0

NumPut(0x03, BRightness, 0, "UChar")      ; 0x01 = Set AC, 0x02 = Set DC, 0x03 = Set both

NumPut(0x00, BRightness, 1, "UChar")      ; The AC bRightness level

NumPut(0x00, BRightness, 2, "UChar")      ; The DC bRightness level

DllCall("DeviceIoControl"

, UInt, hLCD

, UInt, (DevVideo<<16 | 0x126<<2 | BuffMethod<<14 | Fileacces) ; IOCTL_VIDEO_QUERY_DISPLAY_BRIGHTNESS

, UInt, 0

, UInt, 0

, UInt, &Brightness

, UInt, 3

, UInt, &BrightnessSize

, UInt, 0)



DllCall("DeviceIoControl"

, UInt, hLCD

, UInt, (DevVideo<<16 | 0x125<<2 | BuffMethod<<14 | Fileacces) ; IOCTL_VIDEO_QUERY_SUPPORTED_BRIGHTNESS

, UInt, 0

, UInt, 0

, UInt, &SupportedBrightness

, UInt, 256

, UInt, &SupportedBrightnessSize

, UInt, 0)



ACBRightness := NumGet(BRightness, 1, "UChar")

ACIndex := 0

DCBRightness := NumGet(BRightness, 2, "UChar")

DCIndex := 0

BufferSize := NumGet(SupportedBRightnessSize, 0, "UInt")

MaxIndex := BufferSize-1



loop, %BufferSize%

{

ThisIndex := A_Index-1

ThisBRightness := NumGet(SupportedBRightness, ThisIndex, "UChar")

if ACBRightness = %ThisBRightness%

ACIndex := ThisIndex

if DCBRightness = %ThisBRightness%

DCIndex := ThisIndex

}



if DCIndex >= %ACIndex%

BRightnessIndex := DCIndex

else

BRightnessIndex := ACIndex



BRightnessIndex += IndexMove





if BRightnessIndex > %MaxIndex%

BRightnessIndex := MaxIndex



if BRightnessIndex < 0

BRightnessIndex := 0



TempLight := Floor(BRightnessIndex / MaxIndex *100)	;以提示方式显示当前亮度 修改 by shinyship

CoordMode, ToolTip

ToolTip, ----------------------------------------  亮度：%TempLight%  ---------------------------------------- ,0, 81

SetTimer, RemoveToolTip, -3000



NewBRightness := NumGet(SupportedBRightness, BRightnessIndex, "UChar")



NumPut(0x03, BRightness, 0, "UChar")               ; 0x01 = Set AC, 0x02 = Set DC, 0x03 = Set both

NumPut(NewBRightness, BRightness, 1, "UChar")      ; The AC bRightness level

NumPut(NewBRightness, BRightness, 2, "UChar")      ; The DC bRightness level



DllCall("DeviceIoControl"

, UInt, hLCD

, UInt, (DevVideo<<16 | 0x127<<2 | BuffMethod<<14 | Fileacces) ; IOCTL_VIDEO_SET_DISPLAY_BRIGHTNESS

, UInt, &Brightness

, UInt, 3

, UInt, 0

, UInt, 0

, UInt, 0

, Uint, 0)



DllCall("CloseHandle", UInt, hLCD)



}



}
#n::
;网易云快速启动
Run powershell ";clear; cd C:\Tools\UnblockNeteaseMusic-master; node app.js -p 80 -f 103.126.92.133",,hide
;WinWait,powershell, ,1
;send,#d
Run C:\Program Files (x86)\Netease\CloudMusic\cloudmusic.exe
return
;无优化趋势 如果需要调试，run,hide可改成min

;鼠标中键绑定Ctrl
MButton::Control
;其实是用于Renpy游戏的。

;绑定鼠标上侧键和滚轮控制关闭网页
;绑定鼠标下侧键和滚轮控制恢复网页。
;绑定鼠标左键和滚轮控制切换标签页

XButton2::Left

XButton1::Right

~LButton & Wheelup::
^+Tab
return

~LButton & Wheeldown::
^Tab
return

~XButton2 & Wheelup::
send {LButton}
send,^w
winwait,chrome.exe,,0.7
return

~XButton2 & Wheeldown::
send {LButton}
send,^w
winwait,chrome.exe,,0.7
return

~XButton1 & Wheelup::
send,^+T
winwait,chrome.exe,,0.7
return

~XButton1 & Wheeldown::
send,^+T
winwait,chrome.exe,,0.7
return
;这串命令的0.7代表等待时间 单位s

;鼠标Onetab增强
;~LButton & XButton1::!+0
;~LButton & XButton2::!+2
;暂时屏蔽上面这一行 因为目前用chrome分组功能代替了收纳功能
~XButton1 & XButton2::!+1
;左键+上侧键收纳当前标签
;左键+下侧键收纳全部标签
;上下侧键一起按弹出标签清单

;配合讯飞输入法快捷键进行语音输入
~XButton1 & MButton::F10
~XButton2 & MButton::^+S

#w::
run D:\Tools\EVERYTHING\Everything.exe
return

#b:: 

send ^c
sleep,100
run https://www.baidu.com/s?wd=%clipboard%   
return

#c::

send ^c
sleep,100
run http://www.google.com/search?q=%clipboard%
return

#t::

send ^c
sleep,100
;Run https://translate.google.cn/#auto/zh-CN/%clipboard%
Run notepad
return

#z::
send ^c
sleep,100
run https://search.bilibili.com/all?keyword=%clipboard%
return

::shuitie::感谢大大的分享！有你才有光！

;置顶当前窗口功能
#f::
winset,AlwaysOnTop,, A
return
;可以添加提示音效

;快捷操控录屏
;win+alt+r,文字框提示,系统提示音#!r

;热字串
::htmr-::star0822@hotmail.com
::gmr-::sweetchistar@gmail.com
::ss-::star0822
::zz-::zlq4229219
::dw-::08072961004
::nme-::チョウシンガン
::adrs-::東京都豊島区巣鴨4-17-12第二加藤ビル304


;新增快速跳转到菜鸟编程
#p::
send ^c
sleep,100
run https://www.runoob.com/?s=python3+%clipboard%
return

;新增快速跳转到vorker(openwork)
#v::
send ^c
sleep,100
run https://www.vorkers.com/company_list?field=&pref=&src_str=%clipboard%&sort=1&ct=com
return

;新增快速跳转到onecareer
#o::
send ^c
sleep,100
run https://www.onecareer.jp/searches/companies?keyword=%clipboard%&button=
return

;新增快速转到hinative日语板块
#h::
send ^c
sleep,100
run https://zh.hinative.com/search/questions?button=&language_id=45&q=%clipboard%&utm_content=global_header_questions_show&utm_medium=referral&utm_source=hinative
return