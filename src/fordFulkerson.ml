open Graph
open Tools

let get_lbl arc = match arc with
  |None -> -1
  |Some a -> a.lbl

(*On suppose que le graphe de base il n'y a pas d'arc de label <= 0*)

(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
*)
(*On fait un DFS*)
let find_path gr forbidden src dest = 
  (*fct pour explorer les arcs sortants de notre source, si il en existe pas alors on a fini de visité le node et on va chercher les autres*)

  let rec explore gr forbidden node dest pathacu = match node = dest with 
    | true -> Some (pathacu) 
    | false ->  begin match (out_arcs gr node) with (* init pathacu à [] lors de son appel *)
        |[] -> None (* Si on arrive au bout c'est qu'on a pas trouvé de chemin *)


        |x -> List.fold_left (fun acc e -> begin match acc with (* explorer tous les suivants et on note le noeud précédent comme visité *)
            |None -> explore gr (node::forbidden) e.tgt dest (e.tgt::pathacu)
            |Some y -> Some y
          end) None x
      end
  in
  match src with
  |node when node = dest -> Some [src]
  |src -> rev_path (explore gr forbidden src dest [src])

(*TODO : Reverse le PATH ;-; *)
(*Problème actuel : Transformer un path (=String)(UPDATE: QUIPROQUO DANS MA TETE ENTRE 2 PATHS /home... et chemin graphe;; On annule tout) en int list*) (* je la fait en global parce que je sens qu'on va en avoir besoin ailleur aussi*)
(* Le but est d'isoler tous les int du path*)

(* Maintenant qu'on a peut trouver un chemin du puit vers la source, il faut trouver combien de flot on peut rajouter sur ce chemin *)
(* Je pense qu'il faut donc faire un algo qui à partir d'un chemin (int list?) (plutot path option) retourne le label minimum des arcs traversé *)
let flot_possible gr chemin = 

  let rec find_min gr chemin acc = match chemin with
    |[] -> acc
    |[_] -> acc
    |x::y::xs -> let label_arc_value = label_arc gr x y in
      begin match ((label_arc_value) < acc) with 
        |false -> find_min gr (y::xs) acc
        |true -> find_min gr (y::xs) label_arc_value
      end
  in
  match chemin with 
  |None -> -1
  |Some c -> find_min gr c max_int

(* 2e version de flot possible où on revoie l'arc qui fait goulot d'étranglement, on peut ainsi récupérer directement sa valeur et le supprimer*)

let find_bottleneck gr chemin = 

  let rec find_min gr chemin (acc: 'a arc option) = match chemin with (* acc est un arc *)
    |[] -> acc
    |[_] -> acc
    |x::y::xs -> let label_arc_value = label_arc gr x y in
      begin match ((label_arc_value) < (get_lbl acc)) with 
        |false -> find_min gr (y::xs) acc
        |true -> find_min gr (y::xs) (find_arc gr x y)
      end
  in
  let arc_max = {src = 0; tgt = 0; lbl = max_int} in (* definition de l'arc max pour trouver le minimum *)
  match chemin with 
  |None -> None
  |Some c ->  (find_min gr c (Some arc_max))

(* Update an arc with an increase in flow *)
(* Function to apply to every arc of the graph : *)
(* let update_arc path flow arc = if in_path path arc then
   (if arc.lbl <= flow then 
    None
   else
    Some {src = arc.src; tgt = arc.tgt; lbl = (arc.lbl - flow)})
   else 
    Some arc
*)
(* Remove flow to every arc.label of a graph *)
let rec update_graph gr path flow = match path with
  |[] -> gr 
  |[_] -> gr
  (*Je veux modifier l'arc dans le graphe, il faut donc connaître sa valeur de base de lbl*)
  |x::y::xs -> let inter = ((label_arc gr x y) - flow) in 
    match inter with
    (*remove arc if 0*)
    |0 -> update_graph (remove_arc gr x y) (y::xs) flow
    (*update arc if >= 0 (should not be < 0) *)
    |a when a > 0 -> update_graph (add_arc gr x y inter) (y::xs) flow
    |a when a < 0 -> failwith(" problem update graph ")
    |_ -> failwith ("to make compil happy")

(* Etapes suivantes :
      Faire en boucle : 
   - DFS 
   - identifier le goulot d'étranglement
   - ajouter le flot correspondant à tous les arcs du path et retirer le goulot 
     jusqu'a ce qu'aucun chemin ne soit trouvé -> graphe de flot max
*)
let ford_fulkerson_flow gr src dest = 
  let rec loop gr src dest acc = match find_path gr [] src dest with
    |None -> acc
    |Some path -> let flow = flot_possible gr (Some path) in
      loop  (update_graph gr path flow) src dest (acc+flow)

  (*loop (gmap gr (update path flow)) src dest (acc+flow)*)
  in
  loop gr src dest 0

  let ford_fulkerson_graph gr src dest = 
    let rec loop gr src dest = match find_path gr [] src dest with
      |None -> gr
      |Some path -> let flow = flot_possible gr (Some path) in
        loop  (update_graph gr path flow) src dest
  
    (*loop (gmap gr (update path flow)) src dest (acc+flow)*)
    in
    loop gr src dest






