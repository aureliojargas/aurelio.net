import java.io.*;
class estoque {
public static void main(String argv[]) {
int QtdRec=60, VlrNf=420, VlrUni;
int QtdEst=90, VlrEst, CustMed=6;
int QtdTot;
float NovCm=0;

VlrUni=VlrNf/QtdRec;
VlrEst=QtdEst*CustMed;
QtdTot=QtdRec+QtdEst;
NovCm=(VlrEst+VlrNf)/QtdTot;

System.out.println("Quantidade atual em estoque: " + QtdTot);
System.out.println("  Novo custo medio unitario: " + NovCm);
 
}
}


