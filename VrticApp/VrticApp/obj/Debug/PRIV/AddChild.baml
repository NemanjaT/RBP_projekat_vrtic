   M S B A M L   `   `   `  ����C  ?VrticApp, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null#clr-namespace:VrticAppVrticApp  5   	       VrticApp.AddChild   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   (localclr-namespace:VrticApp     5   	   -   5          �Name$  	AddChild1��5   	    � Title$ AddChild��5	   	   $��516.05��6   $��422.5��6*   .��5
      � .+�5   
   �� -   5         ��Name$ label��5      $��Unesite podatke o detetu��6   $
��Left=�6B   $��	10,10,0,0q�6]   $	��Top=�6p   �� 5   
   -   5        $ label1��5      $
��Ime:��6    $
��Left=�6/   $��	10,41,0,0q�6J   $	��Top=�6]   �� 5   
   -   5        $ label2��5      $��Prezime:��6    $
��Left=�63   $��
135,41,0,0q�6N   $	��Top=�6b   �� 5   
   -   5        $ label2_Copy��5      $��Datum rođenja:��6%   $
��Left=�6>   $��
260,41,0,0q�6Y   $	��Top=�6m   �� 5   
   -   5         ��Name$ txtName��5      $
��Left=�6#   $��23��6>   $��	10,72,0,0q�6J    �� TextWrapping$
 Wrap=�6]   $	��Top=�6q   $��96��6�   �� 5   
   -   5        $ txtLastName��5      $
��Left=�6'   $��23��6B   $��
135,72,0,0q�6N   $
 Wrap=�6b   $	��Top=�6v   $	��120��6�   (  "System.Windows.Controls.DatePicker  5   
   -   5          Name$ 
datePicker��5      $
��Left=�6)   $��
268,72,0,0q�6D   $	��Top=�6X   $	��120��6p   �� 5   
   -	   5         ��Name$ btnAdd��5      $��DODAJ��6!   $
��Left=�61   $��220,239,0,0q�6L   $	��Top=�6a   $��74��6y   6�   �� 5   
   -
   5        $ btnBack��5      $��NAZAD��6"   $
��Left=�62   $��330,455,0,0q�6M   $	��Top=�6b   $��74��6z   6�   �� 5   
   -   5        $ label3��5      $��	ID grupe:��6    $
��Left=�64   $��
10,109,0,0q�6O   $	��Top=�6c   �� 5   
   -   5        $ 
txtGroupId��5      $
��Left=�6&   $��24��6A   $��
10,140,0,0q�6M   $
 Wrap=�6a   $	��Top=�6u   $��59��6�   �� 5   
   -   5        $ label4��5      $��Dodatne informacija��6    $
��Left=�6>   $��117,109,0,0q�6Y   $	��Top=�6n   �� 5   
   -   5        $ txtInfo��5      $
��Left=�6#   $��82��6>   $��117,140,0,0q�6J   $
 Wrap=�6_   $�� ��6s   $	��Top=�6{   $	��267��6�    J� RenderTransformOrigin$ 0.5,0.5&�6�   .��6�   z�5      V� 5      .~�5      �� �� 5       �� AngleY$ 0.108Q�6$   �� 5      T� 5      	 T� Y$	 0.248Q�6)   5      .��5   '   5       �� 5!   
   -   5        $ label5��5!      $��
Ime grupe:��6    $
��Left=�65   $��
10,271,0,0q�6P   $	��Top=�6d   �� 5"   
   -   5        $ label6��5"      $��Sprat:��6    $
��Left=�61   $��150,271,0,0q�6L   $	��Top=�6a   �� 5#   
   -   5        $ label7��5#      $��Vaspitači:��6    $
��Left=�65   $��
10,336,0,0q�6P   $	��Top=�6d   �� 5$   
   -   5        $ label6_Copy��5$      $��Cena:��6%   $
��Left=�65   $��260,271,0,0q�6P   $	��Top=�6e   $��44��6}   �� 5%   
   -   5        $ txtTeachers��5%      $
��Left=�6'   $��83��6B   $��
10,367,0,0q�6N   $
 Wrap=�6b   $	��Top=�6v   $	��342��6�   �� 5&   
   -   5        $ txtGroupFloor��5&      $
��Left=�6)   $��23��6D   $��150,302,0,0q�6P   $
 Wrap=�6e   $	��Top=�6y   $��40��6�   �� 5'   
   -   5        $ txtGroupPrice��5'      $
��Left=�6)   $��23��6D   $��260,302,0,0q�6P   $
 Wrap=�6e   $	��Top=�6y   $��92��6�   �� 5)   
   -   5        $ btnAddGroup��5)      $��DODAJ��6&   $
��Left=�66   $��220,455,0,0q�6Q   $	��Top=�6f   $��74��6~   6�   �� 5*   
   -   5        $ txtGroupName��5*      $
��Left=�6(   $��23��6C   $��
10,302,0,0q�6O   $
 Wrap=�6c   $	��Top=�6w   $	��126��6�   5,      5-      