open Printf ;;
open Scanf ;;

module DB = Database ;;

type id = int ;;

type action =
  | Balance           (* balance inquiry *)
  | Withdraw of int   (* withdraw an amount *)
  | Deposit of int    (* deposit an amount *)
  | Next              (* finish this customer and move on to the next one *)
  | Finished          (* shut down the ATM and exit entirely *)
;; 

type account_spec = {name : string; id : id; balance : int} ;;





let initialize (lst : account_spec list) : unit = 
   lst
   |> List.iter (fun {name; id; balance} ->
   										DB.create id name; DB.update id balance) ;;



let rec acquire_id () : id = 
	printf "Enter id number: ";
	try
		let id = read_int () in
		ignore (DB.exists id); id
	with
	| Not_found
	| Failure _ -> printf "invalid id \n";
				   acquire_id () ;;

let rec acquire_amount () : int = 
	printf "Enter amount: ";
	try
		let amnt = read_int () in
		if amnt <= 0 then raise (Failure "amount is non-positive");
		amnt
	with
	| Failure _ -> printf "invalid amount requested \n";
				   acquire_amount () ;;

let rec acquire_act () : action =
	printf "Enter action: (B) Balance (-) Withdraw (+) Deposit \
						  (=) Done (X) Exit: %!";
	scanf " %c"
	   (fun char -> match char with 
					| 'b' | 'B' -> Balance
					| '/' | 'x' | 'X' -> Finished
					| '=' -> Next
					| 'w' | 'W' | '-' -> Withdraw (acquire_amount ())
					| 'd' | 'D' | '+' -> Deposit (acquire_amount ())
					| _ -> printf "invalid choice, try again \n";
						acquire_act () );;

let get_balance : id -> int = DB.balance ;;


let get_name : id -> string = DB.name ;;


let update_balance : id -> int -> unit = DB.update ;;


let present_message (str : string) : unit = 
	printf "%s\n%!" str ;;


let deliver_cash (amnt : int) : unit =
	printf "Here's your cash: ";
	for _i = 1 to (amnt / 20) do
		printf "[20 @ 20]"
	done;

	printf " and %d more \n" (amnt mod 20) ;;
