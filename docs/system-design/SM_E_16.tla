---- MODULE SM_E_16 ----
(***************************************************************************)
(* SM-E-16 Soutien, chosen for a model by D-107.                           *)
(* Diagram and rules: "Conception système", section SM-E-16, flows FL-09   *)
(* and FL-12, table "Modèles TLA+".                                        *)
(*                                                                         *)
(* One account on several phones; the store, the server and the support    *)
(* sent again without a message (D-095) cross. The 1 h threshold (E-15,    *)
(* D-093) is taken as reached. Rules are named after their decisions until *)
(* their BR exist.                                                         *)
(*                                                                         *)
(* Known and accepted (D-115): two phones can each be debited when the     *)
(* second pays before the server has recorded the first; "debits" reaches  *)
(* 2 in this model. What the store does with it is open in F-015.          *)
(***************************************************************************)
EXTENDS Naturals

CONSTANT Phones

VARIABLES
    alive,     \* the account exists (F-063, D-101)
    server,    \* E-16 on the server: "non" or "soutenu"
    view,      \* view[p]: what p last read from the server
    phase,     \* phase[p]: "idle", "paying" (store sheet open) or "thanks"
    debited,   \* debited[p]: the store debited p's current payment
    pending,   \* pending[p]: a debited support waits on p (D-095, FL-12)
    debits,    \* ghost: store debits for this account
    records,   \* ghost: times the server recorded a support
    errorAfterDebit \* ghost: an error was shown after a debit

vars == <<alive, server, view, phase, debited, pending, debits, records, errorAfterDebit>>

TypeOK ==
    /\ alive \in BOOLEAN
    /\ server \in {"non", "soutenu"}
    /\ view \in [Phones -> {"non", "soutenu"}]
    /\ phase \in [Phones -> {"idle", "paying", "thanks"}]
    /\ debited \in [Phones -> BOOLEAN]
    /\ pending \in [Phones -> BOOLEAN]
    /\ debits \in Nat
    /\ records \in Nat
    /\ errorAfterDebit \in BOOLEAN

\* A new account starts "non soutenu" (D-114).
Init ==
    /\ alive = TRUE
    /\ server = "non"
    /\ view = [p \in Phones |-> "non"]
    /\ phase = [p \in Phones |-> "idle"]
    /\ debited = [p \in Phones |-> FALSE]
    /\ pending = [p \in Phones |-> FALSE]
    /\ debits = 0
    /\ records = 0
    /\ errorAfterDebit = FALSE

\* F-015 or F-015.a: "Soutenir le projet", shown while p reads "non soutenu".
StartPay(p) ==
    /\ alive
    /\ phase[p] = "idle"
    /\ view[p] = "non"
    /\ phase' = [phase EXCEPT ![p] = "paying"]
    /\ debited' = [debited EXCEPT ![p] = FALSE]
    /\ UNCHANGED <<alive, server, view, pending, debits, records, errorAfterDebit>>

\* The store fails or the person cancels: P-22.a, P-03.c or P-22.b, shown only
\* when nothing was debited (D-027, D-036, D-095).
StoreFails(p) ==
    /\ phase[p] = "paying"
    /\ phase' = [phase EXCEPT ![p] = "idle"]
    /\ errorAfterDebit' = (errorAfterDebit \/ debited[p])
    /\ UNCHANGED <<alive, server, view, debited, pending, debits, records>>

\* The store confirms: "Merci pour ton soutien." at once, the support waits to be
\* recorded (D-094, D-095).
StoreConfirms(p) ==
    /\ phase[p] = "paying"
    /\ phase' = [phase EXCEPT ![p] = "thanks"]
    /\ debited' = [debited EXCEPT ![p] = TRUE]
    /\ pending' = [pending EXCEPT ![p] = TRUE]
    /\ debits' = debits + 1
    /\ UNCHANGED <<alive, server, view, records, errorAfterDebit>>

\* FL-12: the support reaches the server, which records one per account (D-092, D-115).
\* For a deleted account the server refuses it for good: dropped (D-116). This covers a
\* store that confirms after the account was deleted on another phone, found by TLC.
Send(p) ==
    /\ pending[p]
    /\ pending' = [pending EXCEPT ![p] = FALSE]
    /\ IF alive /\ server = "non"
         THEN /\ server' = "soutenu"
              /\ records' = records + 1
         ELSE UNCHANGED <<server, records>>
    /\ UNCHANGED <<alive, view, phase, debited, debits, errorAfterDebit>>

\* The server or the network fails: the support stays and goes again, no message (D-095, D-113).
SendFails(p) ==
    /\ pending[p]
    /\ UNCHANGED vars

\* p reads E-16 again (opening, next load of the feed or P-22).
Refresh(p) ==
    /\ alive
    /\ view' = [view EXCEPT ![p] = server]
    /\ UNCHANGED <<alive, server, phase, debited, pending, debits, records, errorAfterDebit>>

\* F-063 on any phone: E-16 is erased, and every waiting support with it, on this
\* phone or another (D-101, D-116).
Delete ==
    /\ alive
    /\ alive' = FALSE
    /\ server' = "non"
    /\ pending' = [p \in Phones |-> FALSE]
    /\ UNCHANGED <<view, phase, debited, debits, records, errorAfterDebit>>

Next ==
    \/ Delete
    \/ \E p \in Phones :
          \/ StartPay(p) \/ StoreFails(p) \/ StoreConfirms(p)
          \/ Send(p) \/ SendFails(p) \/ Refresh(p)

\* FL-12 keeps sending until the server records it.
Fairness == \A p \in Phones : WF_vars(Send(p))

Spec == Init /\ [][Next]_vars /\ Fairness

-----------------------------------------------------------------------------
(* Rules, from the table "Modèles TLA+" of the Conception système.         *)

\* No error is ever shown after a debit (D-095).
D095_NoErrorAfterDebit == ~errorAfterDebit

\* The server records one support per account (D-092, D-115).
D115_RecordedOnce == records <= 1

\* "Soutenu" on the server only follows a debit.
D092_SupportedOnlyIfPaid == server = "soutenu" => debits >= 1

\* A confirmed purchase ends recorded, for the account that made it, unless the
\* account is deleted first (D-095, D-104, D-116).
D095_D116_PaidEndsRecorded ==
    \A p \in Phones : pending[p] ~> (~pending[p] /\ (server = "soutenu" \/ ~alive))
====
