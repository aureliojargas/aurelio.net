// classe disciplina

import java.io.*;

class disciplina {

private String NOME, CODIGO, PROFESSOR;

void MostraProfessor()
{
    System.out.println("O prof. da matéria \"" + CODIGO + "-" + NOME +
    "\" é " + PROFESSOR);
}

public static void main(String argv[])
{
disciplina dis = new disciplina();
dis.NOME="TAP";
dis.CODIGO="666";
dis.PROFESSOR="Edmar";
dis.MostraProfessor();

} // fim main
} // fim class
