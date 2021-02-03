module StringMap = Map.Make (String)

module Make (Key : Map.OrderedType) (Val : Map.OrderedType) = struct
  type key = Key.t

  type val_ = Val.t

  module KeyMap = Map.Make (Key)
  module ValMap = Map.Make (Val)

  type keymap = val_ KeyMap.t

  type valmap = key ValMap.t

  type t =
    { k : keymap
    ; v : valmap
    }

  let empty : t = { k = KeyMap.empty; v = ValMap.empty }

  let cardinal : t -> int = fun t -> KeyMap.cardinal t.k

  let is_empty t = cardinal t = 0

  let add : k:key -> v:val_ -> t -> t =
   fun ~k ~v t -> { k = KeyMap.add k v t.k; v = ValMap.add v k t.v }

  (* Asymetric operations *)
  module Key = struct
    let mem : key -> t -> bool = fun k t -> KeyMap.mem k t.k

    let find_opt : key -> t -> val_ option = fun k t -> KeyMap.find_opt k t.k
  end

  module Val = struct
    type nonrec t = t

    let mem : val_ -> t -> bool = fun v t -> ValMap.mem v t.v

    let find_opt : val_ -> t -> key option = fun v t -> ValMap.find_opt v t.v
  end
end
