format PE gui

entry start

include 'win32a.inc'
include 'winmm.inc'
                 
section '.code' code readable executable
  start:
    invoke mixerGetNumDevs
    cmp eax, 01
    jl exit                   
  
    invoke mixerOpen, hMixer, 0, 0, 0, MIXER_OBJECTF_WAVEIN
    cmp eax, 0
    jnz exit
    
    mov edi, ml
    xor eax, eax
    mov ecx, sizeof.MIXERLINE 
    rep stosb
  
    
    mov [ml.cbStruct], sizeof.MIXERLINE
    mov [ml.dwComponentType], MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE
    
    invoke mixerGetLineInfo, [hMixer], ml, MIXER_GETLINEINFOF_COMPONENTTYPE
    cmp eax, 0
    jnz close
    
    mov edi, mlc
    xor eax, eax
    mov ecx, sizeof.MIXERLINECONTROLS 
    rep stosb
    
    mov edi, mc
    xor eax, eax
    mov ecx, sizeof.MIXERCONTROL 
    rep stosb       
    
    mov [mlc.cbStruct], sizeof.MIXERLINECONTROLS
    mov eax, [ml.dwLineID]
    mov [mlc.dwLineID], eax
    mov [mlc.dwControlType], MIXERCONTROL_CONTROLTYPE_VOLUME
    mov [mlc.cControls], 1
    mov [mlc.pamxctrl], mc
    mov [mlc.cbmxctrl], sizeof.MIXERCONTROL     
    
    invoke mixerGetLineControls, [hMixer], mlc, MIXER_GETLINECONTROLSF_ONEBYTYPE  
    cmp eax, 0
    jnz close

    mov [mcb.dwValue], 0
    
    mov edi, mcd
    xor eax, eax
    mov ecx, sizeof.MIXERCONTROLDETAILS 
    rep stosb
    
    mov [mcd.cbStruct], sizeof.MIXERCONTROLDETAILS
    mov eax, [mc.dwControlID]
    mov [mcd.dwControlID], eax 
    mov [mcd.paDetails], mcb 
    mov [mcd.cbDetails], sizeof.MIXERCONTROLDETAILS_UNSIGNED 
    mov [mcd.cChannels], 1
    mov [mcb.dwValue], 0FFFFh 
    
    invoke mixerSetControlDetails, [hMixer], mcd, MIXER_SETCONTROLDETAILSF_VALUE
    
  close:  
    invoke mixerClose, [hMixer]     

  exit:
    invoke sleep, 1000
    jmp start      

section '.data' data readable writable            
  hMixer dd 0
  ml MIXERLINE
  mlc MIXERLINECONTROLS
  mc MIXERCONTROL
  mcb MIXERCONTROLDETAILS_UNSIGNED
  mcd MIXERCONTROLDETAILS

section '.idata' import data readable
        library \
          kernel, 'kernel32.dll',\ 
          wmm, 'winmm.dll'        
        
        import kernel, sleep, 'Sleep'         
        import wmm,\
          mixerGetNumDevs, 'mixerGetNumDevs', \
          mixerSetControlDetails, 'mixerSetControlDetails', \
          mixerGetLineInfo, 'mixerGetLineInfoW', \
          mixerGetLineControls, 'mixerGetLineControlsW', \
          mixerOpen, 'mixerOpen', \
          mixerClose, 'mixerClose'
