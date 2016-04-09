
;CodeVisionAVR C Compiler V2.05.3 Standard
;(C) Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega64
;Program type             : Application
;Clock frequency          : 8.000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 1024 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;Global 'const' stored in FLASH     : No
;Enhanced function parameter passing: Yes
;Enhanced core instructions         : On
;Smart register allocation          : On
;Automatic register allocation      : On

	#pragma AVRPART ADMIN PART_NAME ATmega64
	#pragma AVRPART MEMORY PROG_FLASH 65536
	#pragma AVRPART MEMORY EEPROM 2048
	#pragma AVRPART MEMORY INT_SRAM SIZE 4351
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x10FF
	.EQU __DSTACK_SIZE=0x0400
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _Itemp=R4

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _isrTIMER2_COMP_vect
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _isrADC_vect
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _isrTIMER3_COMPA_vect
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_ef5x7:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x5F
	.DB  0x0,0x0,0x0,0x7,0x0,0x7,0x0,0x14
	.DB  0x7F,0x14,0x7F,0x14,0x24,0x2A,0x7F,0x2A
	.DB  0x12,0x23,0x13,0x8,0x64,0x62,0x36,0x49
	.DB  0x55,0x22,0x50,0x0,0x5,0x3,0x0,0x0
	.DB  0x0,0x1C,0x22,0x41,0x0,0x0,0x41,0x22
	.DB  0x1C,0x0,0x8,0x2A,0x1C,0x2A,0x8,0x8
	.DB  0x8,0x3E,0x8,0x8,0x0,0x50,0x30,0x0
	.DB  0x0,0x8,0x8,0x8,0x8,0x8,0x0,0x30
	.DB  0x30,0x0,0x0,0x20,0x10,0x8,0x4,0x2
	.DB  0x3E,0x51,0x49,0x45,0x3E,0x0,0x42,0x7F
	.DB  0x40,0x0,0x42,0x61,0x51,0x49,0x46,0x21
	.DB  0x41,0x45,0x4B,0x31,0x18,0x14,0x12,0x7F
	.DB  0x10,0x27,0x45,0x45,0x45,0x39,0x3C,0x4A
	.DB  0x49,0x49,0x30,0x1,0x71,0x9,0x5,0x3
	.DB  0x36,0x49,0x49,0x49,0x36,0x6,0x49,0x49
	.DB  0x29,0x1E,0x0,0x36,0x36,0x0,0x0,0x0
	.DB  0x56,0x36,0x0,0x0,0x0,0x8,0x14,0x22
	.DB  0x41,0x14,0x14,0x14,0x14,0x14,0x41,0x22
	.DB  0x14,0x8,0x0,0x2,0x1,0x51,0x9,0x6
	.DB  0x32,0x49,0x79,0x41,0x3E,0x7E,0x11,0x11
	.DB  0x11,0x7E,0x7F,0x49,0x49,0x49,0x36,0x3E
	.DB  0x41,0x41,0x41,0x22,0x7F,0x41,0x41,0x22
	.DB  0x1C,0x7F,0x49,0x49,0x49,0x41,0x7F,0x9
	.DB  0x9,0x1,0x1,0x3E,0x41,0x41,0x51,0x32
	.DB  0x7F,0x8,0x8,0x8,0x7F,0x0,0x41,0x7F
	.DB  0x41,0x0,0x20,0x40,0x41,0x3F,0x1,0x7F
	.DB  0x8,0x14,0x22,0x41,0x7F,0x40,0x40,0x40
	.DB  0x40,0x7F,0x2,0x4,0x2,0x7F,0x7F,0x4
	.DB  0x8,0x10,0x7F,0x3E,0x41,0x41,0x41,0x3E
	.DB  0x7F,0x9,0x9,0x9,0x6,0x3E,0x41,0x51
	.DB  0x21,0x5E,0x7F,0x9,0x19,0x29,0x46,0x46
	.DB  0x49,0x49,0x49,0x31,0x1,0x1,0x7F,0x1
	.DB  0x1,0x3F,0x40,0x40,0x40,0x3F,0x1F,0x20
	.DB  0x40,0x20,0x1F,0x7F,0x20,0x18,0x20,0x7F
	.DB  0x63,0x14,0x8,0x14,0x63,0x3,0x4,0x78
	.DB  0x4,0x3,0x61,0x51,0x49,0x45,0x43,0x0
	.DB  0x0,0x7F,0x41,0x41,0x2,0x4,0x8,0x10
	.DB  0x20,0x41,0x41,0x7F,0x0,0x0,0x4,0x2
	.DB  0x1,0x2,0x4,0x40,0x40,0x40,0x40,0x40
	.DB  0x0,0x1,0x2,0x4,0x0,0x20,0x54,0x54
	.DB  0x54,0x78,0x7F,0x48,0x44,0x44,0x38,0x38
	.DB  0x44,0x44,0x44,0x20,0x38,0x44,0x44,0x48
	.DB  0x7F,0x38,0x54,0x54,0x54,0x18,0x8,0x7E
	.DB  0x9,0x1,0x2,0x8,0x14,0x54,0x54,0x3C
	.DB  0x7F,0x8,0x4,0x4,0x78,0x0,0x44,0x7D
	.DB  0x40,0x0,0x20,0x40,0x44,0x3D,0x0,0x0
	.DB  0x7F,0x10,0x28,0x44,0x0,0x41,0x7F,0x40
	.DB  0x0,0x7C,0x4,0x18,0x4,0x78,0x7C,0x8
	.DB  0x4,0x4,0x78,0x38,0x44,0x44,0x44,0x38
	.DB  0x7C,0x14,0x14,0x14,0x8,0x8,0x14,0x14
	.DB  0x18,0x7C,0x7C,0x8,0x4,0x4,0x8,0x48
	.DB  0x54,0x54,0x54,0x20,0x4,0x3F,0x44,0x40
	.DB  0x20,0x3C,0x40,0x40,0x20,0x7C,0x1C,0x20
	.DB  0x40,0x20,0x1C,0x3C,0x40,0x30,0x40,0x3C
	.DB  0x44,0x28,0x10,0x28,0x44,0xC,0x50,0x50
	.DB  0x50,0x3C,0x44,0x64,0x54,0x4C,0x44,0x0
	.DB  0x8,0x36,0x41,0x0,0x0,0x0,0x7F,0x0
	.DB  0x0,0x0,0x41,0x36,0x8,0x0,0x8,0x8
	.DB  0x2A,0x1C,0x8,0x8,0x1C,0x2A,0x8,0x8
_sine:
	.DB  0x80,0x83,0x86,0x89,0x8C,0x8F,0x92,0x95
	.DB  0x98,0x9C,0x9F,0xA2,0xA5,0xA8,0xAB,0xAE
	.DB  0xB0,0xB3,0xB6,0xB9,0xBC,0xBF,0xC1,0xC4
	.DB  0xC7,0xC9,0xCC,0xCE,0xD1,0xD3,0xD5,0xD8
	.DB  0xDA,0xDC,0xDE,0xE0,0xE2,0xE4,0xE6,0xE8
	.DB  0xEA,0xEC,0xED,0xEF,0xF0,0xF2,0xF3,0xF5
	.DB  0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFC
	.DB  0xFD,0xFE,0xFE,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFE,0xFE
	.DB  0xFD,0xFC,0xFC,0xFB,0xFA,0xF9,0xF8,0xF7
	.DB  0xF6,0xF5,0xF3,0xF2,0xF0,0xEF,0xED,0xEC
	.DB  0xEA,0xE8,0xE6,0xE4,0xE2,0xE0,0xDE,0xDC
	.DB  0xDA,0xD8,0xD5,0xD3,0xD1,0xCE,0xCC,0xC9
	.DB  0xC7,0xC4,0xC1,0xBF,0xBC,0xB9,0xB6,0xB3
	.DB  0xB0,0xAE,0xAB,0xA8,0xA5,0xA2,0x9F,0x9C
	.DB  0x98,0x95,0x92,0x8F,0x8C,0x89,0x86,0x83
	.DB  0x80,0x7C,0x79,0x76,0x73,0x70,0x6D,0x6A
	.DB  0x67,0x63,0x60,0x5D,0x5A,0x57,0x54,0x51
	.DB  0x4F,0x4C,0x49,0x46,0x43,0x40,0x3E,0x3B
	.DB  0x38,0x36,0x33,0x31,0x2E,0x2C,0x2A,0x27
	.DB  0x25,0x23,0x21,0x1F,0x1D,0x1B,0x19,0x17
	.DB  0x15,0x13,0x12,0x10,0xF,0xD,0xC,0xA
	.DB  0x9,0x8,0x7,0x6,0x5,0x4,0x3,0x3
	.DB  0x2,0x1,0x1,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x1,0x1
	.DB  0x2,0x3,0x3,0x4,0x5,0x6,0x7,0x8
	.DB  0x9,0xA,0xC,0xD,0xF,0x10,0x12,0x13
	.DB  0x15,0x17,0x19,0x1B,0x1D,0x1F,0x21,0x23
	.DB  0x25,0x27,0x2A,0x2C,0x2E,0x31,0x33,0x36
	.DB  0x38,0x3B,0x3E,0x40,0x43,0x46,0x49,0x4C
	.DB  0x4F,0x51,0x54,0x57,0x5A,0x5D,0x60,0x63
	.DB  0x67,0x6A,0x6D,0x70,0x73,0x76,0x79,0x7C
