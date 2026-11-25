---- MODULE SM_E_09 ----
(***************************************************************************)
(* SM-E-09 Relation d'amitié, chosen for a model by D-107.                 *)
(* Diagram and rules: "Conception système", section SM-E-09 and table      *)
(* "Modèles TLA+".                                                         *)
(*                                                                         *)
(* Several accounts act at the same time; each server action is one        *)
(* transaction (the design's assumption, which the code must keep).        *)
(* Rules are named after the decision they come from until their business  *)
(* rules (BR) exist; they are renamed BR_xxx then.                         *)
(***************************************************************************)
EXTENDS FiniteSets

CONSTANT Accounts

VARIABLES
    alive,    \* accounts that exist (F-063 removes one, D-101)
    req,      \* <<x, y>>: x asked y, y has not answered (E-09 "demandé")
    invit,    \* <<x, y>>: the "invitation" notification shown to y (D-070)
    friends,  \* {x, y}: friends (E-09 "ami")
    conv,     \* {x, y}: their conversation exists (D-071)
    close     \* <<x, y>>: x marked y as a close friend (D-060)

vars == <<alive, req, invit, friends, conv, close>>

Pairs == Accounts \X Accounts

TypeOK ==
    /\ alive \subseteq Accounts
    /\ req \subseteq Pairs
    /\ invit \subseteq Pairs
    /\ close \subseteq Pairs
    /\ friends \subseteq SUBSET Accounts
    /\ conv \subseteq SUBSET Accounts

Init ==
    /\ alive = Accounts
    /\ req = {}
    /\ invit = {}
    /\ friends = {}
    /\ conv = {}
    /\ close = {}

\* F-034 by x on y's "Ajouter". A request from y already waiting is accepted (D-073).
Request(x, y) ==
    /\ x # y
    /\ {x, y} \subseteq alive
    /\ {x, y} \notin friends
    /\ <<x, y>> \notin req
    /\ IF <<y, x>> \in req
         THEN /\ req' = req \ {<<y, x>>}
              /\ invit' = invit \ {<<y, x>>}
              /\ friends' = friends \cup {{x, y}}
              /\ conv' = conv \cup {{x, y}}
         ELSE /\ req' = req \cup {<<x, y>>}
              /\ invit' = invit \cup {<<x, y>>}
              /\ UNCHANGED <<friends, conv>>
    /\ UNCHANGED <<alive, close>>

\* F-028 by y: accept x's request.
Accept(y, x) ==
    /\ <<x, y>> \in req
    /\ y \in alive
    /\ req' = req \ {<<x, y>>}
    /\ invit' = invit \ {<<x, y>>}
    /\ friends' = friends \cup {{x, y}}
    /\ conv' = conv \cup {{x, y}}
    /\ UNCHANGED <<alive, close>>

\* F-028.a by y: refuse x's request; x can ask again (D-048).
Refuse(y, x) ==
    /\ <<x, y>> \in req
    /\ y \in alive
    /\ req' = req \ {<<x, y>>}
    /\ invit' = invit \ {<<x, y>>}
    /\ UNCHANGED <<alive, friends, conv, close>>

\* F-072 by x: tick or untick friend y in the close friends list (D-060).
SetClose(x, y) ==
    /\ x \in alive
    /\ {x, y} \in friends
    /\ <<x, y>> \notin close
    /\ close' = close \cup {<<x, y>>}
    /\ UNCHANGED <<alive, req, invit, friends, conv>>

UnsetClose(x, y) ==
    /\ x \in alive
    /\ <<x, y>> \in close
    /\ close' = close \ {<<x, y>>}
    /\ UNCHANGED <<alive, req, invit, friends, conv>>

\* F-063 by x: everything that involves x goes at once (D-101).
Delete(x) ==
    /\ x \in alive
    /\ alive' = alive \ {x}
    /\ req' = {t \in req : x \notin {t[1], t[2]}}
    /\ invit' = {t \in invit : x \notin {t[1], t[2]}}
    /\ close' = {t \in close : x \notin {t[1], t[2]}}
    /\ friends' = {s \in friends : x \notin s}
    /\ conv' = {s \in conv : x \notin s}

Next ==
    \/ \E x, y \in Accounts :
          \/ Request(x, y) \/ Accept(x, y) \/ Refuse(x, y)
          \/ SetClose(x, y) \/ UnsetClose(x, y)
    \/ \E x \in Accounts : Delete(x)

Spec == Init /\ [][Next]_vars

-----------------------------------------------------------------------------
(* Rules, from the table "Modèles TLA+" of the Conception système.         *)

\* Never two requests waiting in both directions (D-073).
D073_NoCrossedRequests ==
    \A x, y \in Accounts : ~(<<x, y>> \in req /\ <<y, x>> \in req)

\* Never a request between two friends (D-073).
D073_NoRequestBetweenFriends ==
    \A t \in req : {t[1], t[2]} \notin friends

\* The invitation is shown exactly while the request waits (D-070).
D070_InvitationWhileRequest == invit = req

\* A conversation exists if and only if the two accounts are friends (D-071, D-082).
D071_D082_ConversationIffFriends == conv = friends

\* A close friend is always a friend (D-060).
D060_CloseFriendIsFriend == \A t \in close : {t[1], t[2]} \in friends

\* Nothing is left of a deleted account (D-101).
D101_NothingLeftOfDeleted ==
    \A x \in Accounts \ alive :
        /\ \A t \in req \cup invit \cup close : x \notin {t[1], t[2]}
        /\ \A s \in friends \cup conv : x \notin s
====
