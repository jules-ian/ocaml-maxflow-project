(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr:'a graph) = n_fold gr new_node empty_graph


let gmap (gr:'a graph) f = e_fold gr (fun acu (arc:'a arc) -> new_arc acu {src = arc.src; tgt = arc.tgt; lbl = (f arc.lbl)} ) (clone_nodes gr)
(*val e_fold: 'a graph -> ('b -> 'a arc -> 'b) -> 'b -> 'b*) (** TODO : traiter le cas ou le graphe est vide **) 

(**)

let add_arc gr id1 id2 a = match find_arc gr id1 id2 with
  | None -> new_arc gr {src = id1; tgt = id2; lbl = a} 
  | Some x -> new_arc gr {src = id1; tgt = id2; lbl = a + x.lbl}  (*"If the arc already exists, its label is replaced by lbl. "*)

(* On a codé ces fonctions pour fabriquer le graphe résiduel je crois, autant le faire*)

(* TODO : faire fonction de maj des arcs FINIS LE TODO PDT QUE JE VAIS A LA CAFET, tu veux quoi ? je push
   on met des vrais todos

   ON A UN RAPPORT A ECRIRE EN PDLA 4 PaGeS j'avais zappé c'etait pas dans mon edt, faut qu'on fasse la phase d'auth aussi non c'est vendredi 8 le rendu
   on a le week end prochain non? 23h59? jcrois ca va bosser. Je t'en prie
   moyen de lui envoyer un mail pour lui demander de décaler à lundi comme on a full exam? allez, fais le TODO
   du coup sur le graphe y'a 
*)