_Timer_Value:
	.DB  0x0,0x0,0x24,0xF4,0x73,0xCB,0x63,0xAE
	.DB  0x97,0x98,0xA2,0x87,0x12,0x7A,0xF9,0x6E
	.DB  0xBA,0x65,0xE6,0x5D,0x31,0x57,0x61,0x51
	.DB  0x4B,0x4C,0xCE,0x47,0xD1,0x43,0x3F,0x40
	.DB  0x9,0x3D,0x21,0x3A,0x7D,0x37,0x13,0x35
	.DB  0xDD,0x32,0xD4,0x30,0xF3,0x2E,0x36,0x2D
	.DB  0x99,0x2B,0x18,0x2A,0xB1,0x28,0x61,0x27
	.DB  0x26,0x26,0xFE,0x24,0xE7,0x23,0xE1,0x22
	.DB  0xE9,0x21,0xFE,0x20,0x20,0x20,0x4D,0x1F
	.DB  0x85,0x1E,0xC6,0x1D,0x10,0x1D,0x63,0x1C
	.DB  0xBE,0x1B,0x20,0x1B,0x89,0x1A,0xF9,0x19
	.DB  0x6E,0x19,0xEA,0x18,0x6A,0x18,0xEF,0x17
	.DB  0x7A,0x17,0x8,0x17,0x9B,0x16,0x32,0x16
	.DB  0xCC,0x15,0x6A,0x15,0xC,0x15,0xB1,0x14
	.DB  0x58,0x14,0x3,0x14,0xB0,0x13,0x60,0x13
	.DB  0x13,0x13,0xC8,0x12,0x7F,0x12,0x38,0x12
	.DB  0xF4,0x11,0xB1,0x11,0x70,0x11,0x31,0x11
	.DB  0xF4,0x10,0xB9,0x10,0x7F,0x10,0x47,0x10
	.DB  0x10,0x10,0xDA,0xF,0xA6,0xF,0x74,0xF
	.DB  0x42,0xF,0x12,0xF,0xE3,0xE,0xB5,0xE
	.DB  0x88,0xE,0x5C,0xE,0x32,0xE,0x8,0xE
	.DB  0xDF,0xD,0xB7,0xD,0x90,0xD,0x6A,0xD
	.DB  0x45,0xD,0x20,0xD,0xFC,0xC,0xD9,0xC
	.DB  0xB7,0xC,0x96,0xC,0x75,0xC,0x55,0xC
	.DB  0x35,0xC,0x16,0xC,0xF8,0xB,0xDA,0xB
	.DB  0xBD,0xB,0xA0,0xB,0x84,0xB,0x69,0xB
	.DB  0x4E,0xB,0x33,0xB,0x19,0xB,0xFF,0xA
	.DB  0xE6,0xA,0xCD,0xA,0xB5,0xA,0x9D,0xA
	.DB  0x86,0xA,0x6F,0xA,0x58,0xA,0x42,0xA
	.DB  0x2C,0xA,0x17,0xA,0x1,0xA,0xED,0x9
	.DB  0xD8,0x9,0xC4,0x9,0xB0,0x9,0x9D,0x9
	.DB  0x89,0x9,0x76,0x9,0x64,0x9,0x51,0x9
	.DB  0x3F,0x9,0x2E,0x9,0x1C,0x9,0xB,0x9
	.DB  0xFA,0x8,0xE9,0x8,0xD8,0x8,0xC8,0x8
	.DB  0xB8,0x8,0xA8,0x8,0x99,0x8,0x89,0x8
	.DB  0x7A,0x8,0x6B,0x8,0x5C,0x8,0x4E,0x8
	.DB  0x3F,0x8,0x31,0x8,0x23,0x8,0x16,0x8
	.DB  0x8,0x8,0xFA,0x7,0xED,0x7,0xE0,0x7
	.DB  0xD3,0x7,0xC6,0x7,0xBA,0x7,0xAD,0x7
	.DB  0xA1,0x7,0x95,0x7,0x89,0x7,0x7D,0x7
	.DB  0x71,0x7,0x66,0x7,0x5B,0x7,0x4F,0x7
	.DB  0x44,0x7,0x39,0x7,0x2E,0x7,0x23,0x7
	.DB  0x19,0x7,0xE,0x7,0x4,0x7,0xFA,0x6
	.DB  0xF0,0x6,0xE6,0x6,0xDC,0x6,0xD2,0x6
	.DB  0xC8,0x6,0xBF,0x6,0xB5,0x6,0xAC,0x6
	.DB  0xA2,0x6,0x99,0x6,0x90,0x6,0x87,0x6
	.DB  0x7E,0x6,0x75,0x6,0x6D,0x6,0x64,0x6
	.DB  0x5C,0x6,0x53,0x6,0x4B,0x6,0x43,0x6
	.DB  0x3A,0x6,0x32,0x6,0x2A,0x6,0x22,0x6
	.DB  0x35,0xC,0x25,0xC,0x16,0xC,0x7,0xC
	.DB  0xF8,0xB,0xE9,0xB,0xDA,0xB,0xCB,0xB
	.DB  0xBD,0xB,0xAE,0xB,0xA0,0xB,0x92,0xB
	.DB  0x84,0xB,0x76,0xB,0x69,0xB,0x5B,0xB
	.DB  0x4E,0xB,0x40,0xB,0x33,0xB,0x26,0xB
	.DB  0x19,0xB,0xC,0xB,0xFF,0xA,0xF3,0xA
	.DB  0xE6,0xA,0xDA,0xA,0xCD,0xA,0xC1,0xA
	.DB  0xB5,0xA,0xA9,0xA,0x9D,0xA,0x92,0xA
	.DB  0x86,0xA,0x7A,0xA,0x6F,0xA,0x64,0xA
	.DB  0x58,0xA,0x4D,0xA,0x42,0xA,0x37,0xA
	.DB  0x2C,0xA,0x21,0xA,0x17,0xA,0xC,0xA
	.DB  0x1,0xA,0xF7,0x9,0xED,0x9,0xE2,0x9
	.DB  0xD8,0x9,0xCE,0x9,0xC4,0x9,0xBA,0x9
	.DB  0xB0,0x9,0xA6,0x9,0x9D,0x9,0x93,0x9
	.DB  0x89,0x9,0x80,0x9,0x76,0x9,0x6D,0x9
	.DB  0x64,0x9,0x5B,0x9,0x51,0x9,0x48,0x9
	.DB  0x3F,0x9,0x36,0x9,0x2E,0x9,0x25,0x9
	.DB  0x1C,0x9,0x13,0x9,0xB,0x9,0x2,0x9
	.DB  0xFA,0x8,0xF1,0x8,0xE9,0x8,0xE1,0x8
	.DB  0xD8,0x8,0xD0,0x8,0xC8,0x8,0xC0,0x8
	.DB  0xB8,0x8,0xB0,0x8,0xA8,0x8,0xA0,0x8
	.DB  0x99,0x8,0x91,0x8,0x89,0x8,0x82,0x8
	.DB  0x7A,0x8,0x73,0x8,0x6B,0x8,0x64,0x8
	.DB  0x5C,0x8,0x55,0x8,0x4E,0x8,0x47,0x8
	.DB  0x3F,0x8,0x38,0x8,0x31,0x8,0x2A,0x8
	.DB  0x23,0x8,0x1C,0x8,0x16,0x8,0xF,0x8
	.DB  0x8,0x8,0x1,0x8,0xFA,0x7,0xF4,0x7
	.DB  0xED,0x7,0xE7,0x7,0xE0,0x7,0xDA,0x7
	.DB  0xD3,0x7,0xCD,0x7,0xC6,0x7,0xC0,0x7
	.DB  0xBA,0x7,0xB4,0x7,0xAD,0x7,0xA7,0x7
	.DB  0xA1,0x7,0x9B,0x7,0x95,0x7,0x8F,0x7
	.DB  0x89,0x7,0x83,0x7,0x7D,0x7,0x77,0x7
	.DB  0x71,0x7,0x6C,0x7,0x66,0x7,0x60,0x7
	.DB  0x5B,0x7,0x55,0x7,0x4F,0x7,0x4A,0x7
	.DB  0x44,0x7,0x3F,0x7,0x39,0x7,0x34,0x7
	.DB  0x2E,0x7,0x29,0x7,0x23,0x7,0x1E,0x7
	.DB  0x19,0x7,0x14,0x7,0xE,0x7,0x9,0x7
	.DB  0x4,0x7,0xFF,0x6,0xFA,0x6,0xF5,0x6
	.DB  0xF0,0x6,0xEB,0x6,0xE6,0x6,0xE1,0x6
	.DB  0xDC,0x6,0xD7,0x6,0xD2,0x6,0xCD,0x6
	.DB  0xC8,0x6,0xC3,0x6,0xBF,0x6,0xBA,0x6
	.DB  0xB5,0x6,0xB0,0x6,0xAC,0x6,0xA7,0x6
	.DB  0xA2,0x6,0x9E,0x6,0x99,0x6,0x95,0x6
	.DB  0x90,0x6,0x8C,0x6,0x87,0x6,0x83,0x6
	.DB  0x7E,0x6,0x7A,0x6,0x75,0x6,0x71,0x6
	.DB  0x6D,0x6,0x68,0x6,0x64,0x6,0x60,0x6
	.DB  0x5C,0x6,0x57,0x6,0x53,0x6,0x4F,0x6
	.DB  0x4B,0x6,0x47,0x6,0x43,0x6,0x3E,0x6
	.DB  0x3A,0x6,0x36,0x6,0x32,0x6,0x2E,0x6
	.DB  0x2A,0x6,0x26,0x6,0x22,0x6,0x1E,0x6
	.DB  0x35,0xC,0x2D,0xC,0x25,0xC,0x1E,0xC
	.DB  0x16,0xC,0xE,0xC,0x7,0xC,0xFF,0xB
	.DB  0xF8,0xB,0xF0,0xB,0xE9,0xB,0xE1,0xB
	.DB  0xDA,0xB,0xD3,0xB,0xCB,0xB,0xC4,0xB
	.DB  0xBD,0xB,0xB6,0xB,0xAE,0xB,0xA7,0xB
	.DB  0xA0,0xB,0x99,0xB,0x92,0xB,0x8B,0xB
	.DB  0x84,0xB,0x7D,0xB,0x76,0xB,0x6F,0xB
	.DB  0x69,0xB,0x62,0xB,0x5B,0xB,0x54,0xB
	.DB  0x4E,0xB,0x47,0xB,0x40,0xB,0x3A,0xB
	.DB  0x33,0xB,0x2C,0xB,0x26,0xB,0x1F,0xB
	.DB  0x19,0xB,0x12,0xB,0xC,0xB,0x6,0xB
	.DB  0xFF,0xA,0xF9,0xA,0xF3,0xA,0xEC,0xA
	.DB  0xE6,0xA,0xE0,0xA,0xDA,0xA,0xD4,0xA
	.DB  0xCD,0xA,0xC7,0xA,0xC1,0xA,0xBB,0xA
	.DB  0xB5,0xA,0xAF,0xA,0xA9,0xA,0xA3,0xA
	.DB  0x9D,0xA,0x97,0xA,0x92,0xA,0x8C,0xA
	.DB  0x86,0xA,0x80,0xA,0x7A,0xA,0x75,0xA
	.DB  0x6F,0xA,0x69,0xA,0x64,0xA,0x5E,0xA
	.DB  0x58,0xA,0x53,0xA,0x4D,0xA,0x48,0xA
	.DB  0x42,0xA,0x3D,0xA,0x37,0xA,0x32,0xA
	.DB  0x2C,0xA,0x27,0xA,0x21,0xA,0x1C,0xA
	.DB  0x17,0xA,0x11,0xA,0xC,0xA,0x7,0xA
	.DB  0x1,0xA,0xFC,0x9,0xF7,0x9,0xF2,0x9
	.DB  0xED,0x9,0xE7,0x9,0xE2,0x9,0xDD,0x9
	.DB  0xD8,0x9,0xD3,0x9,0xCE,0x9,0xC9,0x9
	.DB  0xC4,0x9,0xBF,0x9,0xBA,0x9,0xB5,0x9
	.DB  0xB0,0x9,0xAB,0x9,0xA6,0x9,0xA1,0x9
	.DB  0x9D,0x9,0x98,0x9,0x93,0x9,0x8E,0x9
	.DB  0x89,0x9,0x85,0x9,0x80,0x9,0x7B,0x9
	.DB  0x76,0x9,0x72,0x9,0x6D,0x9,0x68,0x9
	.DB  0x64,0x9,0x5F,0x9,0x5B,0x9,0x56,0x9
	.DB  0x51,0x9,0x4D,0x9,0x48,0x9,0x44,0x9
	.DB  0x3F,0x9,0x3B,0x9,0x36,0x9,0x32,0x9
	.DB  0x2E,0x9,0x29,0x9,0x25,0x9,0x20,0x9
	.DB  0x1C,0x9,0x18,0x9,0x13,0x9,0xF,0x9
	.DB  0xB,0x9,0x7,0x9,0x2,0x9,0xFE,0x8
	.DB  0xFA,0x8,0xF6,0x8,0xF1,0x8,0xED,0x8
	.DB  0xE9,0x8,0xE5,0x8,0xE1,0x8,0xDD,0x8
	.DB  0xD8,0x8,0xD4,0x8,0xD0,0x8,0xCC,0x8
	.DB  0xC8,0x8,0xC4,0x8,0xC0,0x8,0xBC,0x8
	.DB  0xB8,0x8,0xB4,0x8,0xB0,0x8,0xAC,0x8
	.DB  0xA8,0x8,0xA4,0x8,0xA0,0x8,0x9D,0x8
	.DB  0x99,0x8,0x95,0x8,0x91,0x8,0x8D,0x8
	.DB  0x89,0x8,0x86,0x8,0x82,0x8,0x7E,0x8
	.DB  0x7A,0x8,0x76,0x8,0x73,0x8,0x6F,0x8
	.DB  0x6B,0x8,0x67,0x8,0x64,0x8,0x60,0x8
	.DB  0x5C,0x8,0x59,0x8,0x55,0x8,0x51,0x8
	.DB  0x4E,0x8,0x4A,0x8,0x47,0x8,0x43,0x8
	.DB  0x3F,0x8,0x3C,0x8,0x38,0x8,0x35,0x8
	.DB  0x31,0x8,0x2E,0x8,0x2A,0x8,0x27,0x8
	.DB  0x47,0x10,0x40,0x10,0x39,0x10,0x32,0x10
	.DB  0x2B,0x10,0x24,0x10,0x1D,0x10,0x17,0x10
	.DB  0x10,0x10,0x9,0x10,0x2,0x10,0xFC,0xF
	.DB  0xF5,0xF,0xEE,0xF,0xE8,0xF,0xE1,0xF
	.DB  0xDA,0xF,0xD4,0xF,0xCD,0xF,0xC7,0xF
	.DB  0xC0,0xF,0xBA,0xF,0xB3,0xF,0xAD,0xF
	.DB  0xA6,0xF,0xA0,0xF,0x9A,0xF,0x93,0xF
	.DB  0x8D,0xF,0x87,0xF,0x80,0xF,0x7A,0xF
	.DB  0x74,0xF,0x6D,0xF,0x67,0xF,0x61,0xF
	.DB  0x5B,0xF,0x55,0xF,0x4E,0xF,0x48,0xF
	.DB  0x42,0xF,0x3C,0xF,0x36,0xF,0x30,0xF
	.DB  0x2A,0xF,0x24,0xF,0x1E,0xF,0x18,0xF
	.DB  0x12,0xF,0xC,0xF,0x6,0xF,0x0,0xF
	.DB  0xFA,0xE,0xF4,0xE,0xEF,0xE,0xE9,0xE
	.DB  0xE3,0xE,0xDD,0xE,0xD7,0xE,0xD2,0xE
	.DB  0xCC,0xE,0xC6,0xE,0xC0,0xE,0xBB,0xE
	.DB  0xB5,0xE,0xAF,0xE,0xAA,0xE,0xA4,0xE
	.DB  0x9F,0xE,0x99,0xE,0x93,0xE,0x8E,0xE
	.DB  0x88,0xE,0x83,0xE,0x7D,0xE,0x78,0xE
	.DB  0x72,0xE,0x6D,0xE,0x67,0xE,0x62,0xE
	.DB  0x5C,0xE,0x57,0xE,0x52,0xE,0x4C,0xE
	.DB  0x47,0xE,0x42,0xE,0x3C,0xE,0x37,0xE
	.DB  0x32,0xE,0x2C,0xE,0x27,0xE,0x22,0xE
	.DB  0x1D,0xE,0x18,0xE,0x12,0xE,0xD,0xE
	.DB  0x8,0xE,0x3,0xE,0xFE,0xD,0xF9,0xD
	.DB  0xF3,0xD,0xEE,0xD,0xE9,0xD,0xE4,0xD
	.DB  0xDF,0xD,0xDA,0xD,0xD5,0xD,0xD0,0xD
	.DB  0xCB,0xD,0xC6,0xD,0xC1,0xD,0xBC,0xD
	.DB  0xB7,0xD,0xB2,0xD,0xAD,0xD,0xA9,0xD
	.DB  0xA4,0xD,0x9F,0xD,0x9A,0xD,0x95,0xD
	.DB  0x90,0xD,0x8B,0xD,0x87,0xD,0x82,0xD
	.DB  0x7D,0xD,0x78,0xD,0x74,0xD,0x6F,0xD
	.DB  0x6A,0xD,0x65,0xD,0x61,0xD,0x5C,0xD
	.DB  0x57,0xD,0x53,0xD,0x4E,0xD,0x49,0xD
	.DB  0x45,0xD,0x40,0xD,0x3C,0xD,0x37,0xD
	.DB  0x32,0xD,0x2E,0xD,0x29,0xD,0x25,0xD
	.DB  0x20,0xD,0x1C,0xD,0x17,0xD,0x13,0xD
	.DB  0xE,0xD,0xA,0xD,0x5,0xD,0x1,0xD
	.DB  0xFC,0xC,0xF8,0xC,0xF4,0xC,0xEF,0xC
	.DB  0xEB,0xC,0xE7,0xC,0xE2,0xC,0xDE,0xC
	.DB  0xD9,0xC,0xD5,0xC,0xD1,0xC,0xCD,0xC
	.DB  0xC8,0xC,0xC4,0xC,0xC0,0xC,0xBB,0xC
	.DB  0xB7,0xC,0xB3,0xC,0xAF,0xC,0xAB,0xC
	.DB  0xA6,0xC,0xA2,0xC,0x9E,0xC,0x9A,0xC
	.DB  0x96,0xC,0x92,0xC,0x8D,0xC,0x89,0xC
	.DB  0x85,0xC,0x81,0xC,0x7D,0xC,0x79,0xC
	.DB  0x75,0xC,0x71,0xC,0x6D,0xC,0x69,0xC
	.DB  0x65,0xC,0x61,0xC,0x5D,0xC,0x59,0xC
	.DB  0x55,0xC,0x51,0xC,0x4D,0xC,0x49,0xC
	.DB  0x45,0xC,0x41,0xC,0x3D,0xC,0x39,0xC
	.DB  0x6A,0x18,0x62,0x18,0x5A,0x18,0x53,0x18
	.DB  0x4B,0x18,0x43,0x18,0x3B,0x18,0x34,0x18
	.DB  0x2C,0x18,0x24,0x18,0x1D,0x18,0x15,0x18
	.DB  0xE,0x18,0x6,0x18,0xFF,0x17,0xF7,0x17
	.DB  0xEF,0x17,0xE8,0x17,0xE0,0x17,0xD9,0x17
	.DB  0xD2,0x17,0xCA,0x17,0xC3,0x17,0xBB,0x17
	.DB  0xB4,0x17,0xAD,0x17,0xA5,0x17,0x9E,0x17
	.DB  0x97,0x17,0x8F,0x17,0x88,0x17,0x81,0x17
	.DB  0x7A,0x17,0x72,0x17,0x6B,0x17,0x64,0x17
	.DB  0x5D,0x17,0x56,0x17,0x4F,0x17,0x47,0x17
	.DB  0x40,0x17,0x39,0x17,0x32,0x17,0x2B,0x17
	.DB  0x24,0x17,0x1D,0x17,0x16,0x17,0xF,0x17
	.DB  0x8,0x17,0x1,0x17,0xFA,0x16,0xF3,0x16
	.DB  0xED,0x16,0xE6,0x16,0xDF,0x16,0xD8,0x16
	.DB  0xD1,0x16,0xCA,0x16,0xC4,0x16,0xBD,0x16
	.DB  0xB6,0x16,0xAF,0x16,0xA8,0x16,0xA2,0x16
	.DB  0x9B,0x16,0x94,0x16,0x8E,0x16,0x87,0x16
	.DB  0x80,0x16,0x7A,0x16,0x73,0x16,0x6D,0x16
	.DB  0x66,0x16,0x5F,0x16,0x59,0x16,0x52,0x16
	.DB  0x4C,0x16,0x45,0x16,0x3F,0x16,0x38,0x16
	.DB  0x32,0x16,0x2B,0x16,0x25,0x16,0x1F,0x16
	.DB  0x18,0x16,0x12,0x16,0xB,0x16,0x5,0x16
	.DB  0xFF,0x15,0xF8,0x15,0xF2,0x15,0xEC,0x15
	.DB  0xE5,0x15,0xDF,0x15,0xD9,0x15,0xD3,0x15
	.DB  0xCC,0x15,0xC6,0x15,0xC0,0x15,0xBA,0x15
	.DB  0xB4,0x15,0xAD,0x15,0xA7,0x15,0xA1,0x15
	.DB  0x9B,0x15,0x95,0x15,0x8F,0x15,0x89,0x15
	.DB  0x83,0x15,0x7D,0x15,0x77,0x15,0x70,0x15
	.DB  0x6A,0x15,0x64,0x15,0x5E,0x15,0x58,0x15
	.DB  0x53,0x15,0x4D,0x15,0x47,0x15,0x41,0x15
	.DB  0x3B,0x15,0x35,0x15,0x2F,0x15,0x29,0x15
	.DB  0x23,0x15,0x1D,0x15,0x18,0x15,0x12,0x15
	.DB  0xC,0x15,0x6,0x15,0x0,0x15,0xFB,0x14
	.DB  0xF5,0x14,0xEF,0x14,0xE9,0x14,0xE4,0x14
	.DB  0xDE,0x14,0xD8,0x14,0xD2,0x14,0xCD,0x14
	.DB  0xC7,0x14,0xC1,0x14,0xBC,0x14,0xB6,0x14
	.DB  0xB1,0x14,0xAB,0x14,0xA5,0x14,0xA0,0x14
	.DB  0x9A,0x14,0x95,0x14,0x8F,0x14,0x8A,0x14
	.DB  0x84,0x14,0x7F,0x14,0x79,0x14,0x74,0x14
	.DB  0x6E,0x14,0x69,0x14,0x63,0x14,0x5E,0x14
	.DB  0x58,0x14,0x53,0x14,0x4E,0x14,0x48,0x14
	.DB  0x43,0x14,0x3D,0x14,0x38,0x14,0x33,0x14
	.DB  0x2D,0x14,0x28,0x14,0x23,0x14,0x1D,0x14
	.DB  0x18,0x14,0x13,0x14,0xD,0x14,0x8,0x14
	.DB  0x3,0x14,0xFE,0x13,0xF8,0x13,0xF3,0x13
	.DB  0xEE,0x13,0xE9,0x13,0xE4,0x13,0xDE,0x13
	.DB  0xD9,0x13,0xD4,0x13,0xCF,0x13,0xCA,0x13
	.DB  0xC5,0x13,0xC0,0x13,0xBB,0x13,0xB5,0x13
	.DB  0xB0,0x13,0xAB,0x13,0xA6,0x13,0xA1,0x13
	.DB  0x9C,0x13,0x97,0x13,0x92,0x13,0x8D,0x13
	.DB  0x88,0x13
