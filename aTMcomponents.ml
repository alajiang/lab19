open Scanf

type id = int

type action =
  | Balance           (* balance inquiry *)
  | Withdraw of int   (* withdraw an amount *)
  | Deposit of int    (* deposit an amount *)
  | Next              (* finish this customer and move on to the next one *)
  | Finished          (* shut down the ATM and exit entirely *)
;; 

type account_spec = {name : string; id : id; balance : int} ;;

module ACC_SET = Set.Make(struct 
							type t = account_spec
							let compare = Stdlib.compare
						  end)

class type persons = 
	object
		val mutable id
		val mutable balance
		val mutable name

		method get_balance : id -> int
		method get_name : id -> string
		method update_balance : id -> int -> unit
	end





let initialize (lst : account_spec list) : unit = 
   let emp = ACC_SET.empty in 
   List.fold_left (fun acc x -> ACC_SET.add x acc) emp lst



let acquire_id : unit -> id = 
	let iden = read_int () in
	ACC_SET.mem iden 

let acquire_amount : unit -> int = 


let acquire_act : unit -> action =


let get_balance (iden : id) : int =


let get_name (iden : id) : string = 


let update_balance (iden : id) (amnt : int) : unit =


let present_message (str : string) : unit = 


let deliver_cash (amnt : int) : unit =

