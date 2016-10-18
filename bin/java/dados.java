// jogo de dados

import java.io.*;

class dados {
public static void main(String argv[])
{
int i,j,x;
int ic=0;
String COMB="";
int d1[]={1,2,3,4,5,6};
int d2[]={1,2,3,4,5,6};
int r[]={2,3,4,5,6,7,8,9,10,11};

for (x=0;x<10;x++)
	{
	ic=0;
	for (i=0;i<6;i++)
		for (j=0;j<6;j++)
			if ((d1[i]+d2[j])==r[x])
			{
			System.out.println("dado1 = "+d1[i]+"  dado2 = "+d2[j]);
			ic++;
			}
	if (ic==1)
	COMB=" combinação ";
	else
	COMB=" combinações";
   System.out.println("há "+ic+COMB+" de resultado "+r[x]+"\n");
	}
} 
}
