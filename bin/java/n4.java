// Wed Sep 16 20:57:48 WST 1998
// aluno: aurelio marinho jargas
// turma: 4o 
// declarar salarios na matriz
//
// prof. talvez eu não tenha entendido bem o proposto,
// o que fiz foi um programa que testa o valor do
// salário e o armazena numa posição da matriz própria
// para cada porcentagem.
//    matriz[0] = 25%
//    matriz[1] = 20%
//    matriz[2] = 10%
//    matriz[3] =  5%

import java.io.*;

class n4 {
public static void main(String argv[]) 
{
int x;
float SALARIO=900;
float matriz[] = new float[4];

if ( SALARIO < 500.00 )
matriz[0]=SALARIO;
else
if ( SALARIO < 1000.00 )
matriz[1]=SALARIO;
else
if ( SALARIO < 1500.00 )
matriz[2]=SALARIO;
else
matriz[3]=SALARIO;

System.out.println("25% -> " + matriz[0]);
System.out.println("20% -> " + matriz[1]);
System.out.println("10% -> " + matriz[2]);
System.out.println(" 5% -> " + matriz[3]);

}  //fim main
}  //fim classe
