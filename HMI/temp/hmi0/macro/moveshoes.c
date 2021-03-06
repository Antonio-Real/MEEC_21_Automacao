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
		int inc = 10;
		int type = 3;

		
		if(shoe == 1)
			type = 1;
		if(boot == 1)
			type = 2;
		if(highBoot == 1)
			type = 3;
		
		

	if (shoesMade == 1)
	{
		s1_type = type;
		s1 += inc;
	}
	else if (shoesMade == 2)
	{
		s2_type = type;
		s1 += inc;
		s2 += inc;
	}
	else if (shoesMade == 3)
	{
		s3_type = type;
		s1 += inc;
		s2 += inc;
		s3 += inc;
	}
	else if (shoesMade == 4)
	{	
		s4_type = type;
		s1 += inc;
		s2 += inc;
		s3 += inc;
		s4 += inc;
	}
	else if (shoesMade == 5)
	{
		s5_type = type;
		s1 += inc;
		s2 += inc;
		s3 += inc;
		s4 += inc;
		s5 += inc;
	}
	else 
	{
		s1 += inc;
		s2 += inc;
		s3 += inc;
		s4 += inc;
		s5 += inc;
	}


	if(s1 > 250) {
		if((quantity - shoesMade) <= 5)
			s1_type = 0;
		
		s1 = 2;
		stop_belt = 1;
	}

	if(s2 > 250){
		if((quantity - shoesMade) <= 5)
			s2_type = 0;
		
		s2 = 2;
		stop_belt = 1;
	}

	if(s3 > 250){
		if((quantity - shoesMade) <= 5)
			s3_type = 0;
		
		s3 = 2;
		stop_belt = 1;
	}

	if(s4 > 250){
		if((quantity - shoesMade) <= 5)
			s4_type = 0;
		
		s4 = 2;
		stop_belt = 1;
	}

	if(s5 > 250){
		if((quantity - shoesMade) <= 5)
			s5_type = 0;
		
		s5 = 2;
		stop_belt = 1;
	}
	

	return 0;
}
 