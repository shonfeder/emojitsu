(** A bidirecitonal map between As and Bs *)
module type S = sig
  type t

  module A : sig
    type key
  end

  module B : sig
    type key
  end

  val empty : t

  val is_empty : t -> bool

  val add : A.key -> B.key -> t -> t

  module FromA : sig
    val mem : A.key -> t -> bool

    val find_opt : A.key -> t -> B.key option
  end

  module FromB : sig
    val mem : B.key -> t -> bool

    val find_opt : B.key -> t -> A.key option
  end
end

module Make (As : Map.OrderedType) (Bs : Map.OrderedType) :
  S with type A.key = As.t and type B.key = Bs.t = struct
  module A = struct
    include Map.Make (As)

    type nonrec t = Bs.t t
  end

  module B = struct
    include Map.Make (Bs)

    type nonrec t = A.key t
  end

  type t =
    { a : A.t
    ; b : B.t
    }

  let empty : t = { a = A.empty; b = B.empty }

  let cardinal : t -> int = fun t -> A.cardinal t.a

  let is_empty t = cardinal t = 0

  let add : A.key -> B.key -> t -> t =
   fun a b t -> { a = A.add a b t.a; b = B.add b a t.b }

  (** Asymetric operations from As to Bs *)
  module FromA = struct
    let mem : A.key -> t -> bool = fun a t -> A.mem a t.a

    let find_opt : A.key -> t -> B.key option = fun a t -> A.find_opt a t.a
  end

  (** Asymetric operations from Bs to As *)
  module FromB = struct
    type nonrec t = t

    let mem : B.key -> t -> bool = fun b t -> B.mem b t.b

    let find_opt : B.key -> t -> A.key option = fun b t -> B.find_opt b t.b
  end
end
