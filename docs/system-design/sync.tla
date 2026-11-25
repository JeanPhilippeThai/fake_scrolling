---- MODULE sync ----
(***************************************************************************)
(* Sync between phones: the sends that wait for the server (FL-12),        *)
(* chosen for a model by D-107.                                            *)
(* Rules: "Conception système", flow FL-12 and table "Modèles TLA+".       *)
(*                                                                         *)
(* Several accounts sign in and out of several phones. A change waits on   *)
(* the phone, tied to its account, and goes only while that account is     *)
(* connected there (D-104, D-109, D-112). The kinds of change are reduced  *)
(* to two: a support, never dropped while its account exists (D-095,       *)
(* D-113, D-116), and the others (timer, D-077; story "vue", D-078;        *)
(* profile photo, D-100; offline time, D-117), which the server can refuse *)
(* for good (D-113). Counting time across phones is in SM_E_14.            *)
(* Rules are named after their decisions until their BR exist.             *)
(***************************************************************************)
EXTENDS Naturals

CONSTANTS
    Accounts,
    Phones,
    NoAccount,   \* a phone with no session (P-01)
    MaxChanges   \* changes the model makes, all phones together

Kinds == {"support", "other"}
Items == [id : 1..MaxChanges, acc : Accounts, kind : Kinds]

VARIABLES
    alive,     \* accounts that exist (F-063, D-101)
    session,   \* session[p]: the account connected on p, or NoAccount
    pending,   \* pending[p]: changes waiting on p (FL-12)
    recorded,  \* what the server recorded, with the account p was connected to when sent
    dropped,   \* ghost: changes abandoned
    nextId

vars == <<alive, session, pending, recorded, dropped, nextId>>

TypeOK ==
    /\ alive \subseteq Accounts
    /\ session \in [Phones -> Accounts \cup {NoAccount}]
    /\ pending \in [Phones -> SUBSET Items]
    /\ recorded \subseteq [item : Items, as : Accounts]
    /\ dropped \subseteq Items
    /\ nextId \in 1..(MaxChanges + 1)

Init ==
    /\ alive = Accounts
    /\ session = [p \in Phones |-> NoAccount]
    /\ pending = [p \in Phones |-> {}]
    /\ recorded = {}
    /\ dropped = {}
    /\ nextId = 1

\* FL-01: an existing account signs in on p.
Login(p, a) ==
    /\ session[p] = NoAccount
    /\ a \in alive
    /\ session' = [session EXCEPT ![p] = a]
    /\ UNCHANGED <<alive, pending, recorded, dropped, nextId>>

\* F-071: what waits stays on p, tied to its account (D-104).
Logout(p) ==
    /\ session[p] # NoAccount
    /\ session' = [session EXCEPT ![p] = NoAccount]
    /\ UNCHANGED <<alive, pending, recorded, dropped, nextId>>

\* A change the server has not recorded yet waits on p (FL-12 step 1).
Change(p, k) ==
    /\ session[p] # NoAccount
    /\ nextId <= MaxChanges
    /\ pending' = [pending EXCEPT ![p] = @ \cup {[id |-> nextId, acc |-> session[p], kind |-> k]}]
    /\ nextId' = nextId + 1
    /\ UNCHANGED <<alive, session, recorded, dropped>>

\* FL-12 steps 2 to 4: sent only for the account connected on p (D-104, D-112).
\* For a deleted account, the server refuses it for good: dropped, and p goes back
\* to P-01 (D-101, D-113, D-116).
Send(p, i) ==
    /\ i \in pending[p]
    /\ session[p] = i.acc
    /\ pending' = [pending EXCEPT ![p] = @ \ {i}]
    /\ IF i.acc \in alive
         THEN /\ recorded' = recorded \cup {[item |-> i, as |-> session[p]]}
              /\ UNCHANGED <<session, dropped>>
         ELSE /\ dropped' = dropped \cup {i}
              /\ session' = [session EXCEPT ![p] = NoAccount]
              /\ UNCHANGED recorded
    /\ UNCHANGED <<alive, nextId>>

