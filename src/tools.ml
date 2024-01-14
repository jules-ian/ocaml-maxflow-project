(* Yes, we have to repeat open Graph. *)
open Graph

(* A path is a list of nodes. *)
type path = id list

let rev_path path = match path with
  |None -> None
  |Some p -> Some (List.rev p)

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


let add_arc gr id1 id2 a = new_arc gr {src = id1; tgt = id2; lbl = a}  (*"If the arc already exists, its label is replaced by lbl. "*)


(* fct qui verifie si un arc est dans un path donné *)

let rec in_path path arc = match path with 
  |[] -> false
  |[_] -> false
  |first::next::rest -> if (arc.src = first && arc.tgt = next) then 
      true 
    else 
      in_path (next::rest) arc


(*fonction pour trouver le label d'un arc*)
let label_arc gr s1 s2 = match find_arc gr s1 s2 with
  |None -> failwith(" Not an existing arc in label_arc ") (* NE DOIT JAMAIS ARRIVER car ça voudrait dire que le chemin n'est pas un chemin -> failwith*)
  |Some a -> a.lbl

(*fonction pour supprimer un arc du graphe*)
let remove_arc gr s1 s2 = match find_arc gr s1 s2 with
  |None -> failwith("Not an existing arc in remove_arc") (* NE DOIT JAMAIS ARRIVER car ça voudrait dire que le chemin n'est pas un chemin -> failwith*)
  (*Seul manière de supprimer un arc c'est de supprimer tous les arcs, et de tous les rajouter sauf celui qu'on veut supprimer*)
  |Some a -> e_fold gr (fun acu (arc:'a arc) -> match arc=a with
      |true -> acu
      |false -> new_arc acu {src = arc.src; tgt = arc.tgt; lbl = arc.lbl} ) (clone_nodes gr)
(*Same as add_arc but add value if already existed*)
let change_arc gr id1 id2 value = match (find_arc gr id1 id2) with
|None -> new_arc gr {src = id1; tgt = id2; lbl = value}
|Some a -> new_arc gr {src = id1; tgt = id2; lbl = a.lbl + value}