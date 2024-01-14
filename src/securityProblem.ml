(* 
Histoire : Il y a plusieurs locaux de OcamlCorp qui ont reçu des cyberattaques de différents types, 
Heuresement, au ClubInfo on a des "cyber security prodigee" dans divers domaines et plein d'autre personne tout aussi efficace, 
Chaque local peut recevoir de l'aide de plusieurs personne spécialisé (en fonction de la criticité de l'attaque) dans le type de la cyberattaque qu'elle a reçu (web, reverse, pwn, osint, misc, social-engineering)
Chaque personne ne peut partir que à 1 local.
Chaque personne peut avoir plusieurs spécialité. (Sauf Baptiste il fait que du web)
Quelle est la configuration qui permet d'envoyer le + de personnes du club, ( dans le but d'avoir un maximum d'efficacité ($$$) )

*)


(*
Il faut dans un premier temps générer un/des graphes représentant notre problème :
Étape 1 : 
Il faut une liste de Node "personne", une liste de Node "problème" avec la cause de la panne (même enum que spécialité)

*)

open Graph
open Tools


type vuln = string

type local = {
  idL: id;
  nameL: string;
  problem: vuln;
  capacity: int}

type person = {
  idP: id;
  nameP: string;
  skills: vuln list}








let id_sink l1 l2 = (List.length l1)+(List.length l2)+1

