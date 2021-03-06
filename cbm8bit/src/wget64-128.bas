!--------------------------------------------------
!- Monday, May 22, 2017 2:10:02 AM
!- Import of : 
!- c:\src\zimodem\cbm8bit\src\wget64-128.prg
!- Commodore 64
!--------------------------------------------------
1 REM WGET4/128  1200B 1.8+
2 REM UPDATED 03/11/2017 03:54P
10 POKE254,PEEK(186):IFPEEK(65532)=61THENPOKE58,254:CLR
15 OPEN5,2,0,CHR$(8):DIMPP$(25):P$="ok":POKE186,PEEK(254):XB=1200:BA=1200
20 CR$=CHR$(13):PRINTCHR$(14);:SY=PEEK(65532):POKE53280,254:POKE53281,246
30 PRINT"{light blue}":IFSY=226THENML=49152:POKE665,73:POKE666,3:UM=ML+2048:XB=9600
40 IFSY=226ANDPEEK(ML)<>76THENCLOSE5:LOAD"pml64.bin",PEEK(186),1:RUN
45 IFSY=226ANDUM>0ANDPEEK(UM)<>76THENCLOSE5:LOAD"up9600.bin",PEEK(254),1:RUN
50 IFSY=61THENML=4864:POKE981,15:P=PEEK(215)AND128:IFP=128THENSYS30643:XB=2400
60 IFSY=61ANDPEEK(ML)<>76THENCLOSE5:LOAD"pml128.bin",PEEK(186),1:RUN
80 IFSY=226ANDUM>0THENSYSUM:SYSUM+3:X=PEEK(789):SYSUM+9:IFX=234THENXB=1200
100 REM
101 REM
102 REM
110 P$="a"
120 PRINT"{clear}{down*2}WGET v1.0":PRINT"Requires 64Net WiFi firmware 2.0+"
140 PRINT"By Bo Zimmerman (bo@zimmers.net)":PRINT:PRINT
197 REM --------------------------------
198 REM GET STARTED                    !
199 REM -------------------------------
200 UN=PEEK(254)
201 PH=0:PT=0:MV=ML+18
202 PRINT "Initializing modem...":CR$=CHR$(13)+CHR$(10)
203 GET#5,A$:IFA$<>""THEN203
205 PRINT#5,CR$;"athz0e0";CR$;:GOSUB900:IFP$<>"ok"THEN203
208 GET#5,A$:IFA$<>""THEN208
210 PRINT#5,CR$;"ate0n0r0v1q0";CR$;
220 GOSUB900:IFP$<>"ok"THEN208
225 GET#5,A$:IFA$<>""THEN225
230 PRINT#5,"ate0v1x1f3q0s40=128";CR$;CHR$(19);
240 GOSUB900:IFP$<>"ok"THENPRINT"Zimodem init failed: ";P$:STOP
250 DIM HH$(20):UR$="www.zimmers.net/index.html":OT$="":OF$="@0:wget-output,s"
300 REM GET INFO
310 PRINT:PRINT"{down}Request Parms:"
320 PRINT " *) Type       : GET"
321 PRINT " 1) Url        : http://";UR$
322 PRINT " 2) Output Unit:";UN
323 PRINT " 3) Output File: ";OF$
329 LW=3
330 NH=0:FORI=0TO20:IFLEN(HH$(I))>0THENNH=NH+1:PRINTSTR$(LW+NH)+") "+HH$(I):NEXT
340 LH=LW+NH+1:PRINTSTR$(LW+1+NH)+") Add New Header"
370 IFUR$=""THENPRINT:P$="1":GOTO400
380 PRINT:PRINT"Type a number or RETURN{sh space}to begin:";
390 GOSUB5000:IFP$=""THEN1000
400 X=VAL(P$):IFX<1ORX>LHTHEN300
410 IFX=1THENPRINT"Enter URL: http://";:GOSUB5000:UR$=P$:GOTO300
420 IFX=2THENPRINT"Enter output device/unit: ";:GOSUB5000:UN=VAL(P$):GOTO300
430 IFX=3THENPRINT"Enter output file: ";:GOSUB5000:OF$=P$:GOTO300
440 IFX<>LHTHENP$=HH$(X-LW):PRINT"Modify: ";P$:GOSUB5005:HH$(X-LW)=P$:GOTO300
450 II=-1:FORI=0TO20:IFHH$(I)=""ANDII=0THENII=I
460 NEXT:IFII>=0THENPRINT"New Header: ";:GOSUB5000:HH$(II)=P$
470 GOTO 300
597 REM --------------------------------
598 REM TRANSMIT P$ TO THE OPEN SOCKET !
599 REM -------------------------------
600 OP$=P$:SYSML+9:C8$=MID$(STR$(PEEK(MV+8)),2)
610 PRINT#5,"ats42=";C8$;"tp";QU$;P$;QU$
620 E$="ok":SYSML:IFP$<>"ok"THENP$=OP$:PRINT"{yellow}{reverse on}Retrying..{reverse off}{light blue}";CC$:GOTO600
630 RETURN
650 OP$=P$:SYSML+9:C8$=MID$(STR$(PEEK(MV+8)),2):PN$=MID$(STR$(LEN(P$)),2)
660 PRINT#5,"ats42=";C8$;"t";PN$:PRINT#5,P$
670 E$="ok":SYSML:IFP$<>"ok"THENP$=OP$:PRINT"{yellow}{reverse on}Retrying..{reverse off}{light blue}";CC$:GOTO650
680 RETURN
697 REM --------------------------------
698 REM GET NEXT FROM SOCKET INTO PP   !
699 REM -------------------------------
700 GOSUB930:IFP0<>PANDP0>0THENPRINT"Unexpected packet id: ";P0;"/";P:STOP
710 IFP0=0THENRETURN
720 PP$(PE)=P$:PE=PE+1:IFPE>=25THENPE=0
790 P$="":RETURN
797 REM --------------------------------
798 REM GET P$ FROM SOCKET P           !
799 REM -------------------------------
800 P$="":E=0:IFPH>=25THENPH=0
810 IFPH<>PETHENP$=PP$(PH):PH=PH+1:RETURN
820 GOSUB700:IFP0=0THENE=1:RETURN:REM FAIL
830 IFPH<>PETHENP$=PP$(PH):PH=PH+1:RETURN
840 E=1:RETURN
897 REM --------------------------------
898 REM GET E$ FROM MODEM, OR ERROR    !
899 REM -------------------------------
900 E$=""
910 SYSML
920 IFE$<>""ANDP$<>E$THENPRINT"{reverse on}{red}Comm error. Expected ";E$;", Got ";P$;"{light blue}{reverse off}"
925 RETURN
927 REM --------------------------------
928 REM GET PACKET HEADER, SETS P0,P1,P2, RETURNS P0=0 IF NADA
929 REM -------------------------------
930 PR=0:SYSML+12:P$=""
940 PRINT#5,CHR$(17);
945 SYSML+6:P0=PEEK(MV+2):P1=PEEK(MV+4):P2=PEEK(MV+6)
950 PL=PEEK(MV+0):CR=PEEK(MV+1):C8=PEEK(MV+8)
960 IFP0>0ANDP2<>C8THENPRINT#5,"atl0":GOTO945
970 IFP1=0THENP$=""
980 IFCR=255THENP$="":P0=0:P1=0:P2=0:PL=0:PRINT"{reverse on}{yellow}Error, retry.{reverse off}{light blue}":RETURN
990 RETURN
995 PRINT"Expected ";E$;", got ";A$:STOP
997 REM --------------------------------
998 REM THE MAIN LOOP                  !
999 REM -------------------------------
1000 IFLEN(UR$)=0ORLEN(OF$)=0THEN300
1010 I=0
1020 IFMID$(UR$,I+1,1)<>"/"THENI=I+1:IFI<LEN(UR$)THEN1020
1030 H1$=LEFT$(UR$,I):P1$=MID$(UR$,I+1):IFP1$=""THENP1$="/"
1040 I=0
1050 IFMID$(H1$,I+1,1)<>":"THENI=I+1:IFI<LEN(H1$)THEN1050
1060 HO$=LEFT$(H1$,I):IFI>=LEN(H1$)THENH1$=H1$+":80"
1070 AT$="":IFXB>0ANDBA>0ANDXB<>BATHENAT$="s43="+MID$(STR$(XB),2)
1080 GET#5,A$:IFA$<>""THEN1080
1100 QU$=CHR$(34):PRINT#5,"ath"+AT$+"&d10&m10&m13c";QU$;H1$;QU$
1105 GOSUB900
1110 IFLEN(P$)>8ANDLEFT$(P$,8)="connect "THENP=VAL(MID$(P$,9)):GOTO1200
1115 PRINT"{pink}{reverse on}Unable to connect to ";H1$;"{reverse off}{light blue}":GOTO300
1120 IT=TI+40
1130 P9=0:GOSUB800:IFP$<>""THENIT=TI+10
1140 IFTI<ITTHEN1130
1200 PRINT"{reverse on}{light green}Connected to "+HO$+"{reverse off}{light blue}"
1201 IFXB<>9600THEN1205
1202 SYSUM:SYSUM+3:IFPEEK(789)=234THENSYSUM+9:GOTO1210
1203 BA=XB:POKEUM+19,1
1205 IFXB<>2400THEN1210
1206 NP=0:IFPEEK(2614)>0THENNP=20
1207 BA=XB:POKE2576,10:POKE2578,PEEK(59490+NP):POKE2579,PEEK(59491+NP)
1208 POKE2582,170:POKE2583,1:IFNP>0THENPOKE2582,154
1210 PRINT"{reverse on}{light green}Sending request...{reverse off}{light blue}":PRINT#5,"ati3":TT=TI+12
1212 IFTI<TTTHENSYSML+12:GOTO1212
1215 P$="GET "+P1$+" HTTP/1.1":GOSUB600
1220 P$="Host: "+HO$:GOSUB600
1225 P$="Connection: Close":GOSUB600
1230 P$="User-Agent: C=WGET":GOSUB600
1240 P$="Accept: */*":GOSUB600
1300 FORI=0TO20
1310 IFHH$(I)=""THEN1330
1320 P$=HH$(I):GOSUB900
1330 NEXTI
1950 P$=CHR$(13)+CHR$(10):GOSUB650
1970 PRINT"{reverse on}{light green}Request sent. Reading response...{reverse off}{light blue}"
2000 P9=0:GOSUB800:IFP$=""THEN2000
2010 LE=0:FB=0
2020 IFLEN(P$)<13THENPRINT"{reverse on}{pink}Bad response: {reverse off}{light blue}";P$:STOP
2030 IFLEFT$(P$,5)<>"http/"THENPRINT"{reverse on}{red}Bad response{reverse off}{light blue}";P$:STOP
2040 RC=VAL(MID$(P$,10,3))
2050 IFRC<>200THENPRINT"{reverse on}{red}Bad response code:{reverse off}{light blue}";RC:STOP
2100 GOSUB800:IFP$=""ANDE=0THEN2200
2120 IFLEN(P$)<17ORLEFT$(P$,1)<>"c"ORMID$(P$,9,1)<>"l"THEN2100
2130 IFMID$(P$,15,1)<>":"THEN2100
2140 I=15
2160 I=I+1:IFMID$(P$,I,1)=" "THEN2160
2170 X=VAL(MID$(P$,I)):IFX>0THENCL=X
2180 GOTO2100
2200 TL=0:PRINT#5,CR$;"at&m&dc";MID$(STR$(P),2);CR$;
2210 GOSUB900:IFP$<>"ok"THENPRINT"Zimodem command failed: ";P$:STOP
2240 IFCL=0THENPRINT"{reverse on}{pink}Headers complete. No content. Done.{reverse off}{light blue}":END
2250 PRINT"{reverse on}{light green}Headers complete."
2260 PRINT"{reverse on}Receiving"+STR$(CL)+" bytes{reverse off}{light blue}"
2270 OPEN1,UN,15:OPEN8,UN,8,OF$+",w"
2280 INPUT#1,E:IFE>0THENPRINT"{reverse on}{red}Unable to open "+OF$+": "+STR$(E)+"{reverse off}{light blue}":STOP
2290 REM
2300 GOSUB930:IFP0<>PTHEN2300
2310 IFP1=0ORP0=0THEN2300
2330 TL=TL+LEN(P$)
2340 IFLEN(P$)>0THENPRINT#8,P$;
2350 TP=INT(TL/CL*100.0)
2360 PRINT"               {left*15}"+STR$(TL)+" ("+STR$(TP)+"% )"
2370 PRINT"{up}";:IFTL<CLTHEN2300
2380 PRINT:PRINT"{reverse on}{light green}Done.{reverse off}{light blue}":CLOSE8:CLOSE1
2390 PRINT#5,"ath0":PRINT#5,"atz":TT=TI+100
2400 IFTI<TTTHEN2400
2410 CLOSE5:END
5000 P$=""
5005 PRINT"{reverse on} {reverse off}{left}";
5010 GETA$:IFA$=""THEN5010
5020 IFA$=CHR$(13)THENPRINT" {left}":RETURN
5030 IFA$<>CHR$(20)THENPRINTA$;"{reverse on} {reverse off}{left}";:P$=P$+A$:GOTO5010
5040 IFP$=""THEN5010
5050 P$=LEFT$(P$,LEN(P$)-1):PRINT" {left*2} {left}{reverse on} {reverse off}{left}";:GOTO5010
50000 OPEN5,2,0,CHR$(8)
50010 GET#5,A$:IFA$<>""THENPRINTA$;
50020 GETA$:IFA$<>""THENPRINT#5,A$;
50030 GOTO 50010
55555 F$="wget64-128":OPEN1,8,15,"s0:"+F$:CLOSE1:SAVE(F$),8:VERIFY(F$),8
