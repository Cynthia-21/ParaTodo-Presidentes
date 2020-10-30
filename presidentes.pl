periodo(alfonsin, 1983, 1989, democracia).
periodo(menem, 1990, 1995,convertibilidad).
periodo(menem, 1996, 1999,desocupacion).
periodo(delarua, 2000,2001,helicoptero).

acto(juicio, 1985, bsas, 30000000).
acto(hiperinflacion, 1989, arg, 10). 
acto(privatizacion, 1992, campana, 1).

%acto(inventado, 1998, arg, 1000000).
%acto(inventado, 1997, arg, 1000000).
%acto(inventado, 1991, arg, 1000000).

presidenteMasDeUnPeriodo(Presi):-
    periodo(Presi,_,_,Periodo1),
    periodo(Presi,_,_,Periodo2),
    Periodo1 \= Periodo2.

quienEsPresidente(Presi,Anio,Periodo):-
    periodo(Presi,Inicio, Fin, Periodo ),
    Anio >= Inicio,
    Fin >= Anio. 


actoBueno(Acto):-
    acto(Acto,_,_,Beneficiados),Beneficiados > 10000.

actoDelPresidente(Presi,Acto,Periodo):-
    acto(Acto,Anio,_,_),
    quienEsPresidente(Presi,Anio,Periodo).


insulso(Presi):-
    periodo(Presi,_,_,_),
    not(actoDelPresidente(Presi,_,_)).

malo(Presi):-
    actoDelPresidente(Presi,_,_),
    not((actoDelPresidente(Presi,Acto,_),actoBueno(Acto))).

regular(Presi):-
    periodo(Presi,_,_,_),
    forall(
        periodo(Presi,_,_,Periodo),
        (actoDelPresidente(Presi,Acto,Periodo),actoBueno(Acto))
    ).

bueno(Presi):-
    periodo(Presi,_,_,Periodo),
    buenPeriodo(Periodo).

buenPeriodo(Periodo):-
    actoDelPresidente(Presi,_,Periodo),
    forall(actoDelPresidente(Presi,Acto,Periodo),actoBueno(Acto)).

muyBueno(Presi):-
    periodo(Presi,_,_,_),
    forall(periodo(Presi,_,_,Periodo),buenPeriodo(Periodo)).
