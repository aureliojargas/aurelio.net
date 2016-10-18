// aluno: aurelio marinho jargas
// turma: 3o - Ai

import java.io.*;

class p2 {
public static void main(String argv[]) 
{
int H=36, M=10;
int CustoRefri=1, CustoCerveja=1;
int CadaMtomaRefri=3, CadaMtomaCerveja=2;
int CadaHtomaRefri=5, CadaHtomaCerveja=6;
int TotalMtomaRefri, TotalHtomaRefri;
int TotalMtomaCerveja, TotalHtomaCerveja;
int TotalRefriM, TotalRefriH;
int TotalCervejaM, TotalCervejaH;
int TotalRefri, TotalCerveja;
int CustoTotalRefri, CustoTotalCerveja;

TotalMtomaRefri=(M/2);
TotalHtomaRefri=H/3;
TotalMtomaCerveja=M/2;
TotalHtomaCerveja=(H*2)/3;
TotalRefriM=TotalMtomaRefri*CadaMtomaRefri;
TotalRefriH=TotalHtomaRefri*CadaHtomaRefri;
TotalCervejaM=TotalMtomaCerveja*CadaMtomaCerveja;
TotalCervejaH=TotalHtomaCerveja*CadaHtomaCerveja;
TotalRefri=TotalRefriM+TotalRefriH;
TotalCerveja=TotalCervejaM+TotalCervejaH;
CustoTotalRefri=TotalRefri*CustoRefri;
CustoTotalCerveja=TotalCerveja*CustoCerveja;

System.out.println("   total de refri pra comprar: " + TotalRefri);
System.out.println("total de cervejas pra comprar: " + TotalCerveja);
System.out.println("        custo total com refri: " + CustoTotalRefri);
System.out.println("     custo total com cervejas: " + CustoTotalCerveja);

}  //fim main
}  //fim classe