_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0xB:
	.DB  LOW(_0xA),HIGH(_0xA),LOW(_0xA+15),HIGH(_0xA+15),LOW(_0xA+20),HIGH(_0xA+20),LOW(_0xA+35),HIGH(_0xA+35)
	.DB  LOW(_0xA+46),HIGH(_0xA+46)
_0x17:
	.DB  0x0,0x0
_0x0:
	.DB  0x20,0x20,0x53,0x50,0x57,0x4D,0x20,0x74
	.DB  0x65,0x73,0x74,0x21,0x21,0x21,0x0,0x62
	.DB  0x79,0x20,0x3A,0x0,0x53,0x68,0x2E,0x20
	.DB  0x4E,0x6F,0x75,0x72,0x62,0x61,0x6B,0x68
	.DB  0x73,0x68,0x0,0x43,0x6F,0x70,0x79,0x72
	.DB  0x69,0x67,0x68,0x74,0x3A,0x0,0x20,0x20
	.DB  0x20,0x20,0x4F,0x5A,0x48,0x41,0x4E,0x20
	.DB  0x4B,0x44,0x0,0x46,0x52,0x51,0x3A,0x20
	.DB  0x25,0x30,0x33,0x64,0x2E,0x25,0x30,0x31
	.DB  0x64,0x20,0x48,0x7A,0x20,0x0,0x41,0x43
	.DB  0x43,0x3A,0x20,0x25,0x30,0x33,0x64,0x20
	.DB  0x73,0x65,0x63,0x20,0x0,0x44,0x45,0x43
	.DB  0x3A,0x20,0x25,0x30,0x33,0x64,0x20,0x73
	.DB  0x65,0x63,0x20,0x0
_0x80003:
	.DB  0x1
_0x80004:
	.DB  0x1
_0x2000060:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x0F
	.DW  _0xA
	.DW  _0x0*2

	.DW  0x05
	.DW  _0xA+15
	.DW  _0x0*2+15

	.DW  0x0F
	.DW  _0xA+20
	.DW  _0x0*2+20

	.DW  0x0B
	.DW  _0xA+35
	.DW  _0x0*2+35

	.DW  0x0D
	.DW  _0xA+46
	.DW  _0x0*2+46

	.DW  0x0A
	.DW  _SPchar_S0000004000
	.DW  _0xB*2

	.DW  0x02
	.DW  0x04
	.DW  _0x17*2

	.DW  0x01
	.DW  _Acceleration
	.DW  _0x80003*2

	.DW  0x01
	.DW  _Deceleration
	.DW  _0x80004*2

	.DW  0x01
	.DW  __seed_G100
	.DW  _0x2000060*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500

	.CSEG
;//-----------------------------------------------------------------------------
;// Copyright:      www.KnowledgePlus.ir
;// Author:         OZHAN KD ported by Sh. Nourbakhsh Rad
;// Remarks:
;// known Problems: none
;// Version:        1.1.0
;// Description:    SPWM test...
;//-----------------------------------------------------------------------------
;
;//	Include Headers
;//*****************************************************************************
;#include "app_config.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include "HW_SPWM.h"

	.CSEG
_HW_init:
	SBI  0x14,7
	CBI  0x15,7
	SBI  0x14,5
	CBI  0x15,5
	SBI  0x14,6
	CBI  0x15,6
	RET
_BUZZER:
	ST   -Y,R26
	ST   -Y,R17
;	times -> Y+1
;	i -> R17
	LDI  R17,LOW(0)
_0x4:
	LDD  R30,Y+1
	CP   R17,R30
	BRSH _0x5
	SBI  0x15,7
	LDI  R26,LOW(60)
	CALL SUBOPT_0x0
	CBI  0x15,7
	LDI  R26,LOW(180)
	CALL SUBOPT_0x0
	SUBI R17,-1
	RJMP _0x4
_0x5:
	LDD  R17,Y+0
	JMP  _0x20A0003
;
;//--------------------------------------------------
;#include "N11\N1100.h"
;#include "sFONT\sFONT.h"
;
;//--------------------------------------------------
;#include "ADC\ADC.h"
;
;//--------------------------------------------------
;#include "SPWM\SPWM.h"
;
;
;//	Constants and Varables
;//*****************************************************************************
;
;//Temp Const.
;char 														Ctemp[24];
;int  														Itemp = 0;
;
;
;//	Functions Prototype
;//*****************************************************************************
;void Initial(void);
;void Splash(void);
;
;void test01(void);
;
;
;//	<<< main function >>>
;//*****************************************************************************
;void main(void)
; 0000 002D {
_main:
; 0000 002E 	Initial();
	RCALL _Initial
; 0000 002F 	test01();
	RCALL _test01
; 0000 0030 
; 0000 0031 	while(1);
_0x6:
	RJMP _0x6
; 0000 0032 } //main
_0x9:
	RJMP _0x9
;
;
;//---------------------------------------------------------//
;//---------------------------------------------------------//
;void Initial(void)
; 0000 0038 {
_Initial:
; 0000 0039 	cli();												//Interrupts disable
	cli
; 0000 003A 
; 0000 003B 	HW_init();
	RCALL _HW_init
; 0000 003C 	a2dInit();										//AVCC & DIV64
	CALL _a2dInit
; 0000 003D 
; 0000 003E 	_delay_ms(500);
	CALL SUBOPT_0x1
; 0000 003F 
; 0000 0040 	//----------------------
; 0000 0041 	N11_Init();
	RCALL _N11_Init
; 0000 0042 	N11_Contrast(10);
	LDI  R26,LOW(10)
	RCALL _N11_Contrast
; 0000 0043 	N11_Backlight(ON);
	LDI  R26,LOW(1)
	RCALL _N11_Backlight
; 0000 0044 
; 0000 0045 	//----------------------
; 0000 0046 	BUZZER(BOOT_sign);
	LDI  R26,LOW(2)
	RCALL _BUZZER
; 0000 0047 	_delay_ms(500);
	CALL SUBOPT_0x1
; 0000 0048 
; 0000 0049 	//----------------------
; 0000 004A 	//static FILE mystdout = FDEV_SETUP_STREAM(N11_PrintChar, NULL, _FDEV_SETUP_WRITE);
; 0000 004B   //stdout = &mystdout;
; 0000 004C 
; 0000 004D 	N11_CLS();
	RCALL _N11_CLS
; 0000 004E 
; 0000 004F 	//----------------------
; 0000 0050 	Splash();
	RCALL _Splash
; 0000 0051 	BUZZER(OK_sign);
	LDI  R26,LOW(1)
	RCALL _BUZZER
; 0000 0052 
; 0000 0053 	//------------
; 0000 0054 	sei();												//Interrupts enabel
	sei
; 0000 0055 }	//Initial
	RET
