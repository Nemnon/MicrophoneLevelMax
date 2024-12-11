  MIXER_OBJECTF_WAVEIN = 20000000h
  MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE = 1003h
  MIXER_GETLINEINFOF_COMPONENTTYPE = 3 
  MIXERCONTROL_CONTROLTYPE_VOLUME = 50030001h 
  MIXER_GETLINECONTROLSF_ONEBYTYPE = 2
  MIXER_SETCONTROLDETAILSF_VALUE = 0
  
  struct MIXERLINE_TARGET ; size 50h
    dwType dd ?
    dwDeviceID dd ?
    wMid dw ?
    wPid dw ?
    vDriverVersion dd ?
    szPname dw 32 dup ?
  ends
  
  struct MIXERLINE ; sizeof 118h
   cbStruct dd ?
   dwDestination dd ?
   dwSource dd ? 
   dwLineID dd ?
   fdwLine dd ?
   dwUser dd ?
   dwComponentType dd ?
   cChannels dd ?
   cConnections dd ?
   cControls dd ?
   szShortName dw 16 dup ?
   szName dw 64 dup ?
   Target MIXERLINE_TARGET
  ends              
 
  struct MIXERLINECONTROLS ;sizeof 18h
    cbStruct dd ?
    dwLineID dd ?
    union 
      dwControlID dd ?
      dwControlType dd ?
    ends
    cControls dd ?
    cbmxctrl dd ?
    pamxctrl dd ?  
  ends                                 
  
  struct MIXERCONTROL   ;sizeof=0xE4
    cbStruct dd ?
    dwControlID dd ?
    dwControlType dd ?
    fdwControl dd ?
    cMultipleItems dd ?
    szShortName dw 16 dup ?
    szName dw 64 dup ?
    union
      lMinimum dd ?
      lMaximum dd ?
      dwMinimum dd ?
      dwMaximum dd ?
      dwReserved dd 6 dup ?
    ends
    union       
      cSteps dd ?
      cbCustomData dd ?
      dwReserved2 dd 6 dup ?
    ends
  ends
 
  struct MIXERCONTROLDETAILS_UNSIGNED
    dwValue dd ?
  ends
  
  struct MIXERCONTROLDETAILS ; size 18h
    cbStruct dd ?
    dwControlID dd ?
    cChannels dd ?
    union
      hwndOwner dd ?
      cMultipleItems dd ?
    ends
    cbDetails dd ?
    paDetails dd ?
  ends
  
 