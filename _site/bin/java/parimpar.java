// Tue, 2 Jun 1998 23:37:32
// aluno: aurelio marinho jargas
// turma: 3o - Ai

import java.io.*;

class parimpar {
public static void main(String argv[]) 
{
int x;
int par=0, impar=0;
int n=10;
int   pares[] = new int[(n/2)];
int impares[] = new int[(n/2)];

for ( x=1 ; x<=n ; x++ )
if (((x+2)%2) == 0) {
	pares[par]=x;
	par++;
	}
else {
	impares[impar]=x;
	impar++;
	}

for ( x=0 ; x<(n/2) ; x++ ) {
	System.out.println("impar " + impares[x]);
	System.out.println("  par " +   pares[x]);

}  //fim segundo for

}  //fim main
}  //fim classe
