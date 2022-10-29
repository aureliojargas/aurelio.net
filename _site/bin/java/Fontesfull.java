//Date: Mon, 1 Dec 1997 19:30:53 -0200

import java.awt.*;
import java.applet.Applet;

public class Fontesfull extends Applet
{
  Panel p1 = new Panel();
  Panel p2 = new Panel();
  Panel p3 = new Panel();
  Panel p4 = new Panel();
  Panel p5 = new Panel();
  Panel central = new Panel();
  Font fonte = new Font("Arial",Font.PLAIN,14);
  Color cor = new Color(100,100,100);
  Button ok = new Button("     Atualizar     ");
  CheckboxGroup grupocor = new CheckboxGroup();
  CheckboxGroup grupofonte = new CheckboxGroup();
  Checkbox green = new Checkbox("green",grupocor,true);
  Checkbox blue = new Checkbox("blue",grupocor,false);
  Checkbox cyan = new Checkbox("cyan",grupocor,false);
  Checkbox orange = new Checkbox("orange",grupocor,false);
  Checkbox gray = new Checkbox("gray",grupocor,false);
  Checkbox darkGray = new Checkbox("darkGray",grupocor,false);
  TextField tamanho = new TextField("14",4);
  Checkbox arial = new Checkbox("Arial",grupofonte,true);
  Checkbox dialog = new Checkbox("dialog",grupofonte,false);
  Checkbox dialoginput = new Checkbox("dialoginput",grupofonte,false);
  Checkbox monospaced= new Checkbox("Monospaced",grupofonte,false);
  Checkbox serif = new Checkbox("Serif",grupofonte,false);
  Checkbox sansserif = new Checkbox("SansSerif",grupofonte,false);
  Checkbox symbol = new Checkbox("Symbol",grupofonte,false);
  Checkbox italic = new Checkbox("Italic",false);
  Checkbox bold = new Checkbox ("Bold",true);

  Legenda legenda = new Legenda();

  public void init()
  {
   setLayout(new BorderLayout());
   p1.setLayout(new GridLayout(4,2));
   green.setBackground(new Color(200,200,255));
   blue.setBackground(new Color(200,200,255));
   cyan.setBackground(new Color(200,200,255));
   orange.setBackground(new Color(200,200,255));
   gray.setBackground(new Color(200,200,255));
   darkGray.setBackground(new Color(200,200,255));
   p1.add(new Label("Selecione a cor desejada:"));
   p1.add(new Label(""));
   p1.add(green);
   p1.add(blue);
   p1.add(cyan);
   p1.add(orange);
   p1.add(gray);
   p1.add(darkGray);

   p2.setLayout(new GridLayout(5,2));
   p2.add(new Label("Selecione a fonte desejada:"));
   p2.add(new Label(""));
   arial.setBackground(new Color(100,100,250));
   dialog.setBackground(new Color(100,100,250));
   dialoginput.setBackground(new Color(100,100,250));
   monospaced.setBackground(new Color(100,100,250));
   serif.setBackground(new Color(100,100,250));
   sansserif.setBackground(new Color(100,100,250));
   symbol.setBackground(new Color(100,100,250));
   p2.add(arial);
   p2.add(dialog);
   p2.add(dialoginput);
   p2.add(monospaced);
   p2.add(serif);
   p2.add(sansserif);
   p2.add(symbol);

   p3.setLayout(new GridLayout(2,2));
   p3.add(new Label("Estilo da Fonte:"));
   p3.add(new Label(""));
   bold.setBackground(new Color(200,255,200));
   italic.setBackground(new Color(200,255,200));
   p3.add(bold);
   p3.add(italic);

   p4.setLayout(new FlowLayout(FlowLayout.LEFT));
   p4.add(new Label("Digite o tamanho da Fonte:"));
   p4.add(tamanho);

   p5.setLayout(new FlowLayout());
   p5.add(ok);

   central.setLayout(new FlowLayout(FlowLayout.LEFT));
   central.add(p2);
   central.add(p3);
   central.add(p4);

/*   ok.hide();
   green.hide();
   blue.hide();
   cyan.hide();
   orange.hide();
   gray.hide();
   darkGray.hide();
   tamanho.hide();
   arial.hide();
   dialog.hide();
   dialoginput.hide();
   monospaced.hide();
   serif.hide();
   sansserif.hide();
   symbol.hide();
   italic.hide();
   bold.hide();*/

   p1.setBackground(new Color(200,200,255));
   p2.setBackground(new Color(100,100,250));
   p3.setBackground(new Color(200,255,200));
   p4.setBackground(new Color(255,255,200));
   p5.setBackground(new Color(100,200,255));
   central.setBackground(new Color(200,255,100));
   this.setBackground(Color.black);

   add("North",p1);
   add("Center",central);
   add("South",p5);
  }


  public boolean action(Event e, Object args)
  {
   if (e.target == ok)
   {
        if (green.getState())
                ok.setBackground(Color.green);
        else if (blue.getState())
                ok.setBackground(Color.blue);
        else if (cyan.getState())
                ok.setBackground(Color.cyan);
        else if (orange.getState())
                ok.setBackground(Color.orange);
        else if (gray.getState())
                ok.setBackground(Color.gray);
        else if (darkGray.getState())
                ok.setBackground(Color.darkGray);

      int estilo = 0;
      if (bold.getState())
         estilo = Font.BOLD;
      if (italic.getState())
         estilo += Font.ITALIC;

        fonte = new Font(grupofonte.getSelectedCheckbox().getLabel(),estilo,Int
eger.valueOf(tamanho.getText()).intValue());
        ok.setFont(fonte);
   }
   return true;
  }
  public void start()
  {
    legenda.show();
  }
  public void stop()
  {
    legenda.hide();
  }
}
