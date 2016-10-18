//Date: Tue, 3 Nov 1998 20:38:24 -0200

import java.awt.*;
import java.applet.Applet;

public class Cores extends java.applet.Applet
{
	Scrollbar Vermelho=new Scrollbar(Scrollbar.HORIZONTAL,0,1,0,255);
	Scrollbar Verde   =new Scrollbar(Scrollbar.HORIZONTAL,0,1,0,255);
	Scrollbar Azul    =new Scrollbar(Scrollbar.HORIZONTAL,0,1,0,255);

	Button AtualizadorCor;
	int ValorVermelho, ValorVerde, ValorAzul;
	
	public void init()
	{
		resize(500,350);
		valores();
	}

	public void valores()
	{
		add(new Label("vermelho: "));
		add(Vermelho);
		add(new Label("verde: "));
		add(Verde);
		add(new Label("azul: "));
		add(Azul);
		
		add(AtualizadorCor=new Button("misturar"));
	}

	public boolean handleEvent(Event EventoMisturar)
	{
	//	if (EventoMisturar.instanceOf(Scrollbar))
//		{
		//	ValorVermelho=(new integer(Vermelho.getText())).intValue();
			ValorVermelho=Vermelho.getValue();
			ValorVerde=Verde.getValue();
			ValorAzul=Azul.getValue();
			
			repaint();
			return true;
////		}
//
//	return super.handleEvent(EventoMisturar);
	}
	
	public void paint(Graphics grafico)
	{
		Color misturar;
		misturar=new Color(ValorVermelho, ValorVerde, ValorAzul);
		grafico.setColor(misturar);
		grafico.fillRect(100,100,250,250);
	}
}	
