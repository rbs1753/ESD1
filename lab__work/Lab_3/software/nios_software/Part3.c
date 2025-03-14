/*
 * main.c
 *
 *  Created on: Feb 12, 2025
 *      Author: rbs1753
 */

#include "io.h"
#include <stdio.h>
#include "system.h"
#include "alt_types.h"
#include "sys/alt_irq.h"
#include "altera_avalon_timer_regs.h"
#include "altera_avalon_timer.h"

// create standard embedded type definitions
typedef   signed char   sint8;              // signed 8 bit values
typedef unsigned char   uint8;              // unsigned 8 bit values
typedef   signed short  sint16;             // signed 16 bit values
typedef unsigned short  uint16;             // unsigned 16 bit values
typedef   signed long   sint32;             // signed 32 bit values
typedef unsigned long   uint32;             // unsigned 32 bit values
typedef         float   real32;             // 32 bit real values


//set up pointers to peripherals

uint32* TimerPtr    =  (uint32*)TIMER_0_BASE;
uint32* KeyIRQ       = (uint32*)PUSHBUTTONS_BASE;


//All Base values are from the system.h file!
unsigned char* LedPtr        =    (unsigned char*)LEDS_BASE;
unsigned char* HexPtr        =    (unsigned char*)HEX0_BASE;
unsigned char* KeyPtr        =    (unsigned char*)PUSHBUTTONS_BASE;
unsigned char* SwitchPtr     =    (unsigned char*)SWITCHES_BASE;


//Define the constant to write to interrupt register
#define Interrupt_offset 2
#define Interruptmask    3

unsigned char  hexValues[10] = {0x40, 0x79, 0x24, 0x30, 0x19, 0x12, 0x02, 0x78, 0x00, 0x18}; //SSD values for 0-9


void pushbutton_isr(void *context)
/**********************************************************************/
/* Push Button Interrupt Service Routine                              */
/* Will check the value of the switches and add or subtract as needed */
/*                                                                    */
/**********************************************************************/
{
    static unsigned short arrayIDX = 0;
    unsigned char switch_val = *SwitchPtr;
    switch(switch_val){
      case 0x00:
	    if(arrayIDX == 0){
		  break;
		}
		else {
	      arrayIDX = arrayIDX - 1;
		  *HexPtr = hexValues[arrayIDX];
		}
		break;

        case 0x01:
		  if(arrayIDX == 9){
		    break;
		  }
		  else {
		    arrayIDX = arrayIDX + 1;
		    *HexPtr = hexValues[arrayIDX];
		  }
		  break;
	}
    *(KeyIRQ + Interruptmask) &= ~0x02;
}

void timer0_isr (void)
/**********************************************************************/
/* Timer 0 Interrupt Service Routine                                  */
/* Will update LEDs each time isr is entered                          */
/*                                                                    */
/**********************************************************************/
{
    unsigned char current_val = 0;
	*TimerPtr = 0;

    current_val = *LedPtr; /* read the leds */
    
    *LedPtr = current_val + 1;  /* change the display */
}
void main(void){
	*HexPtr = hexValues[0]; //Initialize the SSD to 0
	*(KeyIRQ + Interrupt_offset) |= 0x02;
	*(TimerPtr + Interrupt_offset) |= 0x02;

    alt_ic_isr_register(PUSHBUTTONS_IRQ_INTERRUPT_CONTROLLER_ID,PUSHBUTTONS_IRQ,pushbutton_isr,0,0);
    alt_ic_isr_register(TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID,TIMER_0_IRQ,timer0_isr,0,0);

	while(1);//While

}//Main
