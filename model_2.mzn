%OR-Tools-9.2.9972 ibm32 : 8 thread,free_search min CB 420 t= 2m21 
%minizinc 2.6.0
include "all_different.mzn";
include "lex_less.mzn";

%utility function

function 0..1 :search_in_array(VERTEX: u,VERTEX:v)=
let{
set of int :is_in = {if (Edge[i,1] == u /\ Edge[i,2] == v) \/ (Edge[i,2] == u /\ Edge[i,1] == v) then 1 else 0 endif | i in index_set_1of2(Edge)}
}in
max(is_in)
;

%Bound
int : nbVertex;%nb de sommet
int: nbEdge;% nom d'arete
int : n = nbVertex;%nb etiquette

%Range
set of int: VERTEX = 1..nbVertex;
set of int: EDGE = 1..nbEdge;
set of int : ETIQUETTE = 1..n;

%Graphe
array[EDGE,1..2] of VERTEX :Edge; 
array[VERTEX,VERTEX]of 0..1: G = array2d(VERTEX,VERTEX,[if u < v then search_in_array(u,v) else 0 endif|u,v in VERTEX]);

%VARIABLE
var int :CB;
array[VERTEX] of var ETIQUETTE : x_Etiquette;

%opti
array[EDGE] of var int : test_opti = array1d(EDGE, [min([abs(x_Etiquette[u] - x_Etiquette[v]),(n-abs(x_Etiquette[u] - x_Etiquette[v]))] )|u,v in VERTEX where u<v /\ G[u,v]= 1 ]);

%CONSTRAINT
constraint all_different(x_Etiquette);
constraint CB = max(test_opti);
%constraint CB =  sum(u,v in VERTEX where u<v /\ G[u,v]= 1 )(min({abs(x_Etiquette[u] - x_Etiquette[v]),(n-abs(x_Etiquette[u] - x_Etiquette[v]))} ));
%constraint CB =  max(u,v in VERTEX where u<v /\ G[u,v]= 1 )(min({abs(x_Etiquette[u] - x_Etiquette[v]),(n-abs(x_Etiquette[u] - x_Etiquette[v]))} ));


%symetrie assure pas la complétude
%constraint forall(u,v in VERTEX where u<v /\ search_in_array(u,v)= 1)(x_Etiquette[u]<x_Etiquette[v]);
constraint lex_less([x_Etiquette[u] | u,v in VERTEX where u<v /\ G[u,v]= 1 ],[x_Etiquette[v] | u,v in VERTEX where u<v /\ G[u,v]= 1 ]);

constraint lex_less([x_Etiquette[u] | u in VERTEX ],[x_Etiquette[max(VERTEX)-(u-1)] | u in VERTEX ]);
%Solve
%solve minimize CB :: seq_search([int_search(x_Etiquette,dom_w_deg,indomain_min)]);
%solve minimize CB :: seq_search([int_search(x_Etiquette,dom_w_deg,indomain_split)]);
%solve minimize CB :: seq_search([int_search(x_Etiquette,first_fail,indomain_min)]);
solve minimize CB :: seq_search([int_search(x_Etiquette,first_fail,indomain_split)]);

%Solution Output
%output["v : "++show(v)++" etiquette: "++show(fix(x_Etiquette[v]))++";"| v in VERTEX] ++ ["\n CB: "++show(fix(CB))++"\n"];
output[show(x_Etiquette)]++[show(CB)];