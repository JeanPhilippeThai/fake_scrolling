---- MODULE SM_E_12 ----
(***************************************************************************)
(* SM-E-12 Story, chosen for a model by D-107.                             *)
(* Diagram and rules: "Conception système", section SM-E-12, flows FL-06   *)
(* and FL-13, table "Modèles TLA+".                                        *)
(*                                                                         *)
(* One story by its author, seen by a few accounts. The end at 24 h        *)
(* (FL-13) crosses the "vue" sent later without a message (D-078, FL-12).  *)
(* Time is abstract: the end can come at any moment after the story is     *)
(* recorded. Rules are named after their decisions until their BR exist.   *)
(***************************************************************************)
EXTENDS FiniteSets

CONSTANT Viewers

Statuses == {"publishing", "failed", "live", "finished", "erased"}
Audiences == {"amis", "amis_proches"}

VARIABLES
    status,      \* the story on the server (E-12)
    audience,    \* chosen in the draft (F-050); "Tout le monde" shows it like "amis" (D-080)
    friend,      \* friend[v]: v is a friend of the author (E-09)
    close,       \* close[v]: the author ticked v as a close friend (D-060)
    viewerAlive, \* viewerAlive[v]: v's account exists
    watching,    \* watching[v]: P-10 is open on v's phone
    shown,       \* shown[v]: at least one image was shown in this opening
    pending,     \* viewers whose "vue" waits on their phone (FL-12)
    seenBy,      \* "vue par" on the server (E-12, D-078)
    closedSeen   \* ghost: viewers who closed P-10 after an image was shown

vars == <<status, audience, friend, close, viewerAlive, watching, shown,
          pending, seenBy, closedSeen>>

TypeOK ==
    /\ status \in Statuses
    /\ audience \in Audiences
    /\ friend \in [Viewers -> BOOLEAN]
    /\ close \in [Viewers -> BOOLEAN]
    /\ viewerAlive \in [Viewers -> BOOLEAN]
    /\ watching \in [Viewers -> BOOLEAN]
    /\ shown \in [Viewers -> BOOLEAN]
    /\ pending \subseteq Viewers
    /\ seenBy \subseteq Viewers
    /\ closedSeen \subseteq Viewers

\* Who can open the story now (D-080).
CanSee(v) ==
    /\ viewerAlive[v]
    /\ friend[v]
    /\ (audience = "amis_proches" => close[v])

Init ==
    /\ status = "publishing"
    /\ audience \in Audiences
    /\ friend \in [Viewers -> BOOLEAN]
    /\ close \in {c \in [Viewers -> BOOLEAN] : \A v \in Viewers : c[v] => friend[v]}
    /\ viewerAlive = [v \in Viewers |-> TRUE]
    /\ watching = [v \in Viewers |-> FALSE]
    /\ shown = [v \in Viewers |-> FALSE]
    /\ pending = {}
    /\ seenBy = {}
    /\ closedSeen = {}

\* F-051 with "Story": publishing fails, is retried, or is recorded (D-027, D-031, D-079).
Fail ==
    /\ status = "publishing"
    /\ status' = "failed"
    /\ UNCHANGED <<audience, friend, close, viewerAlive, watching, shown, pending, seenBy, closedSeen>>

Retry ==
    /\ status = "failed"
    /\ status' = "publishing"
    /\ UNCHANGED <<audience, friend, close, viewerAlive, watching, shown, pending, seenBy, closedSeen>>

Record ==
    /\ status = "publishing"
    /\ status' = "live"
    /\ UNCHANGED <<audience, friend, close, viewerAlive, watching, shown, pending, seenBy, closedSeen>>

\* F-036: v opens P-10; the server only serves a live story to its audience.
Open(v) ==
    /\ status = "live"
    /\ CanSee(v)
    /\ ~watching[v]
    /\ watching' = [watching EXCEPT ![v] = TRUE]
    /\ shown' = [shown EXCEPT ![v] = FALSE]
    /\ UNCHANGED <<status, audience, friend, close, viewerAlive, pending, seenBy, closedSeen>>

ShowImage(v) ==
    /\ watching[v]
    /\ ~shown[v]
    /\ shown' = [shown EXCEPT ![v] = TRUE]
    /\ UNCHANGED <<status, audience, friend, close, viewerAlive, watching, pending, seenBy, closedSeen>>

\* v closes P-10 (cross or end). With an image shown, the circle greys at once and
\* the "vue" waits to be sent; without one (P-10.b), the story stays unseen (D-078).
CloseReader(v) ==
    /\ watching[v]
    /\ watching' = [watching EXCEPT ![v] = FALSE]
    /\ shown' = [shown EXCEPT ![v] = FALSE]
    /\ IF shown[v]
         THEN /\ pending' = pending \cup {v}
              /\ closedSeen' = closedSeen \cup {v}
         ELSE UNCHANGED <<pending, closedSeen>>
    /\ UNCHANGED <<status, audience, friend, close, viewerAlive, seenBy>>

