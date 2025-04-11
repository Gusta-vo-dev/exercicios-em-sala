Program Pzim ;

		var he, me, hs, ms, tempo, tempo_ent, tempo_sai, hora_fab, min_fab: integer

Begin
   writeln ('Informe hora e minuto de entrada');
   readln (he, me);
   writeln ('Informe hora e minutos de saída');
   readln ('hs, ms');
   tempo_ent:= he*60-me;
   tempo_sai:=hs*60-ms;
   tempo:=tempo_sai-tempo_ent;
   hora_fab:=tempo div 60;
   min_fab:=tempo-hora_fab*60;
   writeln ('horas fabrica: ',hora_fab);
   writeln ('minuto fabrica: ',min_fab);
End.