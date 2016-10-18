// calculadora simples

import java.io.*;
 
class calc {
public static void main(String argv[])
{
int num1,num2,op;
float res=0;

num1=Integer.parseInt(argv[0]);
num2=Integer.parseInt(argv[1]);
op=Integer.parseInt(argv[2]);

if ( op == 1 )
   res = calcula.soma(num1,num2);
else if ( op == 2 )
  		  res = calcula.subtrai(num1,num2);
     else if ( op == 3 )
             res = calcula.divide(num1,num2);
          else if ( op == 4 )
                  res =calcula.multiplica(num1,num2);

System.out.println("o resultado é: " + res);

} // fim main
} // fim class
