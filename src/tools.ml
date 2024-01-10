(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr:'a graph) = n_fold gr new_node empty_graph


let gmap (gr:'a graph) f = e_fold gr (fun acu (arc:'a arc) -> new_arc acu {src = arc.src; tgt = arc.tgt; lbl = (f arc.lbl)} ) (clone_nodes gr)
(*val e_fold: 'a graph -> ('b -> 'a arc -> 'b) -> 'b -> 'b*) (** TODO : traiter le cas ou le graphe est vide **) 

(* Function to print an int list option *)
let print_int_list_option (lst_opt : int list option) =
  match lst_opt with
  | Some lst ->
    print_string "[";
    List.iter (fun num -> print_int num; print_string "; ") lst;
    print_string "]";
    print_newline ()
  | None ->
    print_string "None";
    print_newline ()


(* Function to print an int arc option *)
let print_int_arc_option (arc_opt : int arc option) =
  match arc_opt with
  | Some arc ->
      Printf.printf "Source: %d, Target: %d, Label: %d\n" arc.src arc.tgt arc.lbl
  | None ->
      Printf.printf "None\n"


let add_arc gr id1 id2 a = match find_arc gr id1 id2 with
  | None -> new_arc gr {src = id1; tgt = id2; lbl = a} 
  | Some x -> new_arc gr {src = id1; tgt = id2; lbl = a + x.lbl}  (*"If the arc already exists, its label is replaced by lbl. "*)


(* TODO : faire fonction de maj des arcs 
*)