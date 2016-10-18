//Date: Mon, 1 Dec 1997 19:30:53 -0200

import java.applet.Applet;
import java.awt.*;
import java.net.*;
import java.io.*;
import java.awt.event.*;

public class conectar extends Applet implements ActionListener
{
    // declara��o dos objetos da interface
    Image background;
    Label rotulo = new Label("selecione abaixo um dos s�tios sobre java:");
    Choice area= new Choice();
    Button conectar = new Button("conectar");
    public void init()
    {
        //configura��o dos objetos definidos acima
        rotulo.setAlignment(Label.CENTER);
        rotulo.setBackground(new Color (0,255,0));
        rotulo.setForeground(new Color (0,0,0));
        area.addItem("http://www.javasoft.com");
        area.addItem("http://www.uol.com.br/webworld/tecnologia");
        area.addItem("http://clubejava-br.intercorp.com.br");
        add(rotulo);
        add(area);
        add(conectar);
        conectar.addActionListener(this);
        if (getParameter("BGImage") != null)
        {
            //a img de fundo recebe a img definida no par�metro da applet
            background = getImage(getCodeBase(), getParameter("BGImage"));
        }
        else
        {
            //se o par�metro n�o for declarado a img de fundo ser� default.gif
            background = getImage(getCodeBase(), "default.gif");
        }
    }
    public void paint (Graphics g)
    {
        //desenha a img na interface a partir da posi��o x,y respec. 01,01\
        g.drawImage(background,01,01,500,500,new Color(0,255,0),this);
    }
    public void actionPerformed(ActionEvent e)
    {
        String url = new String(area.getSelectedItem());
        try
        {
            URL conectar = new URL(url);
            getAppletContext().showDocument(conectar);
        }
        catch(MalformedURLException erro)
        {
            System.out.println(erro);
        }
    }
}
