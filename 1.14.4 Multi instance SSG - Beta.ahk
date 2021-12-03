#NoEnv
#SingleInstance Force


global fullscreen := 0 ; 0 = false and 1 = true
global deletedelay := 200 ; 1000 = 1 second (increase if it takes long to delete world)
global quitdelay := 2000 ; 1000 = 1 second (increase if it takes long to save world)
global bufferdelay := 50
global instances := 4 ; <-- Number of instances
global deleteworlds := 1 ; 0 = false and 1 = true
SetKeyDelay, 0
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

global PIDS := GetAllPIDs()
global PIDBUFFER := 0

MsgBox, Credit to Four for the instance pid method

GetAllPIDs()
{
  orderedPIDs := []
  currentInstance :=1
  currentPID := 0
  loop, %instances%
  {
    MsgBox, Click OK and then quickly select instance %currentInstance% then wait for like .5 seconds.
    currentInstance++
    sleep, 1500
    WinGet, currentPID, PID, A
    orderedPIDs.Push(currentPID)
  }
  return orderedPIDs
}

#Persistent
SetTimer, TitleFix, 20
return

TitleFix:
  Critical
  for i, PID in PIDS {
    WinSetTitle, ahk_pid %PID%, , Minecraft 1.14.4 - Instance %i%
  }
return


Switch(id)
{
  PID := PIDS[id]
  sleep, %bufferdelay%
  WinActivate, ahk_pid %PID%
  send {Numpad%id% down}
  sleep, 50
  send {Numpad%id% up}
  send {Esc}
  sleep, 1
  if (fullscreen==1)
    send {f11}
}


ExitWorld()
{
  if (fullscreen==1)
  	send {f11}
  sleep, 5
	WinGetActiveTitle, instance
  instanceNum := SubStr(instance, 29)
  send +{Tab}{Enter}
  send {Esc}+{Tab}{Enter}
  sleep, %quitdelay%
  send {Tab}{Enter}
  if (deleteworlds==1) {
    send {Tab 6}{Enter}
    send {Tab}{Enter}
    sleep, %deletedelay%
  }
  send {Tab 4}{Enter}
  sleep, 10
  send {Tab 3}{Enter}
  sleep, 10
  send {Tab 3}
  sleep, 10
  send {5}
  send {1}
  send {3}
  send {2}
  send {3}
  send {1}
  send {5}
  send {9}
  send {6}
  send {3}
  send {5}
  send {2}
  send {1}
  send {6}
  send {0}					
  send {4}
  send {5}
  sleep, 10
  send {Tab 6}{Enter}


  if(instanceNum>=instances)
    Switch(1)
  else
    Switch(instanceNum+1)
}


#IfWinActive, Minecraft
{

U:: ; Change to your reset hotkey.
  ExitWorld()
return
}