;
;void Splash(void)
; 0000 0058 {
_Splash:
; 0000 0059 	static char *SPchar[5] = {
; 0000 005A 			"  SPWM test!!!",
; 0000 005B 			"by :",
; 0000 005C 			"Sh. Nourbakhsh",
; 0000 005D 			"Copyright:",
; 0000 005E 			"    OZHAN KD"
; 0000 005F 			};

	.DSEG
_0xA:
	.BYTE 0x3B

	.CSEG
; 0000 0060 
; 0000 0061 	//-------------
; 0000 0062 	StringAt(0, 2, SPchar[0]);
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _N11_GotoXR
	LDS  R26,_SPchar_S0000004000
	LDS  R27,_SPchar_S0000004000+1
	CALL SUBOPT_0x2
; 0000 0063 	StringAt(2, 2, SPchar[1]);
	LDI  R26,LOW(2)
	RCALL _N11_GotoXR
	__GETW2MN _SPchar_S0000004000,2
	CALL SUBOPT_0x2
; 0000 0064 	StringAt(3, 2, SPchar[2]);
	LDI  R26,LOW(3)
	RCALL _N11_GotoXR
	__GETW2MN _SPchar_S0000004000,4
	CALL SUBOPT_0x2
; 0000 0065 	StringAt(5, 2, SPchar[3]);
	LDI  R26,LOW(5)
	RCALL _N11_GotoXR
	__GETW2MN _SPchar_S0000004000,6
	CALL SUBOPT_0x2
; 0000 0066 	StringAt(6, 2, SPchar[4]);
	LDI  R26,LOW(6)
	RCALL _N11_GotoXR
	__GETW2MN _SPchar_S0000004000,8
	CALL _N11_PrintString
; 0000 0067 
; 0000 0068 	//-------------
; 0000 0069 	_delay_ms(3000);
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	CALL _delay_ms
; 0000 006A 	N11_CLS();
	RCALL _N11_CLS
; 0000 006B }	//Splash
	RET
;
;
;//---------------------------------------------------------//
;//---------------------------------------------------------//
;void test01(void)
; 0000 0071 {
_test01:
; 0000 0072 	unsigned char				LVflag 	= 0;
; 0000 0073 	unsigned int				TCRtemp = 0;
; 0000 0074 	unsigned char				i 			= 0;
; 0000 0075 
; 0000 0076 	unsigned int				FRQtemp;
; 0000 0077 	unsigned char				ACCtemp;
; 0000 0078 	unsigned char				DECtemp;
; 0000 0079 
; 0000 007A 	SPWM_init();
	SBIW R28,2
	CALL __SAVELOCR6
;	LVflag -> R17
;	TCRtemp -> R18,R19
;	i -> R16
;	FRQtemp -> R20,R21
;	ACCtemp -> Y+7
;	DECtemp -> Y+6
	LDI  R17,0
	__GETWRN 18,19,0
	LDI  R16,0
	CALL _SPWM_init
; 0000 007B 
; 0000 007C 	ADC_CH_init(FRQ_ACH);
	LDS  R30,97
	ANDI R30,0xFE
	CALL SUBOPT_0x3
	ANDI R30,0xFE
	STS  98,R30
; 0000 007D 	ADC_CH_init(ACC_ACH);
	LDS  R30,97
	ANDI R30,0xFD
	CALL SUBOPT_0x3
	ANDI R30,0xFD
	STS  98,R30
; 0000 007E 	ADC_CH_init(DEC_ACH);
	LDS  R30,97
	ANDI R30,0xFB
	CALL SUBOPT_0x3
	ANDI R30,0xFB
	STS  98,R30
; 0000 007F 
; 0000 0080 	//----- main loop!
; 0000 0081 	while(1)
_0xC:
; 0000 0082 	{
; 0000 0083 		if(TCounter>=TCRtemp)									//100mS
	LDS  R26,_TCounter
	LDS  R27,_TCounter+1
	CP   R26,R18
	CPC  R27,R19
	BRSH PC+3
	JMP _0xF
; 0000 0084 		{
; 0000 0085 			TCRtemp = TCounter +100;						//1mS x100
	LDS  R30,_TCounter
	LDS  R31,_TCounter+1
	SUBI R30,LOW(-100)
	SBCI R31,HIGH(-100)
	MOVW R18,R30
; 0000 0086 
; 0000 0087 			FRQtemp = a2dConvert10bit(FRQ_ACH);
	LDI  R26,LOW(0)
	CALL _a2dConvert10bit
	MOVW R20,R30
; 0000 0088 			ACCtemp = a2dConvert8bit(ACC_ACH);
	LDI  R26,LOW(1)
	CALL _a2dConvert8bit
	STD  Y+7,R30
; 0000 0089 			DECtemp = a2dConvert8bit(DEC_ACH);
	LDI  R26,LOW(2)
	CALL _a2dConvert8bit
	STD  Y+6,R30
; 0000 008A 
; 0000 008B 			//-------------------------------
; 0000 008C 			FRQtemp = SetFrequency(FRQtemp);
	MOVW R26,R20
	CALL _SetFrequency
	MOVW R20,R30
; 0000 008D 			ACCtemp = SetAcceleration(ACCtemp);
	LDD  R26,Y+7
	CALL _SetAcceleration
	STD  Y+7,R30
; 0000 008E 			DECtemp = SetDeceleration(DECtemp);
	LDD  R26,Y+6
	CALL _SetDeceleration
	STD  Y+6,R30
; 0000 008F 
; 0000 0090 			//-------------------------------
; 0000 0091 			sprintf(Ctemp, "FRQ: %03d.%01d Hz ", (FRQtemp/10), (FRQtemp%10));
	CALL SUBOPT_0x4
	__POINTW1FN _0x0,59
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R20
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21U
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	MOVW R26,R20
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21U
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,8
	CALL _sprintf
	ADIW R28,12
; 0000 0092 			StringAt(1, 2, Ctemp);
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL SUBOPT_0x5
; 0000 0093 
; 0000 0094 			sprintf(Ctemp, "ACC: %03d sec ", ACCtemp);
	__POINTW1FN _0x0,78
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+11
	CALL SUBOPT_0x6
; 0000 0095 			StringAt(3, 2, Ctemp);
	LDI  R26,LOW(3)
	CALL SUBOPT_0x5
; 0000 0096 
; 0000 0097 			sprintf(Ctemp, "DEC: %03d sec ", DECtemp);
	__POINTW1FN _0x0,93
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	CALL SUBOPT_0x6
; 0000 0098 			StringAt(5, 2, Ctemp);
	LDI  R26,LOW(5)
	RCALL _N11_GotoXR
	LDI  R26,LOW(_Ctemp)
	LDI  R27,HIGH(_Ctemp)
	CALL _N11_PrintString
; 0000 0099 
; 0000 009A 			i++;
	SUBI R16,-1
; 0000 009B 			if(i==5)					{						LVflag = 1;		}
	CPI  R16,5
	BRNE _0x10
	LDI  R17,LOW(1)
; 0000 009C 			else if(i==10)		{	i = 0;		LVflag = 0;	}
	RJMP _0x11
_0x10:
	CPI  R16,10
	BRNE _0x12
	LDI  R16,LOW(0)
	LDI  R17,LOW(0)
; 0000 009D 		}
_0x12:
_0x11:
; 0000 009E 
; 0000 009F 		GLED(LVflag);
_0xF:
	CPI  R17,0
	BREQ _0x13
	IN   R30,0x15
	ORI  R30,0x20
	RJMP _0x16
_0x13:
	IN   R30,0x15
	ANDI R30,0xDF
_0x16:
	OUT  0x15,R30
; 0000 00A0 		//_delay_ms(200);
; 0000 00A1 	}//while
	RJMP _0xC
; 0000 00A2 } //test01
;//-----------------------------------------------------------------------------
;// Copyright:      RAD Electronic Co. LTD,
;// Author:         Sh. Nourbakhsh Rad
;// Remarks:
;// known Problems: none
;// Version:        3.5.1
;// Description:    NOKIA 1100 Display (PCF8814) driver
;//-----------------------------------------------------------------------------
;
;#include "N1100.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;
;
;//******************* Constants
;#if LCDlight == 0
;	unsigned char 						N11_Cache[N11_Xr][N11_Rr];
;#endif
;
;
;//*************************************************
;//******************* Functions *******************
;//*************************************************
;void N11_Write(N11_RS DC, unsigned char c)		//write command or data to LCD
; 0001 0017 {

	.CSEG
_N11_Write:
; 0001 0018 	int i;
; 0001 0019 
; 0001 001A 	N11_CS(LOW);
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	DC -> Y+3
;	c -> Y+2
;	i -> R16,R17
	CBI  0x15,3
; 0001 001B 
; 0001 001C 	N11_SCL(LOW);
	CBI  0x15,0
; 0001 001D 		N11_SDA(DC);
	LDD  R30,Y+3
	CPI  R30,0
	BREQ _0x20003
	IN   R30,0x15
	ORI  R30,2
	RJMP _0x20012
_0x20003:
	IN   R30,0x15
	ANDI R30,0xFD
_0x20012:
	OUT  0x15,R30
; 0001 001E 	N11_SCL(HIGH);
	SBI  0x15,0
; 0001 001F 
; 0001 0020 	for(i=7; i>=0; i--)
	__GETWRN 16,17,7
_0x20007:
	TST  R17
	BRMI _0x20008
; 0001 0021 	{
; 0001 0022 		N11_SCL(LOW);
	CBI  0x15,0
; 0001 0023 			N11_SDA(bit_is_set(c, i));
	MOV  R30,R16
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	CALL __LSLW12
	LDD  R26,Y+2
	LDI  R27,0
	AND  R30,R26
	AND  R31,R27
	SBIW R30,0
	BREQ _0x20009
	IN   R30,0x15
	ORI  R30,2
	RJMP _0x20013
_0x20009:
	IN   R30,0x15
	ANDI R30,0xFD
_0x20013:
	OUT  0x15,R30
; 0001 0024 		N11_SCL(HIGH);
	SBI  0x15,0
; 0001 0025 	}
	__SUBWRN 16,17,1
	RJMP _0x20007
_0x20008:
; 0001 0026 
; 0001 0027 	N11_CS(HIGH);
	SBI  0x15,3
; 0001 0028 }	//*N11_Write
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
;
;void N11_GotoXR(unsigned char x, unsigned char r)		//goto X(0..95) and R(0..8)
; 0001 002B {
_N11_GotoXR:
; 0001 002C 	N11_Write(cmd, (0xB0| (r&0x0F)));        		//Y axis initialisation: 0100 rrrr
	ST   -Y,R26
;	x -> Y+1
;	r -> Y+0
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDD  R30,Y+1
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xB0)
	CALL SUBOPT_0x7
; 0001 002D 	N11_Write(cmd, (0x00| (x&0x0F)));        		//X axis initialisation: 0000 xxxx  (x3 x2 x1 x0)
	ANDI R30,LOW(0xF)
	CALL SUBOPT_0x7
; 0001 002E 	N11_Write(cmd, (0x10|((x>>4)&0x07)));     	//X axis initialisation: 0010 0xxx  (x6 x5 x4)
	SWAP R30
	ANDI R30,LOW(0x7)
	ORI  R30,0x10
	MOV  R26,R30
	RCALL _N11_Write
; 0001 002F }	//*N11_GotoXR
	JMP  _0x20A0003
;
;//------------------------
;void N11_Init(void)														//initial LCD
; 0001 0033 {
_N11_Init:
; 0001 0034 	N11_CS_init();
	SBI  0x14,3
	SBI  0x15,3
; 0001 0035 
; 0001 0036 	N11_SDA_init();
	SBI  0x14,1
	CBI  0x15,1
; 0001 0037 	N11_SCL_init();
	SBI  0x14,0
	CBI  0x15,0
; 0001 0038 
; 0001 0039 	N11_RST_init();
	SBI  0x14,2
	CBI  0x15,2
; 0001 003A 	N11_BKL_init();
; 0001 003B 
; 0001 003C 	//----------------
; 0001 003D 	N11_CS(LOW);
	CBI  0x15,3
; 0001 003E 		_delay_ms(50);							//min. 5ms
	LDI  R26,LOW(50)
	CALL SUBOPT_0x0
; 0001 003F 
; 0001 0040 	N11_RST(HIGH);
	SBI  0x15,2
; 0001 0041 
; 0001 0042 	N11_Write(cmd, 0x23);     		//write VOP register - contrast MSB value(00100ccc - 	  c7 c6 c5)
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(35)
	CALL SUBOPT_0x8
; 0001 0043 	N11_Write(cmd, 0x90);					//write VOP register - contrast LSB value(1001cccc - c3 c2 c1 c0)
	LDI  R26,LOW(144)
	CALL SUBOPT_0x8
; 0001 0044 
; 0001 0045 	N11_Write(cmd, 0xA4);     		//all on/normal display
	LDI  R26,LOW(164)
	CALL SUBOPT_0x8
; 0001 0046 	N11_Write(cmd, 0x2F);     		//Power control set(charge pump on/off)
	LDI  R26,LOW(47)
	CALL SUBOPT_0x8
; 0001 0047 	N11_Write(cmd, 0x40);     		//set start row address = 0
	LDI  R26,LOW(64)
	CALL SUBOPT_0x8
; 0001 0048 	N11_Write(cmd, 0xB0);     		//set R-address = 0
	LDI  R26,LOW(176)
	CALL SUBOPT_0x8
; 0001 0049 	N11_Write(cmd, 0x10);     		//set X-address, upper 3 bits
	LDI  R26,LOW(16)
	CALL SUBOPT_0x8
; 0001 004A 	N11_Write(cmd, 0x00);      		//set X-address, lower 4 bits
	LDI  R26,LOW(0)
	CALL SUBOPT_0x8
; 0001 004B 	//----
; 0001 004C 	#if MirrorY ==1
; 0001 004D 		N11_Write(cmd, 0xC8); 			//mirror Y axis (about X axis)
	LDI  R26,LOW(200)
	CALL SUBOPT_0x8
; 0001 004E 	#endif
; 0001 004F 
; 0001 0050 	#if InvertScreen ==1
; 0001 0051 		N11_Write(cmd, 0xA1);				//invert screen in horizontal axis
	LDI  R26,LOW(161)
	CALL SUBOPT_0x8
; 0001 0052 	#endif
; 0001 0053 	//----
; 0001 0054 	N11_Write(cmd, 0xAC);     		//set initial row (R0) of the display
	LDI  R26,LOW(172)
	CALL SUBOPT_0x8
; 0001 0055 	N11_Write(cmd, 0x07);
	LDI  R26,LOW(7)
	CALL SUBOPT_0x8
; 0001 0056 
; 0001 0057 	N11_Write(cmd, 0xAF);    			//display ON/OFF
	LDI  R26,LOW(175)
	RCALL _N11_Write
; 0001 0058 
; 0001 0059 	N11_CLS();     	    					//clear LCD
	RCALL _N11_CLS
; 0001 005A 	N11_Write(cmd,0xA7);     			//invert display
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(167)
	RCALL _N11_Write
; 0001 005B 
; 0001 005C 		_delay_ms(500);
	CALL SUBOPT_0x1
; 0001 005D 	N11_Write(cmd,0xA6);     			//normal display (non inverted)
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(166)
	RCALL _N11_Write
; 0001 005E 		_delay_ms(500);
	CALL SUBOPT_0x1
; 0001 005F }	//*N11_Init
	RET
