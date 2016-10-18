// classe professor

import java.io.*;

class professor {

private String NOME, IDADE, ENDERECO;
private int CARGA_HOR;

void AumentaCarga()
{
    CARGA_HOR++;
}

public static void main(String argv[])
{
professor prof = new professor();
prof.NOME="edmar";
prof.IDADE="nao sei";
prof.ENDERECO="sei la";
prof.CARGA_HOR=40;

if ( prof.CARGA_HOR < 50 )
{
    prof.AumentaCarga();
    System.out.println("O professor "+prof.NOME+" faz "+prof.CARGA_HOR+ 
" horas/aulas.");
}

} // fim main
} // fim class
