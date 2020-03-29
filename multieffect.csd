<CsoundSynthesizer>
<CsInstruments>
sr = 44100
ksmps = 32 ;number of samples per control cycle
nchnls = 2 
0dbfs = 1

gacmb      init    0
garvb      init    0

instr 1         
	idur       =         p3
	iamp       =         ampdb(p4)
	ifrq       =         cpspch(p5)
	ifc        =         p6
	ifm        =         p7
	iatk       =         p8
	irel       =         p9
	indx1      =         p10
	indx2      =         p11
	indxtim    =         p12
	ilfodep    =         p13
	ilfofrq    =         p14
	ipan       =         p15
	irvbsnd    =         p16
	kampenv    expseg    .01, iatk, iamp, idur/9, iamp*.6, idur/(iatk+irel+idur/9),
	                     iamp*.7, irel, .01
	klfo       oscil     ilfodep, ilfofrq, 1
	kindex     expon     indx1, indxtim, indx2
	asig       foscil    kampenv, ifrq+klfo, ifc, ifm, kindex, 1
	           outs      asig*ipan, asig*(1-ipan)
	garvb      =         garvb+(asig*irvbsnd)
endin

</CsInstruments>
<CsScore>
f1  0 4096 10   1    


;		st	dr 	amp	frq		fc	fm	atk	rel	ndx1	ndx2	ndxtim  lfodep	lfofrq	pan	rvbsnd
;=================================================================================
i 1 	0	2	80	8.09	1	2	.01	.2	20		4		.5		7		5		1	.1  
i 1 	2	2	80	.		2	1	. 	. 	10		1		.8		.		6		0	.2  
i 1 	5	.2	80	.		1	2	. 	.1	30		.		.01		9		4		1	.1  
i 1 	+	.	79	.		2	1	.	.	<		<		<		<		<		<	< 
i 1 	+	.	78	.		1	3	.	.	.		.		.		.		.		.	.  
i 1 	+	.	77	.		3	1	.	.	.		.		.		.		.		.	.  
i 1 	+	.	76	.		1	4	.	.	.		.		.		.		.		.	.  
i 1 	+	.	75	.		4	1	.	.	.		.		.		.		.		.	.  
i 1 	+	.	74	.		1	5	.	.	.		.		.		.		.		.	.  
i 1 	+	.	73	.		5	1	.	.	.		.		.		.		.		.	.  
i 1 	+	.	72	.		1	6	.	.	.		.		.		.		.		.	.  
i 1 	+	1	71	.		6	1	.	.	10		3		.2		4		10		0	.04  
i 1 	+	.2	71	.		6	1	.	.	<		<		<		<		<		<	< 
i 1 	+	.	72	.		1	6	.	.	.		.		.		.		.		.	.  
i 1 	+	.	73	.		5	1	.	.	.		.		.		.		.		.	.  
i 1 	+	.	74	.		1	5	.	.	.		.		.		.		.		.	.  
i 1 	+	.	75	.		4	1	.	.	.		.		.		.		.		.	.  
i 1 	+	.	76	.		1	4	.	.	.		.		.		.		.		.	.  
i 1 	+	.	77	.		3	1	.	.	.		.		.		.		.		.	.  
i 1 	+	.	78	.		1	3	.	.	.		.		.		.		.		.	.  
i 1 	+	.	79	.		2	1	.	.	.		.		.		.		.		.	. 
i 1 	+	.2	80	.		1	2	. 	.1	30		1		.01		9		4		1	.1  
i 1 	+	2	80	.		2	1	.  	.2	10		4		.8		7		6		1	.2  
i 1 	2.5	4	80	.		1	2	. 	. 	20		4		.5		.		5		0	.1  
</CsScore>
</CsoundSynthesizer>