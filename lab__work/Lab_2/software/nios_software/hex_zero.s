# ---------------------------------------------------------------
# Assembly language program that displays a 0 on hex displays
# and displays it on the LEDs.
# ---------------------------------------------------------------

.text

# define a macro to move a 32 bit address to a register

.macro MOVIA reg, addr
  movhi \reg, %hi(\addr)
  ori \reg, \reg, %lo(\addr)
.endm


#Hex constant value for 0 0x40
#Hex constant value for 1 0x79
#Hex constant value for 2 0x24
#Hex constant value for 3 0x30
#Hex constant value for 4 0x19
#Hex constant value for 5 0x12
#Hex constant value for 6 0x02
#Hex constant value for 7 0x78
#Hex constant value for 8 0x00
#Hex constant value for 9 0x18

# define constants
.equ Switches, 0x11020    #find the base address of Switches in the system.h file
.equ Keys,     0x11010    #find the base address of Keys in the system.h file
.equ Hex0,     0x11000    #find the base address of Keys in the system.h file
.equ H, (Hend-Hstart)/4

Hstart:
          .byte 0x40, 0x79, 0x24, 0x30, 0x19, 0x12, 0x02, 0x78, 0x00, 0x18
Hend:

#Define the main program
.global main
main: 	#load r2, r3, r4 with the addresses
  movia r2, Switches
  movia r3, Keys
  movia r4, Hex0
  movia r5, Hstart #Iterator
  movia r6, Hstart #Start Position of array, Hex 0
  addi r7, r6, 9   #End Position of array, Hex 9
  addi r14, r0, 0xC0 #Display 0 at the start
  stbio r14, 0(r4) #Write the value of the Hex Display to 0 at base 
  
  



loop: 	#set 
  ldbio r13, 0(r3) #Load the value of the buttons
  andi r13, r13, 2 #And masks the button vector and checks for a key 1 press
  
  beq r13, r0, press
  bne r13, r0, loop
  
  
  
  br    loop #Just in case something weird happens
  
  press:
  ldbio r13, 0(r3) #Load the value of the buttons
  andi r13, r13, 2 #And masks the button vector and checks for a key 1 press
  bne r13, r0, release #Checks to see if the button has been released, it would be not equal to 0 anymore
  beq r13, r0, press
  
  br press


  release:
  ldbio r12, 0(r2) #Load the value of the switches
  andi r12, r12, 1 #Bit mask for checking if SW1 is high
  bne r12, r0, addC
  beq r12, r0, subC
  br release
  
  

  addC:
  	beq r5, r7, wrapD #Should r5 be equal to the last index of H, just display the same number
    addi r5, r5, 1
    br display
  
  
  subC:
  	beq r5, r6, wrapU #Should r5 be equal to the first index of H, just display the same number
    subi r5, r5, 1
    br display

  wrapD:
    subi r5, r5, 9
    br display

  wrapU:
    addi r5, r5, 9
    br display

  display:
    ldbio r14, 0(r5) #Display the current vector location
    stbio r14, 0(r4) #Write the value of the array at its current index
    br loop
    
.end

    
  

