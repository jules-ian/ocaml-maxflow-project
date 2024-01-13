open Gfile
open Tools
open FordFulkerson
(* open Tools*)

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;

  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *) 

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph1 = from_file infile in
  let graph2 = from_file "graphs/graph2.txt" in 
  let graph2_int = gmap graph2 int_of_string in
  let src = 0 in
  let dest = 12 in

  (*let graphClone = clone_nodes graph in*) 
  let graphDot = export graph1 in 
  let path_test = find_path (gmap (graph2) int_of_string) [] src dest  in
  let path_test_not_option = match path_test with 
    |None -> failwith ("path_test_not_option")
    |Some path -> path
  in
  let flot_test = flot_possible (gmap (graph2) int_of_string) (path_test) in

  (*find_path*)
  let () = Printf.printf "------Test find_path---------\n" in 
  let () = print_int_list_option path_test in 
  let () = Printf.printf "---------------\n" in 



  (*flot_possible*)
  let () = Printf.printf "------Test flot_possible---------\n" in 
  let () = print_int (flot_test) in 
  let () = Printf.printf "---------------\n" in 

  (*find_bottleneck*)
  let () = Printf.printf "------Test find_bottleneck---------\n" in 
  let () = print_int_arc_option (find_bottleneck (gmap (graph2) int_of_string) (path_test) ) in 
  let () = Printf.printf "---------------\n" in 

  (*remove_arc à décommenter *)
  (*let () = Printf.printf "------Test remove_arc---------\n" in 
    let removed_graph = remove_arc (gmap (from_file "graphs/graph11.txt") int_of_string) 3 7 in 
    let string_removed_graph = gmap (removed_graph) string_of_int in 
    let dot_graph = export string_removed_graph in
    let () = write_file outfile dot_graph in 
    let () = Printf.printf "%s %!" dot_graph in 
    let () = Printf.printf "---------------\n" in *)

  (*update_graph*)
  let () = Printf.printf "\n------Test update_graph---------\n" in 
  let updated_graph = update_graph (gmap (graph2) int_of_string) path_test_not_option (flot_test) in 
  let string_updated_graph = gmap (updated_graph) string_of_int in

  (*Ford Fulkerson*)
  let () = Printf.printf "\n------Test Ford_Fulkerson---------\n" in 
  let final_flow = ford_fulkerson_flow graph2_int src dest in 
  let () = Printf.printf "======= Max Flow : %d\n" final_flow in 
  let final_graph = ford_fulkerson_graph graph2_int src dest in 
  let () = Printf.printf "======= Graph : \n" in 

  let final_graph_string = gmap final_graph string_of_int in 
  (*let dot_graph = export string_updated_graph in*)
  let () = write_file outfile string_updated_graph in
  let () = write_file outfile final_graph_string in

  (* Rewrite the graph that has been read.*)
  let () = Printf.printf "%s %!" graphDot in  


  ()  