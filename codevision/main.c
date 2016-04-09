//-----------------------------------------------------------------------------
// Copyright:      www.KnowledgePlus.ir
// Author:         OZHAN KD ported by Sh. Nourbakhsh Rad
// Remarks:        
// known Problems: none
// Version:        1.1.0
// Description:    SPWM test...
//-----------------------------------------------------------------------------

//	Include Headers
//*****************************************************************************
#include "app_config.h"
#include "HW_SPWM.h"

//--------------------------------------------------
#include "N11\N1100.h"
#include "sFONT\sFONT.h"

//--------------------------------------------------
#include "ADC\ADC.h"

//--------------------------------------------------
#include "SPWM\SPWM.h"


//	Constants and Varables
//*****************************************************************************

//Temp Const.
char 														Ctemp[24];
int  														Itemp = 0;


//	Functions Prototype
//*****************************************************************************
void Initial(void);
void Splash(void);

void test01(void);


//	<<< main function >>>
//*****************************************************************************
void main(void)
{
	Initial();
	test01();
	
	while(1);
} //main


//---------------------------------------------------------//
//---------------------------------------------------------//
void Initial(void)
{
	cli();												//Interrupts disable

	HW_init();
	a2dInit();										//AVCC & DIV64
	
	_delay_ms(500);

	//----------------------
	N11_Init();
	N11_Contrast(10);
	N11_Backlight(ON);
	
	//----------------------
	BUZZER(BOOT_sign);
	_delay_ms(500);

	//----------------------
	//static FILE mystdout = FDEV_SETUP_STREAM(N11_PrintChar, NULL, _FDEV_SETUP_WRITE);
  //stdout = &mystdout;
	
	N11_CLS();
	
	//----------------------
	Splash();
	BUZZER(OK_sign);

	//------------
	sei();												//Interrupts enabel	
}	//Initial

void Splash(void)
{
	static char *SPchar[5] = {
			"  SPWM test!!!",
			"by :",
			"Sh. Nourbakhsh",
			"Copyright:",
			"    OZHAN KD"
			};

	//-------------
	StringAt(0, 2, SPchar[0]);
	StringAt(2, 2, SPchar[1]);
	StringAt(3, 2, SPchar[2]);
	StringAt(5, 2, SPchar[3]);
	StringAt(6, 2, SPchar[4]);

	//-------------
	_delay_ms(3000);
	N11_CLS();
}	//Splash


//---------------------------------------------------------//
//---------------------------------------------------------//
void test01(void)
{
	unsigned char				LVflag 	= 0;
	unsigned int				TCRtemp = 0;
	unsigned char				i 			= 0;

	unsigned int				FRQtemp;
	unsigned char				ACCtemp;
	unsigned char				DECtemp;

	SPWM_init();
	
	ADC_CH_init(FRQ_ACH);
	ADC_CH_init(ACC_ACH);
	ADC_CH_init(DEC_ACH);
	
	//----- main loop!
	while(1)
	{		
		if(TCounter>=TCRtemp)									//100mS
		{
			TCRtemp = TCounter +100;						//1mS x100
			
			FRQtemp = a2dConvert10bit(FRQ_ACH);
			ACCtemp = a2dConvert8bit(ACC_ACH);
			DECtemp = a2dConvert8bit(DEC_ACH);
			
			//-------------------------------
			FRQtemp = SetFrequency(FRQtemp);
			ACCtemp = SetAcceleration(ACCtemp);
			DECtemp = SetDeceleration(DECtemp);
	
			//-------------------------------
			sprintf(Ctemp, "FRQ: %03d.%01d Hz ", (FRQtemp/10), (FRQtemp%10));
			StringAt(1, 2, Ctemp);
			
			sprintf(Ctemp, "ACC: %03d sec ", ACCtemp);
			StringAt(3, 2, Ctemp);
	
			sprintf(Ctemp, "DEC: %03d sec ", DECtemp);
			StringAt(5, 2, Ctemp);

			i++;
			if(i==5)					{						LVflag = 1;		}
			else if(i==10)		{	i = 0;		LVflag = 0;	}
		}
		
		GLED(LVflag);
		//_delay_ms(200);
	}//while
} //test01
