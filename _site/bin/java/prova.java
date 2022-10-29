// calculadora simples

import java.io.*;

class prova {
public static void main(String argv[])
{
int num1,num2,op;
float res=0;


num1=Integer.parseInt(argv[0]);
num2=Integer.parseInt(argv[1]);
op=Integer.parseInt(argv[2]);
//num2=argv[1];
//op=argv[2];

if ( op == 1 )
   res=num1+num2;
else if ( op == 2 )
        res=num1/num2;
     else if ( op == 3 )
             res=num1*num2;
          else if ( op == 4 )
                  res=num1-num2;

System.out.println("O resultado e': " + res);

} // fim main
} // fim class