;
;void N11_CLS(void)														//clear LCD
; 0001 0062 {
_N11_CLS:
; 0001 0063 	unsigned char 			x, r;
; 0001 0064 
; 0001 0065 	N11_GotoXR(0, 0);
	ST   -Y,R17
	ST   -Y,R16
;	x -> R17
;	r -> R16
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _N11_GotoXR
; 0001 0066 	N11_Write(cmd, 0xAE); 					// disable display;
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(174)
	RCALL _N11_Write
; 0001 0067 
; 0001 0068 	//fill LCD and the video buffer with zero!
; 0001 0069 	for(r=0; r<N11_Rr; r++)
	LDI  R16,LOW(0)
_0x2000D:
	CPI  R16,9
	BRSH _0x2000E
; 0001 006A 	{
; 0001 006B 		for(x=0; x<N11_Xr; x++)
	LDI  R17,LOW(0)
_0x20010:
	CPI  R17,96
	BRSH _0x20011
; 0001 006C 		{
; 0001 006D 			#if LCDlight == 0
; 0001 006E 				N11_Cache[x][r]= 0x00;
; 0001 006F 			#endif
; 0001 0070 			N11_Write(data, 0x00);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _N11_Write
; 0001 0071 		}
	SUBI R17,-1
	RJMP _0x20010
_0x20011:
; 0001 0072 	}
	SUBI R16,-1
	RJMP _0x2000D
_0x2000E:
; 0001 0073 
; 0001 0074 	N11_Write(cmd, 0xAF); 					// enable display;
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(175)
	RCALL _N11_Write
; 0001 0075 }	//*N11_CLS
	LD   R16,Y+
	LD   R17,Y+
	RET
;
;void N11_Update(void) 												//write data of cache to display RAM
; 0001 0078 {
; 0001 0079 	#if LCDlight == 0
; 0001 007A 		unsigned char 			x, r;
; 0001 007B 
; 0001 007C 		N11_GotoXR(0, 0);
; 0001 007D 		//N11_Write(cmd, 0xAE); 					// disable display;
; 0001 007E 
; 0001 007F 		//serialize the video buffer to LCD
; 0001 0080 		for(r=0; r<N11_Rr; r++)
; 0001 0081 			for(x=0; x<N11_Xr; x++)
; 0001 0082 				N11_Write(data, N11_Cache[x][r]);
; 0001 0083 
; 0001 0084 		//N11_Write(cmd, 0xAF); 					// enable display;
; 0001 0085 	#endif//LCDlight
; 0001 0086 }	//*N11_Update
;
;//------------------------
;void N11_Contrast(unsigned char cont)					//set LCD contrast value from 0x00 to 0x7F
; 0001 008A {
_N11_Contrast:
; 0001 008B 	N11_Write(cmd, 0x21);					//LCD extended commands.
	ST   -Y,R26
;	cont -> Y+0
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(33)
	CALL SUBOPT_0x8
; 0001 008C 	N11_Write(cmd, 0x80|cont);		//set LCD Vop (Contrast)
	LDD  R30,Y+1
	ORI  R30,0x80
	MOV  R26,R30
	CALL SUBOPT_0x8
; 0001 008D 	N11_Write(cmd, 0x20)	;				//LCD standard commands, horizontal addressing mode.
	LDI  R26,LOW(32)
	RCALL _N11_Write
; 0001 008E }	//*N11_Contrast
	JMP  _0x20A0002
;
;void N11_Backlight(unsigned char x)						//LCD backlight ON/OFF
; 0001 0091 {
_N11_Backlight:
; 0001 0092 	#ifdef N11_BKL_BIT
; 0001 0093 		N11_BKL(x);
; 0001 0094 	#endif//N11_BKL_BIT
; 0001 0095 }	//*N11_Backlight
	RET
;
;//------------------------
;void N11_SetPixel(unsigned char x, unsigned char y, N11_Pmode mode)
; 0001 0099 {
; 0001 009A 	#if LCDlight == 0
; 0001 009B 		unsigned char			r, pd;
; 0001 009C 
; 0001 009D 	 	if((x > GetMaxX()) || (y > GetMaxY()))			return;				//exit if coordinates are not legal
; 0001 009E 
; 0001 009F 		r  = y/8;
; 0001 00A0 		pd = 1 << (y%8);
; 0001 00A1 
; 0001 00A2 		if		 (mode == PIXEL_ON)			N11_Cache[x][r] |=  pd;
; 0001 00A3 		else if(mode == PIXEL_OFF)		N11_Cache[x][r] &= ~pd;
; 0001 00A4 		else if(mode == PIXEL_XOR)		N11_Cache[x][r] ^=  pd;
; 0001 00A5 
; 0001 00A6 		N11_GotoXR(x, r);
; 0001 00A7 		N11_Write(data, N11_Cache[x][r]);
; 0001 00A8 	#endif//LCDlight
; 0001 00A9 }	//*N11_PutPixel
;
;unsigned char N11_ReadPixel(unsigned char x, unsigned char y)
; 0001 00AC {
; 0001 00AD 	#if LCDlight == 0
; 0001 00AE 	 	if((x > GetMaxX()) || (y > GetMaxY()))			return(0x00);				//exit if coordinates are not legal
; 0001 00AF 
; 0001 00B0 		return(bit_is_set(N11_Cache[x][y/8], (1 << (y%8))) ? 0x01 : 0x00);
; 0001 00B1 	#endif//LCDlight
; 0001 00B2 }	//*N11_ReadPixel
;
;void N11_FillRect(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, N11_Pmode mode)
; 0001 00B5 {
; 0001 00B6 	#if LCDlight == 0
; 0001 00B7 		unsigned char			x, y;
; 0001 00B8 		unsigned char 		h, w;
; 0001 00B9 
; 0001 00BA 	 	w = x2 + 1;
; 0001 00BB 	 	h = y2 + 1;
; 0001 00BC 
; 0001 00BD 	 	N11_Write(cmd, 0xAE); 					// disable display;
; 0001 00BE 
; 0001 00BF 		for(y=y1; y<h; y++)
; 0001 00C0 			for(x=x1; x<w; x++)
; 0001 00C1 				N11_SetPixel(x, y, mode);
; 0001 00C2 
; 0001 00C3 		N11_Write(cmd, 0xAF); 					// enable display;
; 0001 00C4 	#endif//LCDlight
; 0001 00C5 }	//*N11_FillRect
;
;	//------------------------
;void N11_DrawBitmap(const unsigned char *bitmap, unsigned char x, unsigned char y, N11_Pmode mode)
; 0001 00C9 {
; 0001 00CA 	#if LCDlight == 0
; 0001 00CB 		unsigned char 		header, width, height;
; 0001 00CC 		unsigned char			xx, yy, rr;
; 0001 00CD 		unsigned int			xy;
; 0001 00CE 		unsigned char			pd, pc, ps;
; 0001 00CF 		unsigned char 		Cdata;
; 0001 00D0 
; 0001 00D1 
; 0001 00D2 		header = pgm_read_byte(&bitmap[0]);  	//header size & width & height
; 0001 00D3 	  width  = pgm_read_byte(&bitmap[1]);
; 0001 00D4 	  height = pgm_read_byte(&bitmap[2]);
; 0001 00D5 
; 0001 00D6 		ps = _ror(1 << (y%8));
; 0001 00D7 
; 0001 00D8 		for(xx=0; xx<width; xx++)
; 0001 00D9 		{
; 0001 00DA 			pd = ps;
; 0001 00DB 	 		Cdata = pgm_read_byte(&bitmap[xx+header]);
; 0001 00DC 
; 0001 00DD 			for(yy=0, pc=0; yy<height; yy++,pc++)
; 0001 00DE 			{
; 0001 00DF 				if(pc==8)
; 0001 00E0 				{
; 0001 00E1 					xy = (unsigned char)(yy/8)*width + xx+header;
; 0001 00E2 				 	Cdata = pgm_read_byte(&bitmap[xy]);
; 0001 00E3 
; 0001 00E4 				 	pc = 0;
; 0001 00E5 				}//if pc
; 0001 00E6 
; 0001 00E7 				rr = (unsigned char)((y+yy)/8);
; 0001 00E8 				pd = _rol(pd);
; 0001 00E9 
; 0001 00EA 
; 0001 00EB 				//Draw BMP!
; 0001 00EC 				if(mode == PIXEL_XOR)
; 0001 00ED 				{
; 0001 00EE 					if(bit_is_set(Cdata, pc))			N11_Cache[x+xx][rr] &= ~pd;
; 0001 00EF 					else													N11_Cache[x+xx][rr] |=  pd;
; 0001 00F0 				}
; 0001 00F1 				else
; 0001 00F2 				{
; 0001 00F3 					if(bit_is_set(Cdata, pc))			N11_Cache[x+xx][rr] |=  pd;
; 0001 00F4 					else													N11_Cache[x+xx][rr] &= ~pd;
; 0001 00F5 				}
; 0001 00F6 			}//for yy
; 0001 00F7 		}//for xx
; 0001 00F8 
; 0001 00F9 		N11_Update();
; 0001 00FA 	#endif//LCDlight
; 0001 00FB } //*N11_DrawBitmap
;//-----------------------------------------------------------------------------
;// Copyright:      RAD Electronic Co. LTD,
;// Author:         Sh. Nourbakhsh Rad
;// Remarks:
;// known Problems: none
;// Version:        01.10.2011
;// Description:    NOKIA 1100 Display (PCF8814) simple FONT
;//-----------------------------------------------------------------------------
;
;#include "sFONT.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include "ef5x7.h"
;
;
;//******************* Functions *******************
;void N11_PrintChar(char ch)
; 0002 0010 {

	.CSEG
_N11_PrintChar:
; 0002 0011 	unsigned char i;
; 0002 0012 
; 0002 0013 	for(i=0; i<5; i++)
	ST   -Y,R26
	ST   -Y,R17
;	ch -> Y+1
;	i -> R17
	LDI  R17,LOW(0)
_0x40004:
	CPI  R17,5
	BRSH _0x40005
; 0002 0014   	N11_Write(data,	pgm_read_byte(&ef5x7[ch-32][i])<<1);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDD  R30,Y+2
	LDI  R31,0
	SBIW R30,32
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	SUBI R30,LOW(-_ef5x7*2)
	SBCI R31,HIGH(-_ef5x7*2)
	MOVW R26,R30
	MOV  R30,R17
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	LSL  R30
	MOV  R26,R30
	RCALL _N11_Write
	SUBI R17,-1
	RJMP _0x40004
_0x40005:
; 0002 0016 N11_Write(data, 0x00);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _N11_Write
; 0002 0017 }	//N11_PrintChar
	LDD  R17,Y+0
	JMP  _0x20A0003
;
;void N11_PrintString(char *str)
; 0002 001A {
_N11_PrintString:
; 0002 001B 	N11_Write(cmd, 0xAE); 				// disable display;
	ST   -Y,R27
	ST   -Y,R26
;	*str -> Y+0
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(174)
	RCALL _N11_Write
; 0002 001C 
; 0002 001D 	while(*str)										//look for end of string
_0x40006:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x40008
; 0002 001E   	N11_PrintChar(*str++);
	LD   R30,X+
	ST   Y,R26
	STD  Y+1,R27
	MOV  R26,R30
	RCALL _N11_PrintChar
	RJMP _0x40006
_0x40008:
; 0002 0020 N11_Write(cmd, 0xAF);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(175)
	RCALL _N11_Write
; 0002 0021 }	//N11_PrintString
	JMP  _0x20A0003
