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
  let graph = from_file infile in

  (*let graphClone = clone_nodes graph in*) 
  let graphDot = export graph in 
  let path_test = find_path (gmap (from_file "graphs/graph12.txt") int_of_string) [] 0 3  in
  let path_test_rev = match path_test with
    |None -> None
    |Some p -> Some (List.rev p)
  in


  (*find_path*)
  let () = Printf.printf "------Test find_path---------\n" in 
  let () = print_int_list_option path_test_rev in 
  let () = Printf.printf "---------------\n" in 



  (*flot_possible*)
  let () = Printf.printf "------Test flot_possible---------\n" in 
  let () = print_int (flot_possible (gmap (from_file "graphs/graph12.txt") int_of_string) (path_test_rev)) in 
  let () = Printf.printf "---------------\n" in 

  (*find_bottleneck*)
  let () = Printf.printf "------Test find_bottleneck---------\n" in 
  let () = print_int_arc_option (find_bottleneck (gmap (from_file "graphs/graph12.txt") int_of_string) (path_test_rev)) in 
  let () = Printf.printf "---------------\n" in 

  (* Rewrite the graph that has been read. *)
  let () = Printf.printf "%s %!" graphDot in 
  let () = write_file outfile graph in 


  ()  
