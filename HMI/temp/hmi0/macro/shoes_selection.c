#include "macrotypedef.h"
#include "math.h"

/*
	Read,Write Local address function:
  	int ReadLocal( const char *type, int addr, int nRegs, void *buf, int flag  );
	int WriteLocal( const char *type, int addr, int nRegs, void *buf , int flag );

	Parameter:     type     is the string of "LW","LB" etc;
								address is the Operation address ;
 								nRegs    is the length of read or write ;
								buf        is the buffer which store the reading or writing data;
 								flag       is 0,then codetype is BIN,is 1  then codetype is BCD;
	return value : 1  ,Operation success
 								0,  Operation fail.

 	eg: read the value of local lw200 and write it to the lw202,with the codetype BIN,
		The code is :

    	short buf[2] = {0};
		ReadLocal("LW", 200, 2, (void*)buf, 0);
		WriteLocal("LW", 202, 2, (void*)buf, 0);
*/
int MacroEntry()
{
	/*counter++;
	if (shoe == 1) 
	{
		boot=0;
		high_boot=0;
	}
	else if (boot == 1) 
	{
		shoe = 0;
		high_boot=0;
	}
	else if (high_boot ==1)
	{
		shoe = 0;
		boot=0;
	}
	else 
	{
		//shoe =0;
		//boot =0;
		//high_boot=0;
	}*/

	//selecionar se ? shoe, boot ou high boot
	//s1 = s1 + 10;					/*Movimiento de la caja FW*/
	//if (s1 >= 240)						/*Si la posici?n de la caja es mayor que 540, que vaya al comienzo*/
	//	{
	//	s1 =0;
	//	}

	/*s1_type = 1;
	s2_type = 1;
	s3_type = 1;
	s4_type = 1;
	s5_type = 1;*/
	
	if (steps_counter == 1)
	{
		s1_type = 1;
	}
	else if (steps_counter == 2)
	{
		s1_type = 1;
		s1 = 95;
		s2_type = 1;
	}
	else if (steps_counter == 3)
	{
		s1_type = 1;
		s1 = 161;
		s2_type = 1;
		s2 = 95;
		s3_type = 1;
	}
	else if (steps_counter == 4)
	{	
		s1_type = 1;
		s1 = 220;
		s2_type = 1;
		s2 = 161;
		s3_type = 1;
		s3 = 95;
		s4_type = 1;
	}
	else if (steps_counter == 5)
	{
		s1_type = 1;
		s1 = 275;
		s2_type = 1;
		s2 = 220;
		s3_type = 1;
		s3 = 161;
		s4_type = 1;
		s4 = 95;
		s5_type = 1;
	}
	else 
	{
		
	} 

return 0;
}
 