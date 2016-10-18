//Date: Mon, 1 Dec 1997 19:30:53 -0200

//botão transparente
//cor de fundo
// textarea não editável

import java.awt.*;
import java.applet.*;

public class cadusu extends Applet 
{
    TextField fnome = new TextField("mala",20);
    Checkbox c = new Checkbox("c++");
    Checkbox java = new Checkbox("java",true);

    CheckboxGroup sexo = new CheckboxGroup();
    Checkbox masc = new Checkbox("masculino",sexo,true);
    Checkbox fem = new Checkbox("feminino",sexo,false);

    Choice estado = new Choice();
    TextArea t = new TextArea(5,40);

    Button ok = new Button("ok");

    public void init()
    {  
    t.setEditable(false); 
    ok.setVisible(false);
    this.setBackground(new Color(10,255,125));
    estado.setBackground(new Color(10,0,255));

     estado.addItem("pr");
     estado.addItem("mg");
     estado.addItem("sp");
     add(new Label("nome: "));
     add(fnome);
     add(new Label("linguagem: "));
     add(java);
     add(c);
     add(new Label("sexo: "));
     add(masc);
     add(fem);
     add(estado);
     add(t);
     add(ok);
    }
}
