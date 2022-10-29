//Date: Tue, 3 Nov 1998 20:38:16 -0200

import java.awt.*;
import java.applet.*;

public class Aula3 extends Applet
{
	TextField nome = new TextField(20);
	CheckboxGroup sexo = new CheckboxGroup();
	Checkbox m = new Checkbox("masc", sexo, true);
	Checkbox f = new Checkbox("fem", sexo, false);
	Choice est = new Choice();
	TextArea c = new TextArea(5,30);
	Button ok = new Button("ok");
	Button can = new Button("cancela");

	public void init()
	{
		add(new Label("nome: "));
		add(nome);
		add(new Label("sexo: "));
		add(m);
		add(f);
		add(new Label("estado: "));
		est.addItem("pr");
		est.addItem("mg");
		add(est);
		add(c);
		add(ok);
		add(can);
	}
}