(*l1 = liste_personne ; l2 = liste_locaux*)
let create_graph l1 l2 = 
  (*méthode pour créer les nodes à partir d'une liste*)
  
  let rec create_nodes_from_list gr lx acc = match lx with
    |[] -> gr
    |_::xs -> create_nodes_from_list (new_node gr (acc)) xs (acc+1)
  in
  (*On initialise un graph avec une source et un puit *)
  let graph_init l1 l2 = new_node (new_node empty_graph 0) (id_sink l1 l2) 
  in 
  (*Fais le graph_init, puis y ajoute tous les Nodes de l1, puis y ajoute tous les Nodes de l2*)
  create_nodes_from_list (create_nodes_from_list (graph_init l1 l2) l1 1) l2 ((List.length l1)+1)


(*
Étape 2 : Faire les arcs du graphe : 
  -Le source relie chaque Node personne par un arc de 1
*)
let create_src_to_member_edges gr l1 = 
  let rec loop gr l1 acc = match l1 with
    |[] -> gr
    |_::xs -> loop (add_arc gr 0 acc 1) xs (acc+1)
  in
  loop gr l1 1
(*
  -Chaque Node personne "émet" un arc vers les locaux où elle peut agir

*)
let rec create_person_to_locals_edges gr l1 l2 = 
  (*Si un local correspond à une des spécialités de la personne, on fait un arc avec*)
  let rec edge_if_specialites_contains_problem gr person skills local = match skills with 

    |[] -> gr

    |x::xs -> begin match x = local.problem with 
        |true -> add_arc gr person.idP local.idL 1
        |false -> edge_if_specialites_contains_problem gr person xs local
      end
  in

  let rec loop_on_l2 gr person skills llocal = match llocal with
    |[] -> gr 
    |y::ys -> loop_on_l2 (edge_if_specialites_contains_problem gr person person.skills y) person skills ys
  in

  match l1 with 
  |[] -> gr
  |z::zs -> create_person_to_locals_edges (loop_on_l2 gr z z.skills l2) zs l2





(*
  -Chaque Node local "émet" un arc plus ou moin grand (capa) vers le puit
*)
(* Je met un acu car pour trouver l'id du sink il faut retenir les listes initiales *)
let rec create_local_to_sink_edges gr l1 l2acu l2 = 
  match l2acu with 
  |[]-> gr
  |y::ys -> create_local_to_sink_edges (add_arc gr y.idL (id_sink l1 l2) y.capacity) l1 ys l2

(* FONCTION qui crée tout le graphe *)
let soupe_des_fonctions l1 l2 = create_local_to_sink_edges (create_person_to_locals_edges (create_src_to_member_edges (create_graph l1 l2) l1) l1 l2) l1 l2 l2
(*
    Idée : on fait le FordFulkerson la dessus donc : 
    -Il y'a que 1 qui rentre dans une Personne donc elle ne peut choisir que un local
    -Il y'a que X qui sort du local donc elle ne peut avoir que X arc de personne entrante
    -En cherchant le flux max, on cherche à faire sortir le + de personne (du club). 

  *)


(* --------------------------------  Functions to parse an input file  -------------------------------------*)



(* Regular expression to match comment lines *)
let comment_regex = Str.regexp "^#"

(* Regular expression to match lines with person information *)
let person_regex = Str.regexp "^\\([^,]+\\), \\([^,]+\\(, \\([^0-9,]+\\)\\)*\\)$"

(* Regular expression to match lines with local information *)
let local_regex = Str.regexp "^\\([^,]+\\), \\([^,]+\\), \\([0-9]+\\)$"


(* Function to parse a line of person information *)
let parse_comment line = Str.string_match comment_regex line 0 

(* Function to parse a line of person information *)
let parse_person line id =
  if Str.string_match person_regex line 0 then
    let nameP = Str.matched_group 1 line in
    let skills = Str.split (Str.regexp ", ") (Str.matched_group 2 line) in
    Some {idP = id; nameP = nameP; skills = skills}
  else
    None

(* Function to parse a line of local information *)
let parse_local line id =
  if Str.string_match local_regex line 0 then
    let nameL = Str.matched_group 1 line in
    let problem = Str.matched_group 2 line in
    let capacity = int_of_string (Str.matched_group 3 line) in
    Some {idL = id ; nameL = nameL; problem = problem; capacity = capacity}
  else
    None


(* Function to read the input file and create OcamlCorp data *)
let read_ocamlcorp_data file_name =
  let ic = open_in file_name in
  let rec read_lines people locals id_acu =
    try
      let line = input_line ic in
      match parse_comment line with (* Skip line if it is a comment *)
      |true -> read_lines people locals id_acu
      |false -> (match parse_person line id_acu with (* Iterate on people first because the first IDs are for people*)
          | Some person -> read_lines (person :: people) locals (id_acu + 1)
          | None ->
            (match parse_local line id_acu with
             | Some local -> read_lines people (local :: locals) (id_acu + 1)
             | None -> read_lines people locals id_acu)) (* Unreadable line : empty line, Comment line....*)
    with End_of_file -> (List.rev people, List.rev locals)
  in
  let people, locals = read_lines [] [] 1 in
  close_in ic;
  people, locals 


(* Analyse du résultat *)



let rec username_from_id id people_list = match people_list with
  |[] -> failwith("user not found")
  |x::_ when x.idP = id -> x.nameP
  |_::xs -> username_from_id id xs

let rec localname_from_id id local_list = match local_list with
  |[] -> failwith("local not found")
  |x::_ when x.idL = id -> x.nameL
  |_::xs -> localname_from_id id xs


(*On veut savoir, à partir du graphe d'écart final quel membre du club est dans quelle local, et ceux qui ne sont pas partis) *)

(*Il suffit de regarder tous les arcs partant d'un local vers un node qui n'est pas le puit (=les nodes des membres qui sont partis dans le local) 
  la destination est le membre et la source est le local où il est parti
*)


let show_position gr flow_max l1 l2 sinkid = 
  let () = Printf.printf "Le nombre de membre qui sont partis est de : %d\n" flow_max in
  
  let rec loop_arc_target gr liste_arc = match liste_arc with
    |[] -> ()
    |y::ys -> begin match (y.tgt = sinkid) with
        |true -> (); loop_arc_target gr ys
        |false -> Printf.printf "%s est parti au local %s \n" (username_from_id y.tgt l1) (localname_from_id y.src l2) ; loop_arc_target gr ys
      end
  in 
  let rec loop_local gr l2 sinkid = match l2 with 
    |[] -> ()
    |x::xs -> loop_arc_target gr (out_arcs gr x.idL); loop_local gr xs sinkid
  in
  let rec print_jobless_member gr out_arcs0 = match out_arcs0 with 
  |[] -> ()
  |x::xs -> Printf.printf "%s est resté au club \n" (username_from_id x.tgt l1); print_jobless_member gr xs
  in 
  (); loop_local gr l2 sinkid; print_jobless_member gr (out_arcs gr 0)























