// classe aluno

import java.io.*;

class aluno {

private String NOME, MATRICULA;
private float NOTA1, NOTA2, MEDIA;

void MostraMedia()
{
    MEDIA=(NOTA1+NOTA2)/2;
    System.out.println("A média do " + NOME + " é " + MEDIA);
}

public static void main(String argv[])
{
aluno al = new aluno();
al.NOME="miagui";
al.MATRICULA="666";
al.NOTA1=75;
al.NOTA2=100;
al.MostraMedia();

} // fim main
} // fim class
