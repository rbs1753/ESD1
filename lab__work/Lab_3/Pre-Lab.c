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

uint32* TimerPtr    = (uint32*)TIMER_0_BASE;


//All Base values are from the system.h file!
unsigned char* LedPtr        =    (unsigned char*)LEDS_BASE;
unsigned char* HexPtr        =    (unsigned char*)HEX0_BASE;
unsigned char* KeyPtr        =    (unsigned char*)PUSHBUTTONS_BASE;
unsigned char* SwitchPtr     =    (unsigned char*)SWITCHES_BASE;

unsigned char  hexValues[10] = {0x40, 0x79, 0x24, 0x30, 0x19, 0x12, 0x02, 0x78, 0x00, 0x18}; //SSD values for 0-9

int main(void){
	unsigned char key_val;     //Push button pointer value
	unsigned char switch_val;  //Switch pointer value
	unsigned short arrayIDX = 0;;   //Array index to iterate

	*HexPtr = hexValues[0]; //Initialize the SSD to 0


	while(1){
		key_val = *KeyPtr;
		switch_val = *SwitchPtr;
		if((key_val & 0x02) == 0){
			while((key_val & 0x02) == 0){
				key_val = *KeyPtr;
				if((key_val & 0x02) == 1) break;
			} //infinite loop to wait for button release.
			switch(switch_val){
		      case 0x00:
		    	  if(arrayIDX == 0){
		    		  break;
		    	  }
		    	  else {
		    		  arrayIDX--;
		    		  *HexPtr = hexValues[arrayIDX];
		    	  }
		    	  break;

		      case 0x01:
		    	  if(arrayIDX == 9){
		    		  break;
		    	  }
		    	  else {
		    		  arrayIDX++;
		    		  *HexPtr = hexValues[arrayIDX];
		    	  }
		    	  break;
			}
		}
	}//While
	return 0;
}//Main
