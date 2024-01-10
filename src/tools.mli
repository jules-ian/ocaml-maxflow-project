open Graph

val clone_nodes: 'a graph -> 'b graph
val gmap: 'a graph -> ('a -> 'b) -> 'b graph
val print_int_list_option : int list option -> unit
val print_int_arc_option : int arc option -> unit

val add_arc: int graph -> id -> id -> int -> int graph
