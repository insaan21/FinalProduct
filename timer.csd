<CsoundSynthesizer>
<CsInstruments>

 

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1.0

 

 

instr 1
    kcd init 0

 

    if kcd <= 0 then
        krn random 1,16
        krn = int(krn)*300
        event "i",10,0,1,krn
        kcd += 0.12
    endif

 

    kcd -= ksmps/sr
endin

 

 

instr 10
    ifrq = p4

 

    aenv linsegr 0,0.001,1,0.2,0.3,0.4,0.0
    asnd oscil aenv,ifrq,-1
    asnd *= ampdbfs(-24)

 

    outs asnd,asnd 
endin

 

 

 

</CsInstruments>

 

<CsScore>
i1 0 10

 

</CsScore>
</CsoundSynthesizer>