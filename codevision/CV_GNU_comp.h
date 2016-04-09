//-----------------------------------------------------------------------------
// Copyright:      RAD Electronic Co. LTD,
// Author:         Sh. Nourbakhsh Rad
// Remarks:        
// known Problems: none
// Version:        1.2.0
// Description:    GNUC and CODEVISIONAVR interrupt vectors compatibility (note: program base = GNUC)
//								 
//								 Now only for ATmega8, ATmega16 and ATmega32 !!!
//															ATmega64 and ATmega128 !!!
//-----------------------------------------------------------------------------

#ifndef _GNUCOMP_H_
	#define _GNUCOMP_H_

	//				 GNUC											 CODEVISIONAVR
	//                                  	
	#define INT0_vect												EXT_INT0
	#define INT1_vect												EXT_INT1
	#define INT2_vect												EXT_INT2
	#define INT3_vect												EXT_INT3
	#define INT4_vect												EXT_INT4
	#define INT5_vect												EXT_INT5
	#define INT6_vect												EXT_INT6
	#define INT7_vect												EXT_INT7
	                                    	
	#define TIMER2_COMP_vect								TIM2_COMP
	#define TIMER2_OVF_vect									TIM2_OVF
	                                    	
	#define TIMER1_CAPT_vect								TIM1_CAPT
	#define TIMER1_COMPA_vect								TIM1_COMPA
	#define TIMER1_COMPB_vect								TIM1_COMPB
	#define TIMER1_OVF_vect									TIM1_OVF
	                                    	
	#define TIMER0_COMP_vect								TIM0_COMP
	#define TIMER0_OVF_vect									TIM0_OVF
	                                    	
	#define SPI_STC_vect										SPI_STC
	                                    	
	#define USART0_RX_vect									USART0_RXC
	#define USART0_UDRE_vect								USART0_DRE
	#define USART0_TX_vect									USART0_TXC
	                                    	
	#define ADC_vect												ADC_INT
	#define EE_READY_vect										EE_RDY
	#define ANALOG_COMP_vect								ANA_COMP
	                                    	
	#define TIMER1_COMPC_vect								TIM1_COMPC
	#define TIMER3_CAPT_vect								TIM3_CAPT
	#define TIMER3_COMPA_vect								TIM3_COMPA
	#define TIMER3_COMPB_vect								TIM3_COMPB
	#define TIMER3_COMPC_vect								TIM3_COMPC
	#define TIMER3_OVF_vect									TIM3_OVF
	                                    	
	#define USART1_RX_vect									USART1_RXC
	#define USART1_UDRE_vect								USART1_DRE
	#define USART1_TX_vect									USART1_TXC
	                                    	
	#define TWI_vect												TWI
	#define SPM_READY_vect									SPM_RDY

	
	//----------------------------------------------------------
	//----------------------------------------------------------
	#ifndef ISR(vec)
		#define ISR(vec)             	        interrupt [vec] void isr##vec(void)
	#endif


	//------  mega8, mega16, mega32, mega32A
	#if	defined(_CHIP_ATMEGA8_)  || defined(_CHIP_ATMEGA16_)  || \
			defined(_CHIP_ATMEGA32_) || defined(_CHIP_ATMEGA32A_)
	
		#undef UDR0
				
		#pragma used+
			sfrw ICR1 													= 0x26;
		#pragma used-
	

	//------  mega64, mega128
	#elif	defined(_CHIP_ATMEGA64_) || defined(_CHIP_ATMEGA128_)
	
		#define OCR1C 												(*(unsigned int *) 0x78)
		#define OCR3A 												(*(unsigned int *) 0x86)


	//------  MCU not supported!
	#else		
		#error "sorry dude, not support your MCU yet!!!"
	
	#endif

#endif //_GNUCOMP_H_
