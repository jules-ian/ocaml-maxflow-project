(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr:'a graph) = n_fold gr new_node empty_graph


let gmap (gr:'a graph) f = e_fold gr (fun acu (arc:'a arc) -> new_arc acu {src = arc.src; tgt = arc.tgt; lbl = (f arc.lbl)} ) (clone_nodes gr)
(*val e_fold: 'a graph -> ('b -> 'a arc -> 'b) -> 'b -> 'b*) (** TODO : traiter le cas ou le graphe est vide **) 

(**)
(*
let add_arc gr id1 id2 a = 
*)
