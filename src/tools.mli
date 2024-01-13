open Graph

(* A path is a list of nodes. *)
type path = id list

val rev_path: path option -> path option

val clone_nodes: 'a graph -> 'b graph
val gmap: 'a graph -> ('a -> 'b) -> 'b graph

val print_int_list_option : int list option -> unit
val print_int_arc_option : int arc option -> unit

val add_arc: int graph -> id -> id -> int -> int graph
val in_path: path -> 'a arc -> bool
val label_arc: int graph -> id -> id -> int
val remove_arc: 'a graph -> id -> id -> 'a graph
val change_arc:int graph -> id -> id -> int -> int graph