\* FL-12: the "vue" reaches the server. Recorded on a live story; refused for good
\* once the story is finished or erased, and dropped without a message (D-110, D-113).
SendVue(v) ==
    /\ v \in pending
    /\ viewerAlive[v]
    /\ pending' = pending \ {v}
    /\ seenBy' = IF status = "live" THEN seenBy \cup {v} ELSE seenBy
    /\ UNCHANGED <<status, audience, friend, close, viewerAlive, watching, shown, closedSeen>>

\* FL-13: 24 h after publication the story is finished, then erased at once (D-079, D-110).
Finish ==
    /\ status = "live"
    /\ status' = "finished"
    /\ UNCHANGED <<audience, friend, close, viewerAlive, watching, shown, pending, seenBy, closedSeen>>

Erase ==
    /\ status = "finished"
    /\ status' = "erased"
    /\ seenBy' = {}
    /\ UNCHANGED <<audience, friend, close, viewerAlive, watching, shown, pending, closedSeen>>

\* F-063 by the author: the story goes with the account (D-101).
DeleteAuthor ==
    /\ status # "erased"
    /\ status' = "erased"
    /\ seenBy' = {}
    /\ UNCHANGED <<audience, friend, close, viewerAlive, watching, shown, pending, closedSeen>>

\* The author's friends and close friends change meanwhile (F-028, F-034, F-072).
Befriend(v) ==
    /\ viewerAlive[v]
    /\ ~friend[v]
    /\ friend' = [friend EXCEPT ![v] = TRUE]
    /\ UNCHANGED <<status, audience, close, viewerAlive, watching, shown, pending, seenBy, closedSeen>>

ToggleClose(v) ==
    /\ friend[v]
    /\ close' = [close EXCEPT ![v] = ~@]
    /\ UNCHANGED <<status, audience, friend, viewerAlive, watching, shown, pending, seenBy, closedSeen>>

\* F-063 by a viewer: its "vue", waiting or recorded, goes with it (D-101, D-109).
DeleteViewer(v) ==
    /\ viewerAlive[v]
    /\ viewerAlive' = [viewerAlive EXCEPT ![v] = FALSE]
    /\ friend' = [friend EXCEPT ![v] = FALSE]
    /\ close' = [close EXCEPT ![v] = FALSE]
    /\ watching' = [watching EXCEPT ![v] = FALSE]
    /\ shown' = [shown EXCEPT ![v] = FALSE]
    /\ pending' = pending \ {v}
    /\ seenBy' = seenBy \ {v}
    /\ UNCHANGED <<status, audience, closedSeen>>

Next ==
    \/ Fail \/ Retry \/ Record \/ Finish \/ Erase \/ DeleteAuthor
    \/ \E v \in Viewers :
          \/ Open(v) \/ ShowImage(v) \/ CloseReader(v) \/ SendVue(v)
          \/ Befriend(v) \/ ToggleClose(v) \/ DeleteViewer(v)

\* FL-12 keeps sending a waiting "vue"; FL-13 runs on the server.
Fairness ==
    /\ \A v \in Viewers : WF_vars(SendVue(v))
    /\ WF_vars(Erase)

Spec == Init /\ [][Next]_vars /\ Fairness

-----------------------------------------------------------------------------
(* Rules, from the table "Modèles TLA+" of the Conception système.         *)

\* Once finished, a story never opens again, even when a "vue" arrives later (D-078, D-079).
D079_FinishedNeverReopens ==
    [](status \in {"finished", "erased"} => [](status \in {"finished", "erased"}))

\* P-10 only opens for the story's audience at that moment (D-080).
D080_OpensOnlyForAudience ==
    [][\A v \in Viewers : (~watching[v] /\ watching'[v]) => CanSee(v)]_vars

\* "Vue par" only holds accounts that closed P-10 after an image (D-078).
D078_SeenOnlyAfterAnImage == seenBy \subseteq closedSeen

\* An erased story keeps nothing: neither its images nor its "vue par" (D-110).
D110_ErasedKeepsNothing == status = "erased" => seenBy = {}

\* A finished story is erased (D-110).
D110_FinishedIsErased == (status = "finished") ~> (status = "erased")

\* A deleted viewer leaves no "vue", waiting or recorded (D-101, D-109).
D101_DeletedViewerLeavesNothing ==
    \A v \in Viewers : ~viewerAlive[v] => (v \notin pending /\ v \notin seenBy)

\* A waiting "vue" always ends: recorded, or dropped once the story is gone (D-108, D-113).
D113_WaitingVueEnds == \A v \in Viewers : (v \in pending) ~> (v \notin pending)
====
