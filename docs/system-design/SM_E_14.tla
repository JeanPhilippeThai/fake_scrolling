---- MODULE SM_E_14 ----
(***************************************************************************)
(* SM-E-14 Minuteur de couleur, and the account's usage time (E-15),       *)
(* chosen for a model by D-107.                                            *)
(* Diagram and rules: "Conception système", section SM-E-14, flows FL-05   *)
(* and FL-12, table "Modèles TLA+".                                        *)
(*                                                                         *)
(* One account, several phones, each online or not. What a phone does      *)
(* becomes an event stamped with the phone's time: a second in the         *)
(* foreground, a new duration (F-060), a reset (F-061). Events wait on the *)
(* phone until the server gets them (D-077, D-117), in any order. The      *)
(* server keeps the set of events and computes the timer from it, ordered  *)
(* by the phones' time (D-111, D-117): a second seen by two phones is one  *)
(* event (D-105).                                                          *)
(*                                                                         *)
(* Phones' clocks are assumed to agree. Bounds are kept small for the      *)
(* checker (MaxCycles stands for the 10 cycles of F-024). Rules are named  *)
(* after their decisions until their BR exist.                             *)
(***************************************************************************)
EXTENDS Naturals, FiniteSets

CONSTANTS
    Phones,          \* phone numbers, e.g. {1, 2}; the number breaks ties (D-111)
    Durations,       \* cycle durations a phone can choose (F-060)
    DefaultDuration, \* duration of a new account's timer (D-114)
    MaxCycles,       \* cycles before black and white (10 in the app)
    MaxTime,         \* seconds the model runs
    MaxSettings      \* settings the model makes, all phones together

ASSUME DefaultDuration \in Durations /\ MaxCycles \in Nat \ {0}

Ev(type, t, p, d) == [type |-> type, t |-> t, p |-> p, d |-> d]
Sec(s) == Ev("sec", s, 0, 0)   \* the s-th second; the same event from every phone

Events ==
    {Sec(s) : s \in 1..MaxTime}
    \cup {Ev("dur", t, p, d) : t \in 0..MaxTime, p \in Phones, d \in Durations}
    \cup {Ev("reset", t, p, 0) : t \in 0..MaxTime, p \in Phones}

IsSetting(e) == e.type \in {"dur", "reset"}

VARIABLES
    now,      \* the time, in seconds
    fg,       \* fg[p]: the app is open and in the foreground on p
    online,   \* online[p]: p reaches the server
    outbox,   \* outbox[p]: events waiting on p (FL-12)
    log,      \* events the server has
    made,     \* ghost: every event ever made
    fgCount,  \* ghost: seconds with at least one phone in the foreground
    lastDur   \* ghost: the latest duration chosen, as [t, p, d]

vars == <<now, fg, online, outbox, log, made, fgCount, lastDur>>

Max(S) == CHOOSE m \in S : \A x \in S : x <= m

\* A setting made at time t applies to the seconds after t.
Later(e, f) == e.t > f.t \/ (e.t = f.t /\ e.p > f.p)

DurAt(E, s) ==
    LET D == {e \in E : e.type = "dur" /\ e.t < s}
    IN IF D = {} THEN DefaultDuration
       ELSE (CHOOSE e \in D : \A f \in D : f = e \/ Later(e, f)).d

LastReset(E) ==
    LET R == {e.t : e \in {x \in E : x.type = "reset"}}
    IN IF R = {} THEN 0 ELSE Max(R)

\* One second of the replay: it counts if it comes after the last reset, and
\* the timer is not black and white yet (F-024, D-075, D-076).
Step(E, s, st) ==
    IF Sec(s) \in E /\ s > LastReset(E) /\ st.c < MaxCycles
      THEN IF st.el + 1 >= DurAt(E, s)
             THEN [c |-> st.c + 1, el |-> 0]
             ELSE [c |-> st.c, el |-> st.el + 1]
      ELSE st

RECURSIVE Run(_, _)
Run(E, s) == IF s = 0 THEN [c |-> 0, el |-> 0] ELSE Step(E, s, Run(E, s - 1))

Timer(E) == Run(E, MaxTime)            \* cycles elapsed and time in the current cycle
Grey(E) == 10 * Timer(E).c             \* percentage of grey (F-024)
UsageTime(E) == Cardinality({e \in E : e.type = "sec"})   \* E-15, in seconds

AllSent == \A p \in Phones : outbox[p] = {}

TypeOK ==
    /\ now \in 0..MaxTime
    /\ fg \in [Phones -> BOOLEAN]
    /\ online \in [Phones -> BOOLEAN]
    /\ outbox \in [Phones -> SUBSET Events]
    /\ log \subseteq Events
    /\ made \subseteq Events
    /\ fgCount \in 0..MaxTime

\* A new account's timer is stopped, with no cycle elapsed (D-114).
Init ==
    /\ now = 0
    /\ fg = [p \in Phones |-> FALSE]
    /\ online \in [Phones -> BOOLEAN]
    /\ outbox = [p \in Phones |-> {}]
    /\ log = {}
    /\ made = {}
    /\ fgCount = 0
    /\ lastDur = [t |-> 0, p |-> 0, d |-> DefaultDuration]

\* One second passes. Each phone in the foreground notes it, online or not (D-117).
Tick ==
    /\ now < MaxTime
    /\ now' = now + 1
    /\ LET s == now + 1
           F == {p \in Phones : fg[p]}
       IN /\ outbox' = [p \in Phones |-> IF p \in F THEN outbox[p] \cup {Sec(s)} ELSE outbox[p]]
          /\ made' = IF F # {} THEN made \cup {Sec(s)} ELSE made
          /\ fgCount' = IF F # {} THEN fgCount + 1 ELSE fgCount
    /\ UNCHANGED <<fg, online, log, lastDur>>

\* The app comes to the foreground, or leaves it (closed, background, F-071).
SwitchForeground(p) ==
    /\ fg' = [fg EXCEPT ![p] = ~@]
    /\ UNCHANGED <<now, online, outbox, log, made, fgCount, lastDur>>

GoOnline(p) ==
    /\ ~online[p]
    /\ online' = [online EXCEPT ![p] = TRUE]
    /\ UNCHANGED <<now, fg, outbox, log, made, fgCount, lastDur>>

GoOffline(p) ==
    /\ online[p]
    /\ online' = [online EXCEPT ![p] = FALSE]
    /\ UNCHANGED <<now, fg, outbox, log, made, fgCount, lastDur>>

CanSet(p) ==
    /\ fg[p]                                       \* on P-17, so the app is open
    /\ Cardinality({e \in made : IsSetting(e)}) < MaxSettings
    /\ ~\E e \in made : IsSetting(e) /\ e.t = now /\ e.p = p

\* F-060: applied on the phone at once, then sent without a message (D-076, D-077).
SetDuration(p, d) ==
    /\ CanSet(p)
    /\ LET e == Ev("dur", now, p, d)
       IN /\ outbox' = [outbox EXCEPT ![p] = @ \cup {e}]
          /\ made' = made \cup {e}
          /\ lastDur' = IF Later(e, lastDur) THEN [t |-> now, p |-> p, d |-> d] ELSE lastDur
    /\ UNCHANGED <<now, fg, online, log, fgCount>>

\* F-061: back to no cycle elapsed, 0 % grey (D-077).
Reset(p) ==
    /\ CanSet(p)
    /\ LET e == Ev("reset", now, p, 0)
       IN /\ outbox' = [outbox EXCEPT ![p] = @ \cup {e}]
          /\ made' = made \cup {e}
    /\ UNCHANGED <<now, fg, online, log, fgCount, lastDur>>

\* FL-12: one waiting event reaches the server, in any order.
Deliver(p) ==
    /\ online[p]
    /\ \E e \in outbox[p] :
          /\ log' = log \cup {e}
          /\ outbox' = [outbox EXCEPT ![p] = @ \ {e}]
    /\ UNCHANGED <<now, fg, online, made, fgCount, lastDur>>

Next ==
    \/ Tick
    \/ \E p \in Phones :
          \/ SwitchForeground(p) \/ GoOnline(p) \/ GoOffline(p)
          \/ Reset(p) \/ Deliver(p)
          \/ \E d \in Durations : SetDuration(p, d)

\* The network comes back, and FL-12 sends whenever it can (D-112).
Fairness == \A p \in Phones : WF_vars(GoOnline(p)) /\ SF_vars(Deliver(p))

Spec == Init /\ [][Next]_vars /\ Fairness

-----------------------------------------------------------------------------
(* Rules, from the table "Modèles TLA+" of the Conception système.         *)

\* 10 % of grey per cycle elapsed, at most MaxCycles cycles, on the server and in
\* the true history (F-024).
D024_GreyTenPercentPerCycle ==
    \A E \in {log, made} :
        /\ Timer(E).c \in 0..MaxCycles
        /\ Grey(E) \in 0..(10 * MaxCycles)

\* Two phones never make a second count twice: the server never has more
\* seconds than have passed (D-105).
D105_SecondCountedOnce == UsageTime(log) <= now

\* Once every phone has sent what waits, the server's usage time is exactly the
\* seconds with at least one phone in the foreground, offline ones included (D-105, D-117).
D105_D117_UsageIsForegroundTime ==
    /\ UsageTime(made) = fgCount
    /\ AllSent => UsageTime(log) = fgCount

\* Once everything is sent, the duration in force is the one chosen last by the
\* phones' time, whatever the order of arrival, and the server's timer is the one
\* of the true history (D-111, D-117).
D111_LatestChangeWins ==
    AllSent =>
        /\ DurAt(log, MaxTime + 1) = lastDur.d
        /\ Timer(log) = Timer(made)

\* Every waiting event ends on the server: settings (D-077) and offline seconds (D-117).
D077_D117_EverythingEndsRecorded == <>[]AllSent
====
