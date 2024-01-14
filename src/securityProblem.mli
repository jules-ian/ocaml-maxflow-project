open Graph


(* A cybersecurity vunerability *)
type vuln = string 

(* A local of OcamlCorp hit by a cyberattack *)
type local = {
  (* id of a local *)
  idL: id;
  (* name of the local *)
  nameL: string;
  (* problem in the local *)
  problem: vuln;
  (* number of people who can work in the local *)
  capacity : int}

type person = {
  (* id of a person *)
  idP: id;
  (* name of the person *)
  nameP: string;
  (* list of all the vulnerabilities a person can work on *)
  skills: vuln list}



val id_sink: 'a list -> 'b list -> id
val create_graph: 'a list -> 'b list -> 'c graph
val create_src_to_member_edges: int graph -> person list -> int graph
val create_personne_to_locaux_edges: int graph -> person list -> local list -> int graph
val create_local_to_sink_edges:  int graph -> 'a list -> local list -> 'b list -> int graph
val soupe_de_fonction: person list -> local list -> int graph



(* Regular expression to match lines with local information *)
val local_regex : Str.regexp

(* Regular expression to match lines with person information *)
val person_regex : Str.regexp

(* Function to parse a line of local information *)
val parse_local : string -> int -> local option

(* Function to parse a line of person information *)
val parse_person : string -> int -> person option

(* Function to read the input file and create OcamlCorp data *)
val read_ocamlcorp_data : string -> person list * local list