;//------------------------------------------------------------------------------
;// Copyright:      Pascal Stang ( 30.09.2002 )
;// Author:         Pascal Stang - Copyright (C) 2002
;// Remarks:        Modified by Sh. Nourbakhsh Rad  at date: 20.10.2008
;// known Problems: none
;// Version:        2.5.0
;// Description:    Analog-to-Digital converter functions for Atmel AVR series
;//------------------------------------------------------------------------------
;
;#include "ADC.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;
;
;//! Software flag used to indicate when
;/// the a2d conversion is complete.
;#if (FastRead ==0) || (FastRead ==1)
;	volatile unsigned char 							a2dCompleteFlag;
;#endif
;
;// functions
;
;// initialize a2d converter
;void a2dInit(void)
; 0003 0017 {

	.CSEG
_a2dInit:
; 0003 0018 	a2dTurnOn();																								// enable ADC (turn on ADC power)
	RCALL _a2dTurnOn
; 0003 0019 
; 0003 001A 	a2dSingleSample();																					// default to single sample convert mode
	RCALL _a2dSingleSample
; 0003 001B 	a2dSetPrescaler(ADC_PRESCALE);															// set default prescaler
	LDI  R26,LOW(6)
	RCALL _a2dSetPrescaler
; 0003 001C 	a2dSetReference(ADC_REFERENCE);															// set default reference
	LDI  R26,LOW(1)
	RCALL _a2dSetReference
; 0003 001D 	a2dSet10bit();																							// set to right-adjusted result
	RCALL _a2dSet10bit
; 0003 001E 
; 0003 001F 	#if (FastRead ==0) || (FastRead ==1)
; 0003 0020 		a2dCompleteFlag = False;																	// clear conversion complete flag
	LDI  R30,LOW(0)
	STS  _a2dCompleteFlag,R30
; 0003 0021 
; 0003 0022 		sbi(ADCSR, ADIE);																					// enable ADC interrupts
	SBI  0x6,3
; 0003 0023 
; 0003 0024 		sei();																										// turn on interrupts (if not already on)
	sei
; 0003 0025 	#endif
; 0003 0026 }
	RET
;
;// configure A2D converter to Single Sample mode
;void a2dSingleSample(void)
; 0003 002A {
_a2dSingleSample:
; 0003 002B 	cbi(ADCSR, ADFR);
	CBI  0x6,5
; 0003 002C }
	RET
;
;// configure A2D converter to Auto Trigger mode
;void a2dAutoTrigger(void)
; 0003 0030 {
; 0003 0031 	sbi(ADCSR, ADFR);
; 0003 0032 }
;
;// configure A2D converter right-adjusted result for 10bit conversion result
;void a2dSet10bit(void)
; 0003 0036 {
_a2dSet10bit:
; 0003 0037 	cbi(ADMUX, ADLAR);																					// set to right-adjusted result
	CBI  0x7,5
; 0003 0038 }
	RET
;
;// configure A2D converter right-adjusted result for 8bit conversion result
;void a2dSet8bit(void)
; 0003 003C {
; 0003 003D 	sbi(ADMUX, ADLAR);																					// clear right-adjusted result
; 0003 003E }
;
;// turn on a2d converter
;void a2dTurnOn(void)
; 0003 0042 {
_a2dTurnOn:
; 0003 0043 	sbi(ADCSR, ADEN);																						// enable ADC (turn on ADC power)
	SBI  0x6,7
; 0003 0044 }
	RET
;
;// turn off a2d converter
;void a2dTurnOff(void)
; 0003 0048 {
; 0003 0049 	#if (FastRead ==0) || (FastRead ==1)
; 0003 004A 		cbi(ADCSR, ADIE);																					// disable ADC interrupts
; 0003 004B 	#endif
; 0003 004C 
; 0003 004D 	cbi(ADCSR, ADEN);																						// disable ADC (turn off ADC power)
; 0003 004E }
;
;// configure A2D converter clock division (prescaling)
;void a2dSetPrescaler(unsigned char prescale)
; 0003 0052 {
_a2dSetPrescaler:
; 0003 0053 	outb(ADCSR, ((inb(ADCSR) & ~ADC_PRESCALE_MASK) | prescale));
	ST   -Y,R26
;	prescale -> Y+0
	IN   R30,0x6
	ANDI R30,LOW(0xF8)
	LD   R26,Y
	OR   R30,R26
	OUT  0x6,R30
; 0003 0054 }
	RJMP _0x20A0002
;
;// configure A2D converter voltage reference
;void a2dSetReference(unsigned char ref)
; 0003 0058 {
_a2dSetReference:
; 0003 0059 	outb(ADMUX, ((inb(ADMUX) & ~ADC_REFERENCE_MASK) | (ref<<6)));
	ST   -Y,R26
;	ref -> Y+0
	IN   R30,0x7
	ANDI R30,LOW(0x3F)
	MOV  R26,R30
	LD   R30,Y
	SWAP R30
	ANDI R30,0xF0
	LSL  R30
	LSL  R30
	OR   R30,R26
	OUT  0x7,R30
; 0003 005A }
	RJMP _0x20A0002
;
;// sets the a2d input channel
;void a2dSetChannel(unsigned char ch)
; 0003 005E {
; 0003 005F 	outb(ADMUX, (inb(ADMUX) & ~ADC_MUX_MASK) | (ch & ADC_MUX_MASK));			// set channel
;	ch -> Y+0
; 0003 0060 }
;
;// start a conversion on the current a2d input channel
;void a2dStartConvert(void)
; 0003 0064 {
; 0003 0065 	#if (FastRead ==0) || (FastRead ==1)
; 0003 0066 		sbi(ADCSR, ADIF);																					// clear hardware "conversion complete" flag
; 0003 0067 	#endif
; 0003 0068 
; 0003 0069 	sbi(ADCSR, ADSC);																						// start conversion
; 0003 006A }
;
;// return True if conversion is complete
;unsigned char a2dIsComplete(void)
; 0003 006E {
; 0003 006F 	return bit_is_set(ADCSR, ADSC);
; 0003 0070 }
;
;// Perform a 10-bit conversion
;// starts conversion, waits until conversion is done, and returns result
;unsigned short a2dConvert10bit(unsigned char ch)
; 0003 0075 {
_a2dConvert10bit:
; 0003 0076 	#if (FastRead ==0)
; 0003 0077 		a2dCompleteFlag = False;																						// clear conversion complete flag
	ST   -Y,R26
;	ch -> Y+0
	LDI  R30,LOW(0)
	STS  _a2dCompleteFlag,R30
; 0003 0078 		outb(ADMUX, (inb(ADMUX) & ~ADC_MUX_MASK) | (ch & ADC_MUX_MASK));		// set channel
	IN   R30,0x7
	ANDI R30,LOW(0xE0)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0x1F)
	OR   R30,R26
	OUT  0x7,R30
; 0003 0079 
; 0003 007A 		sbi(ADCSR, ADIF);																										// clear hardware "conversion complete" flag
	SBI  0x6,4
; 0003 007B 		sbi(ADCSR, ADSC);																										// start conversion
	SBI  0x6,6
; 0003 007C 		while(!a2dCompleteFlag);																						// wait until conversion complete
_0x60003:
	LDS  R30,_a2dCompleteFlag
	CPI  R30,0
	BREQ _0x60003
; 0003 007D 
; 0003 007E 	#elif (FastRead ==1)
; 0003 007F 		sbi(ADCSR, ADIF);																										// clear hardware "conversion complete" flag
; 0003 0080 		sbi(ADCSR, ADSC);																										// start conversion
; 0003 0081 		while(bit_is_set(ADCSR, ADSC));																			// wait until conversion complete
; 0003 0082 
; 0003 0083 	#endif
; 0003 0084 
; 0003 0085 	return (ADCW);																												// read ADC (full 10 bits);
	IN   R30,0x4
	IN   R31,0x4+1
	RJMP _0x20A0002
; 0003 0086 }
;
;// Perform a 8-bit conversion.
;// starts conversion, waits until conversion is done, and returns result
;unsigned char a2dConvert8bit(unsigned char ch)
; 0003 008B {
_a2dConvert8bit:
; 0003 008C 	#if (FastRead ==0) || (FastRead ==1)
; 0003 008D 		// do 10-bit conversion and return highest 8 bits
; 0003 008E 		return (a2dConvert10bit(ch)>>2);																		// return ADC MSB byte
	ST   -Y,R26
;	ch -> Y+0
	LD   R26,Y
	RCALL _a2dConvert10bit
	CALL __LSRW2
	RJMP _0x20A0002
; 0003 008F 
; 0003 0090 	#else
; 0003 0091 		return (ADCH);																											// read ADC (8 bits);
; 0003 0092 
; 0003 0093 	#endif
; 0003 0094 }
;
;//! Interrupt handler for ADC complete interrupt.
;ISR_ADC_COMPLETE()
; 0003 0098 {
_isrADC_vect:
	ST   -Y,R30
; 0003 0099 	#if (FastRead ==0) || (FastRead ==1)
; 0003 009A 		// set the a2d conversion flag to indicate "complete"
; 0003 009B 		a2dCompleteFlag = True;
	LDI  R30,LOW(1)
	STS  _a2dCompleteFlag,R30
; 0003 009C 	#endif
; 0003 009D }
	LD   R30,Y+
	RETI
;//-----------------------------------------------------------------------------
;// Copyright:      	www.KnowledgePlus.ir
;// Author:         	OZHAN KD
;// Remarks:        	code ported to GNUC by Sh. Nourbakhsh Rad
;// known Problems: 	none
;// Version:        	1.5.2
;// Description:
;//									MCU: ATmega64 @8MHz external xtal
;//
;//									3 phase SPWM outputs on OCR1A,OCR1B,OCR1C
;//									Carrier frequency = 15.6 KHz
;//									Sine frequency range = 0.5-100Hz with 0.1Hz step
;//									PWM resolution = 8bit
;//
;//									Frequency varies by applied voltage to ADC0(PF0)
;//									ADC Vref = AVcc
;//									ADC result<14 ---> output off
;//									ADC result: 14-1009 ---> f: 0.5 Hz - 100 Hz
;//									ADC result>1009 ---> f=100 Hz
;//
;//-----------------------------------------------------------------------------
;// History:
;//									V1.0 Mar 2011
;//										Start Project....
;//
;//									V1.1 Feb 2011
;//										Linear V/F curve added
;//
;//									V1.2 Jun 2011
;//										Acceleration-Deceleration added
;//
;//									V1.3 Jul 2011
;//										Adjustable Acceleration-Deceleration
;//										by ADC1 and ADC2 analog inputs
;//										ADC1 sets acceleration (1s-255s)
;//										ADC2 sets decceleration (1s-255s)
;//										Adjusted values are times for 100Hz change in frequency
;//
;//									V1.4 Jul 2012
;//										Fixed some bugs
;//
;//									V1.5 Oct 4, 2012
;//										Timer3 mode changed to Fast PWM (due to problems in frequency change)
;//										modification in amplitude calculation
;//
;//-----------------------------------------------------------------------------
;
;#include "SPWM.h"
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;
;#include "SINE_tbl.h"
;#include "TIMER_tbl.h"
;
;
;//******************* Constants
;volatile unsigned int 										FinalSpeed		= 0;
;volatile unsigned char 										Acceleration	= 1;

	.DSEG
