<CsoundSynthesizer>
<CsInstruments>

 

sr = 44100
ksmps = 1
nchnls = 2
0dbfs = 1.0

 

instr 1
    ain inch 1

    afiltered butterlp ain, 400

    kin downsamp afiltered

    klastvalue init -1
    kisflipped init 0
    kcount init 0

 

    if (klastvalue < 0 && kin > 0) || (klastvalue > 0 && kin < 0 ) then
        kcount += 1
    endif

 

    klastvalue = kin

 

    if kcount == 2 then
        kisflipped = kisflipped==0 ? 1 : 0
        kcount = 0
    endif

 

    aout = ain*(kisflipped==1 ? -1 : 1)

    aout butterlp aout, 400
    aout += ain
 

    out aout,aout
endin 

 


</CsInstruments>

 

<CsScore>
i1 0 30
</CsScore>
</CsoundSynthesizer>