\* The server refuses a change for good (invalid data, story already erased):
\* dropped without a message; never a support (D-113).
RefuseForGood(p, i) ==
    /\ i \in pending[p]
    /\ session[p] = i.acc
    /\ i.acc \in alive
    /\ i.kind # "support"
    /\ pending' = [pending EXCEPT ![p] = @ \ {i}]
    /\ dropped' = dropped \cup {i}
    /\ UNCHANGED <<alive, session, recorded, nextId>>

\* F-063 on p: the account and everything it had go at once; what waited for it
\* on p is dropped (D-101, D-109).
DeleteAccount(p) ==
    /\ session[p] \in alive
    /\ LET a == session[p] IN
       /\ alive' = alive \ {a}
       /\ session' = [session EXCEPT ![p] = NoAccount]
       /\ pending' = [pending EXCEPT ![p] = {i \in @ : i.acc # a}]
       /\ dropped' = dropped \cup {i \in pending[p] : i.acc = a}
       /\ recorded' = {r \in recorded : r.item.acc # a}
    /\ UNCHANGED nextId

\* Another phone connected to a deleted account goes back to P-01 at its next
\* exchange with the server, and drops what waited for that account (D-101).
Kicked(p) ==
    /\ session[p] # NoAccount
    /\ session[p] \notin alive
    /\ LET a == session[p] IN
       /\ session' = [session EXCEPT ![p] = NoAccount]
       /\ pending' = [pending EXCEPT ![p] = {i \in @ : i.acc # a}]
       /\ dropped' = dropped \cup {i \in pending[p] : i.acc = a}
    /\ UNCHANGED <<alive, recorded, nextId>>

\* A phone holding changes of an account deleted elsewhere drops them at its next
\* exchange with the server, whoever is connected (D-101). Without this, they would
\* wait on the phone forever, since that account can never connect again.
Purge(p) ==
    /\ \E i \in pending[p] : i.acc \notin alive
    /\ pending' = [pending EXCEPT ![p] = {i \in @ : i.acc \in alive}]
    /\ dropped' = dropped \cup {i \in pending[p] : i.acc \notin alive}
    /\ UNCHANGED <<alive, session, recorded, nextId>>

Next ==
    \/ \E p \in Phones :
          \/ Logout(p) \/ DeleteAccount(p) \/ Kicked(p) \/ Purge(p)
          \/ \E a \in Accounts : Login(p, a)
          \/ \E k \in Kinds : Change(p, k)
          \/ \E i \in Items : Send(p, i) \/ RefuseForGood(p, i)

\* FL-12 sends whenever it can; the phone talks to the server now and then.
Fairness ==
    \A p \in Phones :
        /\ \A i \in Items : WF_vars(Send(p, i))
        /\ WF_vars(Kicked(p))
        /\ WF_vars(Purge(p))

Spec == Init /\ [][Next]_vars /\ Fairness

-----------------------------------------------------------------------------
(* Rules, from the table "Modèles TLA+" of the Conception système.         *)

\* Never sent for another account (D-104).
D104_NeverForAnotherAccount == \A r \in recorded : r.as = r.item.acc

\* Nothing is kept for a deleted account (D-101).
D101_NothingKeptForDeleted == \A r \in recorded : r.item.acc \in alive

\* Nothing is ever recorded after the account's deletion (D-101).
D101_NothingAfterDeletion ==
    [][\A r \in recorded' \ recorded : r.item.acc \in alive]_vars

\* A support is only dropped with its account (D-113, D-116).
D116_SupportDroppedOnlyWithAccount ==
    \A i \in dropped : i.kind = "support" => i.acc \notin alive

\* A change waiting on a phone goes as soon as its account is connected there:
\* it does not stay forever while that account is connected (D-104, D-108, D-112).
D108_SentWhileConnected ==
    \A p \in Phones, i \in Items :
        (i \in pending[p]) ~> (i \notin pending[p] \/ session[p] # i.acc)

\* What waited for a deleted account always ends, even on a phone where it is not
\* connected (D-101, D-116).
D101_DeletedAccountChangesEnd ==
    \A p \in Phones, i \in Items :
        (i \in pending[p] /\ i.acc \notin alive) ~> (i \notin pending[p])
====