;volatile unsigned char 										Deceleration	= 1;
;
;volatile unsigned int 										speed					= 0;
;volatile unsigned char 										index					= 0;
;
;volatile unsigned char 										MSflag				= 0;
;
;volatile unsigned int 										TCounter 			= 0;
;
;
;//*************************************************
;//******************* Functions *******************
;//*************************************************
;unsigned char A_calc(unsigned char sine, unsigned char Ain)
; 0004 0047 {

	.CSEG
_A_calc:
; 0004 0048 	unsigned int 						sine_temp;
; 0004 0049 	unsigned char 					sine1;
; 0004 004A 
; 0004 004B 	sine1 = (sine<128)? ~sine : sine;
	ST   -Y,R26
	CALL __SAVELOCR4
;	sine -> Y+5
;	Ain -> Y+4
;	sine_temp -> R16,R17
;	sine1 -> R19
	LDD  R26,Y+5
	CPI  R26,LOW(0x80)
	BRSH _0x80005
	LDD  R30,Y+5
	COM  R30
	RJMP _0x80006
_0x80005:
	LDD  R30,Y+5
_0x80006:
	MOV  R19,R30
; 0004 004C 
; 0004 004D 	sine_temp   = ((unsigned int)sine1) <<1;
	MOV  R30,R19
	LDI  R31,0
	LSL  R30
	ROL  R31
	MOVW R16,R30
; 0004 004E 	sine_temp  -= 255;
	__SUBWRN 16,17,255
; 0004 004F 	sine_temp  *= Ain;
	LDD  R30,Y+4
	LDI  R31,0
	MOVW R26,R16
	CALL __MULW12U
	MOVW R16,R30
; 0004 0050 	sine_temp >>= 8;
	MOV  R16,R17
	CLR  R17
; 0004 0051 	sine_temp  += 255;
	__ADDWRN 16,17,255
; 0004 0052 	sine_temp >>= 1;
	LSR  R17
	ROR  R16
; 0004 0053 	sine_temp  += 1;
	__ADDWRN 16,17,1
; 0004 0054 
; 0004 0055 	sine1 = (unsigned char)sine_temp;
	MOV  R19,R16
; 0004 0056 
; 0004 0057 	return((sine<128)? ~sine1 : sine1);
	LDD  R26,Y+5
	CPI  R26,LOW(0x80)
	BRSH _0x80008
	MOV  R30,R19
	COM  R30
	RJMP _0x80009
_0x80008:
	MOV  R30,R19
_0x80009:
	CALL __LOADLOCR4
	ADIW R28,6
	RET
; 0004 0058 }	//A_calc
;
;//-----------------------------------------------------------------------------
;ISR_PWM_SET()
; 0004 005C {
_isrTIMER3_COMPA_vect:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0004 005D 	unsigned long 				A;
; 0004 005E 
; 0004 005F 	if 			(speed>795)				index += 16;
	SBIW R28,4
;	A -> Y+0
	CALL SUBOPT_0x9
	CPI  R26,LOW(0x31C)
	LDI  R30,HIGH(0x31C)
	CPC  R27,R30
	BRLO _0x8000B
	LDS  R30,_index
	SUBI R30,-LOW(16)
	RJMP _0x80028
; 0004 0060 	else if	(speed>595)				index += 8;
_0x8000B:
	CALL SUBOPT_0x9
	CPI  R26,LOW(0x254)
	LDI  R30,HIGH(0x254)
	CPC  R27,R30
	BRLO _0x8000D
	LDS  R30,_index
	SUBI R30,-LOW(8)
	RJMP _0x80028
; 0004 0061 	else if	(speed>395)				index += 4;
_0x8000D:
	CALL SUBOPT_0x9
	CPI  R26,LOW(0x18C)
	LDI  R30,HIGH(0x18C)
	CPC  R27,R30
	BRLO _0x8000F
	LDS  R30,_index
	SUBI R30,-LOW(4)
	RJMP _0x80028
; 0004 0062 	else if	(speed>195)				index += 2;
_0x8000F:
	CALL SUBOPT_0x9
	CPI  R26,LOW(0xC4)
	LDI  R30,HIGH(0xC4)
	CPC  R27,R30
	BRLO _0x80011
	LDS  R30,_index
	SUBI R30,-LOW(2)
	RJMP _0x80028
; 0004 0063 	else 											index += 1;
_0x80011:
	LDS  R30,_index
	SUBI R30,-LOW(1)
_0x80028:
	STS  _index,R30
; 0004 0064 
; 0004 0065 	//-------------------
; 0004 0066 	if(speed>=f_Base)
	CALL SUBOPT_0x9
	CPI  R26,LOW(0x1EF)
	LDI  R30,HIGH(0x1EF)
	CPC  R27,R30
	BRLO _0x80013
; 0004 0067 	{
; 0004 0068 		PWMR_SET(pgm_read_byte(&sine[R_Index(index)]));
	CALL SUBOPT_0xA
	CALL SUBOPT_0xB
	CALL SUBOPT_0xC
; 0004 0069 		PWMS_SET(pgm_read_byte(&sine[S_Index(index)]));
	CALL SUBOPT_0xD
	CALL SUBOPT_0xE
; 0004 006A 		PWMT_SET(pgm_read_byte(&sine[T_Index(index)]));
	CALL SUBOPT_0xF
	RJMP _0x80029
; 0004 006B 	}
; 0004 006C 
; 0004 006D 	//-----
; 0004 006E 	else if (speed<=f_Boost)
_0x80013:
	CALL SUBOPT_0x9
	CPI  R26,LOW(0x60)
	LDI  R30,HIGH(0x60)
	CPC  R27,R30
	BRSH _0x80015
; 0004 006F 	{
; 0004 0070 		PWMR_SET(A_calc(pgm_read_byte(&sine[R_Index(index)]), A_Boost));
	CALL SUBOPT_0xA
	CALL SUBOPT_0xB
	ST   -Y,R30
	LDI  R26,LOW(25)
	RCALL _A_calc
	CALL SUBOPT_0xC
; 0004 0071 		PWMS_SET(A_calc(pgm_read_byte(&sine[S_Index(index)]), A_Boost));
	CALL SUBOPT_0xD
	ST   -Y,R30
	LDI  R26,LOW(25)
	RCALL _A_calc
	CALL SUBOPT_0xE
; 0004 0072 		PWMT_SET(A_calc(pgm_read_byte(&sine[T_Index(index)]), A_Boost));
	CALL SUBOPT_0xF
	ST   -Y,R30
	LDI  R26,LOW(25)
	RJMP _0x8002A
; 0004 0073 	}
; 0004 0074 
; 0004 0075 	//-----
; 0004 0076 	else
_0x80015:
; 0004 0077 	{
; 0004 0078 		A = ((N *(unsigned long)(speed -f_Boost)) /M) +A_Boost;
	CALL SUBOPT_0x10
	SUBI R30,LOW(95)
	SBCI R31,HIGH(95)
	CLR  R22
	CLR  R23
	__GETD2N 0xE6
	CALL __MULD12U
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x190
	CALL __DIVD21U
	__ADDD1N 25
	CALL __PUTD1S0
; 0004 0079 
; 0004 007A 		PWMR_SET(A_calc(pgm_read_byte(&sine[R_Index(index)]), (unsigned char)A));
	CALL SUBOPT_0xA
	CALL SUBOPT_0xB
	ST   -Y,R30
	LDD  R26,Y+1
	RCALL _A_calc
	CALL SUBOPT_0xC
; 0004 007B 		PWMS_SET(A_calc(pgm_read_byte(&sine[S_Index(index)]), (unsigned char)A));
	CALL SUBOPT_0xD
	ST   -Y,R30
	LDD  R26,Y+1
	RCALL _A_calc
	CALL SUBOPT_0xE
; 0004 007C 		PWMT_SET(A_calc(pgm_read_byte(&sine[T_Index(index)]), (unsigned char)A));
	CALL SUBOPT_0xF
	ST   -Y,R30
	LDD  R26,Y+1
_0x8002A:
	RCALL _A_calc
_0x80029:
	LDI  R26,LOW(120)
	LDI  R27,HIGH(120)
	LDI  R31,0
	ST   X+,R30
	ST   X,R31
; 0004 007D 	}
; 0004 007E }	//ISR_PWM_SET
	ADIW R28,4
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;
;ISR_SPEED_TUNE()								//Occur every 1ms!
; 0004 0081 {
_isrTIMER2_COMP_vect:
	ST   -Y,R0
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0004 0082 	#if (ACC_DEC_USE ==0)
; 0004 0083 		speed = FinalSpeed;
; 0004 0084 
; 0004 0085 	#else
; 0004 0086 		static unsigned char 					ACC_counter = 0;
; 0004 0087 		static unsigned char 					DEC_counter = 0;
; 0004 0088 
; 0004 0089 
; 0004 008A 		//-----  Acceleration
; 0004 008B 		if(speed<FinalSpeed)
	CALL SUBOPT_0x11
	CP   R26,R30
	CPC  R27,R31
	BRSH _0x80017
; 0004 008C 		{
; 0004 008D 			DEC_counter = 0;
	LDI  R30,LOW(0)
	STS  _DEC_counter_S0040002000,R30
; 0004 008E 
; 0004 008F 			#if (ACC_DEC_USE ==1) || (ACC_DEC_USE ==3)
; 0004 0090 				ACC_counter++;
	LDS  R30,_ACC_counter_S0040002000
	SUBI R30,-LOW(1)
	STS  _ACC_counter_S0040002000,R30
; 0004 0091 		 		if(ACC_counter>=Acceleration)
	LDS  R30,_Acceleration
	LDS  R26,_ACC_counter_S0040002000
	CP   R26,R30
	BRLO _0x80018
; 0004 0092 		 		{
; 0004 0093 		 			ACC_counter = 0;
	LDI  R30,LOW(0)
	STS  _ACC_counter_S0040002000,R30
; 0004 0094 		  		speed++;
	LDI  R26,LOW(_speed)
	LDI  R27,HIGH(_speed)
	CALL SUBOPT_0x12
; 0004 0095 				}
; 0004 0096 
; 0004 0097 			#else
; 0004 0098 				speed = FinalSpeed;
; 0004 0099 
; 0004 009A 			#endif
; 0004 009B 		}
_0x80018:
; 0004 009C 
; 0004 009D 		//-----  Deceleration
; 0004 009E 		else if(speed>FinalSpeed)
	RJMP _0x80019
_0x80017:
	CALL SUBOPT_0x11
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x8001A
; 0004 009F 		{
; 0004 00A0 			ACC_counter = 0;
	LDI  R30,LOW(0)
	STS  _ACC_counter_S0040002000,R30
; 0004 00A1 
; 0004 00A2 			#if (ACC_DEC_USE ==2) || (ACC_DEC_USE ==3)
; 0004 00A3 				DEC_counter++;
	LDS  R30,_DEC_counter_S0040002000
	SUBI R30,-LOW(1)
	STS  _DEC_counter_S0040002000,R30
; 0004 00A4 				if(DEC_counter>=Deceleration)
	LDS  R30,_Deceleration
	LDS  R26,_DEC_counter_S0040002000
	CP   R26,R30
	BRLO _0x8001B
; 0004 00A5 				{
; 0004 00A6 			  	DEC_counter = 0;
	LDI  R30,LOW(0)
	STS  _DEC_counter_S0040002000,R30
; 0004 00A7 			  	speed--;
	LDI  R26,LOW(_speed)
	LDI  R27,HIGH(_speed)
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0004 00A8 				}
; 0004 00A9 
; 0004 00AA 			#else
; 0004 00AB 				speed = FinalSpeed;
; 0004 00AC 
; 0004 00AD 			#endif
; 0004 00AE 		}
_0x8001B:
; 0004 00AF 
; 0004 00B0 		//-----
; 0004 00B1 		else
	RJMP _0x8001C
_0x8001A:
; 0004 00B2 		{
; 0004 00B3 	 		ACC_counter = 0;
	LDI  R30,LOW(0)
	STS  _ACC_counter_S0040002000,R30
; 0004 00B4 	  	DEC_counter = 0;
	STS  _DEC_counter_S0040002000,R30
; 0004 00B5 		}
_0x8001C:
_0x80019:
; 0004 00B6 
; 0004 00B7 	#endif
; 0004 00B8 
; 0004 00B9 	//-------------------
; 0004 00BA 	if(speed)
	CALL SUBOPT_0x10
	SBIW R30,0
	BREQ _0x8001D
; 0004 00BB 	{
; 0004 00BC 		FRQ_SET(pgm_read_word(&Timer_Value[speed])-1);
	CALL SUBOPT_0x10
	LDI  R26,LOW(_Timer_Value*2)
	LDI  R27,HIGH(_Timer_Value*2)
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	CALL __GETW1PF
	SBIW R30,1
	STS  134,R30
	STS  134+1,R31
; 0004 00BD 
; 0004 00BE  		if(MSflag==0)
	LDS  R30,_MSflag
	CPI  R30,0
	BRNE _0x8001E
; 0004 00BF  		{
; 0004 00C0 			PWMRST_ON();
	IN   R30,0x2F
	ORI  R30,0x80
	OUT  0x2F,R30
	IN   R30,0x2F
	ORI  R30,0x20
	OUT  0x2F,R30
	IN   R30,0x2F
	ORI  R30,8
	OUT  0x2F,R30
; 0004 00C1 			MSflag = 1;
	LDI  R30,LOW(1)
	STS  _MSflag,R30
; 0004 00C2 
; 0004 00C3 			PWM_INTV_TMR_ON();
	LDS  R30,138
	ANDI R30,LOW(0xF8)
	ORI  R30,1
	STS  138,R30
; 0004 00C4 			PWM_INTV_ena();
	LDS  R30,124
	ORI  R30,0x10
	STS  124,R30
	LDS  R30,125
	ORI  R30,0x10
	STS  125,R30
; 0004 00C5 		}
; 0004 00C6 	}
_0x8001E:
; 0004 00C7 
; 0004 00C8 	//-----
; 0004 00C9 	else
	RJMP _0x8001F
_0x8001D:
; 0004 00CA 	{
; 0004 00CB 	 	PWMRST_OFF();
	IN   R30,0x2F
	ANDI R30,0x7F
	OUT  0x2F,R30
	IN   R30,0x2F
	ANDI R30,0xDF
	OUT  0x2F,R30
	IN   R30,0x2F
	ANDI R30,0XF7
	OUT  0x2F,R30
; 0004 00CC 		MSflag = 0;
	LDI  R30,LOW(0)
	STS  _MSflag,R30
; 0004 00CD 
; 0004 00CE 	 	PWM_INTV_TMR_OFF();
	LDS  R30,138
	ANDI R30,LOW(0xF8)
	STS  138,R30
; 0004 00CF 	 	PWM_INTV_dis();
	LDS  R30,125
	ANDI R30,0xEF
	STS  125,R30
; 0004 00D0 	}
_0x8001F:
; 0004 00D1 
; 0004 00D2 	TCounter++;
	LDI  R26,LOW(_TCounter)
	LDI  R27,HIGH(_TCounter)
	CALL SUBOPT_0x12
; 0004 00D3 }	//ISR_SPEED_TUNE
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R0,Y+
	RETI
