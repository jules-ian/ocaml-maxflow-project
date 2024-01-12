open Graph
open Tools

(* find_path gr forbidden id1 id2 
    *   returns None if no path can be found.
    *   returns Some p if a path p from id1 to id2 has been found. 
    *
    *  forbidden is a list of forbidden nodes (they have already been visited)
*)
val find_path: int graph -> id list -> id -> id -> path option  
val flot_possible: int graph -> path option -> int
val find_bottleneck: int graph -> path option -> int arc option
(*val add_flow: int graph -> path -> int arc option -> int graph*)
val update_graph: int graph -> path -> int -> int graph
val ford_fulkerson: int graph -> id -> id -> int
