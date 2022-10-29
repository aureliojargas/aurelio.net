// sex set 11 20:03:02 EST 1998
// aluno: aurelio marinho jargas
// turma: 4o 
// declarar matriz, imprimir ímpares

import java.io.*;

class n2 {
public static void main(String argv[]) 
{
int x,n=9;
int numeros[] = { 1,2,3,4,5,6,7,8,9,10 };

for ( x=0 ; x<=n ; x++ )
if (((numeros[x]+2)%2) != 0) {
System.out.println(numeros[x]); }

}  //fim main
}  //fim classe
