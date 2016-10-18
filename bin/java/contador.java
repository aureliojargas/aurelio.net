//Date: Mon, 1 Dec 1997 19:30:53 -0200

import java.awt.*;

class contador extends Frame
{
	int cont;
	Button bstart,bstop;
	TextField result;

	public contador()
	{
	super("título");
	bstart = new Button("Start");
	bstop  = new Button("Stop");	
	result = new TextField(10);

	add(bstart);
	add(bstop);
	add(result);
	setLayout(new FlowLayout());
	}

	public static void main(String a[])
	{
	contador r = new contador();
	r.setSize(300,300);
	//r.setSize();
	r.show();
	}
}
