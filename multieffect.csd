<CsoundSynthesizer>
<CsInstruments>
sr = 44100
ksmps = 32 ;number of samples per control cycle
nchnls = 2 
0dbfs = 1

gitri ftgen 111,0,1024,7,-1, 512, 1, 512, -1 ;triangle
giwav ftgen 0,0, 1024, 7, -1, 128, -0.9, 128, -0.5, 512, 0.5, 128, 1, 128, 0.8 ;almost tanh

giwav2 ftgen 1, 0, 16384, 10, 1       ;sine wave

;lopass filter
instr 1
	ain inch 1


	ilfospeed = 20000
	ilfodepth = 500

	kvib vibr ilfodepth, ilfospeed, 111

	/*adelayoscil oscil 1, ilfospeed, gitri
	aunused delayr 0.1
	adelayed deltapi (ilfodepth * adelayoscil + ilfodepth + ksmps + 1) / sr
	delayw ain
	atremoloed = adelayed 
	*/
	

	acompressed compress2 ain, ain, -90, -52, -30, 3, 0.01 , 0.1 , 0.05
	
	adistorted = acompressed * ampdbfs(6)
	adistorted = (adistorted *512) + 512
	adistorted table adistorted, giwav 
	adistorted *= ampdbfs(-3)

	adelayR init 0

	adelayL delayr 0.05
	awriteInputL butterlp adistorted + (adelayL * ampdbfs(-12)) + (adelayR * ampdbfs(-12)), 4000 + kvib
	delayw awriteInputL
	aoutL = adistorted + (adelayL * ampdbfs(-6))

	adelayR delayr 0.051
	awriteInputR butterlp adistorted + (adelayR * ampdbfs(-12)) + (adelayL * ampdbfs(-12)), 4000 + kvib
	delayw awriteInputR
	aoutR = adistorted + (adelayR * ampdbfs(-6)) 

	outch 1, aoutL, 2, aoutR 
endin

; tremolo
instr 2
	ilfospeed = 7
	ilfodepth = 100
	ain inch 1
	adelayoscil oscil 1, ilfospeed, gitri
	aunused delayr 0.1
	adelayed deltapi (ilfodepth * adelayoscil + ilfodepth + ksmps + 1) / sr
	delayw ain
	aout = adelayed
	out aout, aout
endin

instr 3
	ain inch 1
	acompressed compress2 ain, ain, 0, 20, 20, 4, 0.1 , 0.5 , 0.02
	out acompressed, acompressed
endin


instr 4
	ain inch 1
	ain *= ampdbfs(12)
	ain = (ain *512) + 512
	ain table ain, giwav 
	ain *= ampdbfs(-6)
	out ain, ain
endin


</CsInstruments>
<CsScore>
i1 0 30

</CsScore>
</CsoundSynthesizer>