;
;//-----------------------------------------------------------------------------
;//-----------------------------------------------------------------------------
;void SPWM_init(void)
; 0004 00D8 {
_SPWM_init:
; 0004 00D9 	SPWM_HW_init();
	SBI  0x17,5
	IN   R30,0x2F
	ANDI R30,0x7F
	OUT  0x2F,R30
	SBI  0x17,6
	IN   R30,0x2F
	ANDI R30,0xDF
	OUT  0x2F,R30
	SBI  0x17,7
	IN   R30,0x2F
	ANDI R30,0XF7
	OUT  0x2F,R30
; 0004 00DA 
; 0004 00DB 	PWMR_SET(R_Index(index));
	CALL SUBOPT_0xA
	ADIW R30,0
	CALL SUBOPT_0x13
	OUT  0x2A+1,R31
	OUT  0x2A,R30
; 0004 00DC  	PWMS_SET(S_Index(index));
	CALL SUBOPT_0xA
	SUBI R30,LOW(-84)
	SBCI R31,HIGH(-84)
	CALL SUBOPT_0x13
	OUT  0x28+1,R31
	OUT  0x28,R30
; 0004 00DD  	PWMT_SET(T_Index(index));
	CALL SUBOPT_0xA
	SUBI R30,LOW(-170)
	SBCI R31,HIGH(-170)
	LDI  R31,0
	LDI  R26,LOW(120)
	LDI  R27,HIGH(120)
	LDI  R31,0
	ST   X+,R30
	ST   X,R31
; 0004 00DE 
; 0004 00DF 	PWM_TMR_init();
	LDI  R30,LOW(1)
	OUT  0x2F,R30
; 0004 00E0 	PWM_TMR_ON();
	IN   R30,0x2E
	ANDI R30,LOW(0xF8)
	ORI  R30,1
	OUT  0x2E,R30
; 0004 00E1 
; 0004 00E2 	PWM_INTV_init();
	LDI  R30,LOW(3)
	STS  139,R30
	LDI  R30,LOW(24)
	STS  138,R30
; 0004 00E3 	SPEED_INTV_SET(SPEED_INTV_time);		//Occur every 1ms!
	LDI  R30,LOW(124)
	OUT  0x23,R30
; 0004 00E4 
; 0004 00E5 	SPEED_INTV_init();
	LDI  R30,LOW(11)
	OUT  0x25,R30
; 0004 00E6 	SPEED_INTV_ena();
	IN   R30,0x36
	ORI  R30,0x80
	OUT  0x36,R30
	IN   R30,0x37
	ORI  R30,0x80
	OUT  0x37,R30
; 0004 00E7 }	//SPWM_init
	RET
;
;unsigned int SetFrequency(unsigned int FRQ)
; 0004 00EA {
_SetFrequency:
; 0004 00EB 	if			(FRQ<14)					FinalSpeed = 0;
	ST   -Y,R27
	ST   -Y,R26
;	FRQ -> Y+0
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,14
	BRSH _0x80020
	LDI  R30,LOW(0)
	STS  _FinalSpeed,R30
	STS  _FinalSpeed+1,R30
; 0004 00EC 	else if (FRQ<1010)				FinalSpeed = FRQ -13;
	RJMP _0x80021
_0x80020:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x3F2)
	LDI  R30,HIGH(0x3F2)
	CPC  R27,R30
	BRSH _0x80022
	LD   R30,Y
	LDD  R31,Y+1
	SBIW R30,13
	RJMP _0x8002B
; 0004 00ED 	else 											FinalSpeed = 996;
_0x80022:
	LDI  R30,LOW(996)
	LDI  R31,HIGH(996)
_0x8002B:
	STS  _FinalSpeed,R30
	STS  _FinalSpeed+1,R31
; 0004 00EE 
; 0004 00EF 	return(FinalSpeed +4);
_0x80021:
	LDS  R30,_FinalSpeed
	LDS  R31,_FinalSpeed+1
	ADIW R30,4
_0x20A0003:
	ADIW R28,2
	RET
; 0004 00F0 }	//SetFrequency
;
;unsigned char SetAcceleration(unsigned char ACC)
; 0004 00F3 {
_SetAcceleration:
; 0004 00F4 	if(ACC) 									Acceleration = ACC;
	ST   -Y,R26
;	ACC -> Y+0
	LD   R30,Y
	CPI  R30,0
	BREQ _0x80024
	RJMP _0x8002C
; 0004 00F5 	else 											Acceleration = 1;
_0x80024:
	LDI  R30,LOW(1)
_0x8002C:
	STS  _Acceleration,R30
; 0004 00F6 
; 0004 00F7 	return(Acceleration);
	LDS  R30,_Acceleration
	RJMP _0x20A0002
; 0004 00F8 }	//SetAcceleration
;
;unsigned char SetDeceleration(unsigned char DEC)
; 0004 00FB {
_SetDeceleration:
; 0004 00FC 	if(DEC) 									Deceleration = DEC;
	ST   -Y,R26
;	DEC -> Y+0
	LD   R30,Y
	CPI  R30,0
	BREQ _0x80026
	RJMP _0x8002D
; 0004 00FD 	else 											Deceleration = 1;
_0x80026:
	LDI  R30,LOW(1)
_0x8002D:
	STS  _Deceleration,R30
; 0004 00FE 
; 0004 00FF 	return(Deceleration);
	LDS  R30,_Deceleration
_0x20A0002:
	ADIW R28,1
	RET
; 0004 0100 }	//SetDeceleration

	.CSEG

	.DSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_put_buff_G101:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2020010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2020012
	__CPWRN 16,17,2
	BRLO _0x2020013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2020012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL SUBOPT_0x12
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2020014
	CALL SUBOPT_0x12
_0x2020014:
_0x2020013:
	RJMP _0x2020015
_0x2020010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2020015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
__print_G101:
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2020016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+3
	JMP _0x2020018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x202001C
	CPI  R18,37
	BRNE _0x202001D
	LDI  R17,LOW(1)
	RJMP _0x202001E
_0x202001D:
	CALL SUBOPT_0x14
_0x202001E:
	RJMP _0x202001B
_0x202001C:
	CPI  R30,LOW(0x1)
	BRNE _0x202001F
	CPI  R18,37
	BRNE _0x2020020
	CALL SUBOPT_0x14
	RJMP _0x20200C9
_0x2020020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2020021
	LDI  R16,LOW(1)
	RJMP _0x202001B
_0x2020021:
	CPI  R18,43
	BRNE _0x2020022
	LDI  R20,LOW(43)
	RJMP _0x202001B
_0x2020022:
	CPI  R18,32
	BRNE _0x2020023
	LDI  R20,LOW(32)
	RJMP _0x202001B
_0x2020023:
	RJMP _0x2020024
_0x202001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2020025
_0x2020024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2020026
	ORI  R16,LOW(128)
	RJMP _0x202001B
_0x2020026:
	RJMP _0x2020027
_0x2020025:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x202001B
_0x2020027:
	CPI  R18,48
	BRLO _0x202002A
	CPI  R18,58
	BRLO _0x202002B
_0x202002A:
	RJMP _0x2020029
_0x202002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x202001B
_0x2020029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x202002F
	CALL SUBOPT_0x15
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x16
	RJMP _0x2020030
_0x202002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2020032
	CALL SUBOPT_0x15
	CALL SUBOPT_0x17
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2020033
_0x2020032:
	CPI  R30,LOW(0x70)
	BRNE _0x2020035
	CALL SUBOPT_0x15
	CALL SUBOPT_0x17
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2020033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2020036
_0x2020035:
	CPI  R30,LOW(0x64)
	BREQ _0x2020039
	CPI  R30,LOW(0x69)
	BRNE _0x202003A
_0x2020039:
	ORI  R16,LOW(4)
	RJMP _0x202003B
_0x202003A:
	CPI  R30,LOW(0x75)
	BRNE _0x202003C
_0x202003B:
	LDI  R30,LOW(_tbl10_G101*2)
	LDI  R31,HIGH(_tbl10_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x202003D
_0x202003C:
	CPI  R30,LOW(0x58)
	BRNE _0x202003F
	ORI  R16,LOW(8)
	RJMP _0x2020040
_0x202003F:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x2020071
_0x2020040:
	LDI  R30,LOW(_tbl16_G101*2)
	LDI  R31,HIGH(_tbl16_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x202003D:
	SBRS R16,2
	RJMP _0x2020042
	CALL SUBOPT_0x15
	CALL SUBOPT_0x18
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2020043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2020043:
	CPI  R20,0
	BREQ _0x2020044
	SUBI R17,-LOW(1)
	RJMP _0x2020045
_0x2020044:
	ANDI R16,LOW(251)
_0x2020045:
	RJMP _0x2020046
_0x2020042:
	CALL SUBOPT_0x15
	CALL SUBOPT_0x18
_0x2020046:
_0x2020036:
	SBRC R16,0
	RJMP _0x2020047
_0x2020048:
	CP   R17,R21
	BRSH _0x202004A
	SBRS R16,7
	RJMP _0x202004B
	SBRS R16,2
	RJMP _0x202004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x202004D
_0x202004C:
	LDI  R18,LOW(48)
_0x202004D:
	RJMP _0x202004E
_0x202004B:
	LDI  R18,LOW(32)
_0x202004E:
	CALL SUBOPT_0x14
	SUBI R21,LOW(1)
	RJMP _0x2020048
_0x202004A:
_0x2020047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x202004F
_0x2020050:
	CPI  R19,0
	BREQ _0x2020052
	SBRS R16,3
	RJMP _0x2020053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2020054
_0x2020053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2020054:
	CALL SUBOPT_0x14
	CPI  R21,0
	BREQ _0x2020055
	SUBI R21,LOW(1)
_0x2020055:
	SUBI R19,LOW(1)
	RJMP _0x2020050
_0x2020052:
	RJMP _0x2020056
_0x202004F:
_0x2020058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x202005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x202005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x202005A
_0x202005C:
	CPI  R18,58
	BRLO _0x202005D
	SBRS R16,3
	RJMP _0x202005E
	SUBI R18,-LOW(7)
	RJMP _0x202005F
_0x202005E:
	SUBI R18,-LOW(39)
_0x202005F:
_0x202005D:
	SBRC R16,4
	RJMP _0x2020061
	CPI  R18,49
	BRSH _0x2020063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2020062
_0x2020063:
	RJMP _0x20200CA
_0x2020062:
	CP   R21,R19
	BRLO _0x2020067
	SBRS R16,0
	RJMP _0x2020068
_0x2020067:
	RJMP _0x2020066
_0x2020068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2020069
	LDI  R18,LOW(48)
_0x20200CA:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x202006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x16
	CPI  R21,0
	BREQ _0x202006B
	SUBI R21,LOW(1)
_0x202006B:
_0x202006A:
_0x2020069:
_0x2020061:
	CALL SUBOPT_0x14
	CPI  R21,0
	BREQ _0x202006C
	SUBI R21,LOW(1)
_0x202006C:
_0x2020066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2020059
	RJMP _0x2020058
_0x2020059:
_0x2020056:
	SBRS R16,0
	RJMP _0x202006D
_0x202006E:
	CPI  R21,0
	BREQ _0x2020070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x16
	RJMP _0x202006E
_0x2020070:
_0x202006D:
_0x2020071:
_0x2020030:
_0x20200C9:
	LDI  R17,LOW(0)
_0x202001B:
	RJMP _0x2020016
_0x2020018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
_sprintf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x19
	SBIW R30,0
	BRNE _0x2020072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20A0001
_0x2020072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0x19
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G101)
	LDI  R31,HIGH(_put_buff_G101)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G101
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x20A0001:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET

	.CSEG
_strlen:
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret

	.CSEG

	.CSEG

	.DSEG
_TCounter:
	.BYTE 0x2
_Ctemp:
	.BYTE 0x18
_SPchar_S0000004000:
	.BYTE 0xA
_a2dCompleteFlag:
	.BYTE 0x1
_FinalSpeed:
	.BYTE 0x2
_Acceleration:
	.BYTE 0x1
_Deceleration:
	.BYTE 0x1
_speed:
	.BYTE 0x2
_index:
	.BYTE 0x1
_MSflag:
	.BYTE 0x1
_ACC_counter_S0040002000:
	.BYTE 0x1
_DEC_counter_S0040002000:
	.BYTE 0x1
__seed_G100:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	CALL _N11_PrintString
	LDI  R30,LOW(2)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	STS  97,R30
	LDS  R30,98
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(_Ctemp)
	LDI  R31,HIGH(_Ctemp)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	CALL _N11_GotoXR
	LDI  R26,LOW(_Ctemp)
	LDI  R27,HIGH(_Ctemp)
	CALL _N11_PrintString
	RJMP SUBOPT_0x4

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x6:
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	LDI  R30,LOW(2)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	MOV  R26,R30
	CALL _N11_Write
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDD  R30,Y+2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x8:
	CALL _N11_Write
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x9:
	LDS  R26,_speed
	LDS  R27,_speed+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:30 WORDS
SUBOPT_0xA:
	LDS  R30,_index
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xB:
	ADIW R30,0
	LDI  R31,0
	LDI  R31,0
	SUBI R30,LOW(-_sine*2)
	SBCI R31,HIGH(-_sine*2)
	LPM  R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xC:
	LDI  R31,0
	OUT  0x2A+1,R31
	OUT  0x2A,R30
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0xD:
	SUBI R30,LOW(-84)
	SBCI R31,HIGH(-84)
	LDI  R31,0
	LDI  R31,0
	SUBI R30,LOW(-_sine*2)
	SBCI R31,HIGH(-_sine*2)
	LPM  R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xE:
	LDI  R31,0
	OUT  0x28+1,R31
	OUT  0x28,R30
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0xF:
	SUBI R30,LOW(-170)
	SBCI R31,HIGH(-170)
	LDI  R31,0
	LDI  R31,0
	SUBI R30,LOW(-_sine*2)
	SBCI R31,HIGH(-_sine*2)
	LPM  R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	LDS  R30,_speed
	LDS  R31,_speed+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	LDS  R30,_FinalSpeed
	LDS  R31,_FinalSpeed+1
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x12:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	LDI  R31,0
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x14:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x15:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x16:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x17:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x18:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x19:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__LSLW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSLW12R
__LSLW12L:
	LSL  R30
	ROL  R31
	DEC  R0
	BRNE __LSLW12L
__LSLW12R:
	RET

__LSRW2:
	LSR  R31
	ROR  R30
	LSR  R31
	ROR  R30
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
