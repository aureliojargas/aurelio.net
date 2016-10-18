// aluno: aurelio marinho jargas
// turma: 3o - Ai

import java.io.*;

class p1 {
public static void main(String argv[]) 
{
int $DIN_DISP=235, $SALDO_MIN=65, $DIN_TOTAL, $REDUCAO=60;
int $PRES_M=100, $PRES_H=100, $GASTO_CHOPP=100;
int $PERFUME=0, $GRAVATA=0, $CHOPP=0;
int $GASTO_M=0, $GASTO_H=0, $GASTO_TOTAL=0;
int $M=4, $H=6, $P=1;
int $SALDO=70;

if ( $SALDO < $SALDO_MIN )
{
System.out.println("\nsaldo insuficiente  -  NAO SACA DINHEIRO");
System.out.println("----------------------------------------");
$DIN_TOTAL=$DIN_DISP;
$PRES_M=($PRES_M * $REDUCAO) / 100;
$PRES_H=($PRES_H * $REDUCAO) / 100;
$GASTO_CHOPP=$DIN_TOTAL - $PRES_M - $PRES_H;
}
else { 
System.out.println("\nsaldo suficiente  -  SACA O DINHEIRO");
System.out.println("----------------------------------------");
$DIN_TOTAL=$DIN_DISP + $SALDO_MIN;
}

$PERFUME=$PRES_M / $M;
$GRAVATA=$PRES_H / $H;
$CHOPP=$GASTO_CHOPP / ($M+$H+$P);

$GASTO_M=$PERFUME + $CHOPP;
$GASTO_H=$GRAVATA + $CHOPP;
$GASTO_TOTAL=(($GASTO_M * $M) + ($GASTO_H * $H) + ($CHOPP * $P)); 

System.out.println("grana que o professor tem=" + $DIN_TOTAL);
System.out.println("gasto total com o perfume=" + $PRES_M);
System.out.println("gasto total com a gravata=" + $PRES_H);
System.out.println("gasto total com o   chopp=" + $GASTO_CHOPP);
System.out.println("numero total de  mulheres=" + $M);
System.out.println("numero total de    homens=" + $H);
System.out.println("gasto  com  cada  perfume=" + $PERFUME);
System.out.println("gasto  com  cada  gravata=" + $GRAVATA);
System.out.println("gasto  com  cada    chopp=" + $CHOPP);
System.out.println("gasto total c/cada mulher=" + $GASTO_M);
System.out.println("gasto total c/cada  homem=" + $GASTO_H);
System.out.println("gasto total do  professor=" + $GASTO_TOTAL);
}  //fim main
}  //fim classe
