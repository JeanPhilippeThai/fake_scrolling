---- MODULE SM_E_04 ----
(***************************************************************************)
(* SM-E-04 Média, chosen for a model by D-124 (completing D-107).          *)
(* Diagram and rules: "Conception système", section SM-E-04, flows FL-03,  *)
(* FL-11, FL-12 and FL-14, table "Modèles TLA+".                           *)
(*                                                                         *)
(* One account, one phone, one draft. A seed leaves the phone as soon as   *)
(* its photo is chosen (D-120), or waits for the network in FL-12 (D-122). *)
(* It crosses the removal of its photo or the loss of its draft (D-121),   *)
(* the erase that waits in FL-12 (D-122), the cleanup of seeds left for    *)
(* 24 h (FL-14, D-123) and the publication (F-051). The profile photo's    *)
(* seeds go through FL-12 (D-100), and a new one erases the old (D-125).   *)
(* Time is abstract: MaxAge ticks stand for 24 h. The queue of FL-12 is    *)
(* not ordered here, so every order of arrival is checked (sync.tla checks *)
(* the queue itself). Rules are named after their decisions until their BR *)
(* exist.                                                                  *)
(***************************************************************************)
EXTENDS Naturals, Sequences, FiniteSets

CONSTANTS
    Seeds,     \* the photos the draft can choose, each chosen once
    Profiles,  \* the profile photos the account can choose, each chosen once
    NoPhoto,   \* no profile photo yet
    MaxAge     \* ticks before FL-14 erases a seed nothing took (24 h, D-123)

SeedStates == {"absent", "draft", "attached"}

VARIABLES
    alive,       \* the account exists (F-063, D-101)
    net,         \* the phone has the network
    draft,       \* the draft on the phone: "open", "published" or "gone"
    chosen,      \* photos in the draft now (F-044, F-046)
    used,        \* photos already chosen once
    waitSeed,    \* seeds waiting on the phone to be sent (FL-12, D-122)
    waitErase,   \* seed erases waiting on the phone (FL-12, D-122)
    server,      \* server[s]: the seed on the server (E-04)
    age,         \* age[s]: ticks since the seed arrived (D-123)
    post,        \* seeds of the published post or story
    profile,     \* the profile photo on the phone (F-058)
    usedP,       \* profile photos already chosen once
    queueP,      \* profile photo seeds waiting, oldest first (FL-12, D-100)
    serverP,     \* serverP[p]: the profile photo seed on the server
    abandoned,   \* ghost: photos removed, or whose draft is gone, never to be published
    neverSent    \* ghost: seeds dropped on the phone before they left it

vars == <<alive, net, draft, chosen, used, waitSeed, waitErase, server, age,
          post, profile, usedP, queueP, serverP, abandoned, neverSent>>

TypeOK ==
    /\ alive \in BOOLEAN
    /\ net \in BOOLEAN
    /\ draft \in {"open", "published", "gone"}
    /\ chosen \subseteq Seeds
    /\ used \subseteq Seeds
    /\ waitSeed \subseteq Seeds
    /\ waitErase \subseteq Seeds
    /\ server \in [Seeds -> SeedStates]
    /\ age \in [Seeds -> 0..MaxAge]
    /\ post \subseteq Seeds
    /\ profile \in Profiles \cup {NoPhoto}
    /\ usedP \subseteq Profiles
    /\ queueP \in Seq(Profiles)
    /\ serverP \in [Profiles -> {"absent", "attached"}]
    /\ abandoned \subseteq Seeds
    /\ neverSent \subseteq Seeds

Init ==
    /\ alive = TRUE
    /\ net \in BOOLEAN
    /\ draft = "open"
    /\ chosen = {}
    /\ used = {}
    /\ waitSeed = {}
    /\ waitErase = {}
    /\ server = [s \in Seeds |-> "absent"]
    /\ age = [s \in Seeds |-> 0]
    /\ post = {}
    /\ profile = NoPhoto
    /\ usedP = {}
    /\ queueP = <<>>
    /\ serverP = [p \in Profiles |-> "absent"]
    /\ abandoned = {}
    /\ neverSent = {}

\* The server erases a seed of a draft; an erase that comes too late is
\* refused for good and changes nothing (D-113, D-122).
EraseOnServer(srv, S) ==
    [s \in Seeds |-> IF s \in S /\ srv[s] = "draft" THEN "absent" ELSE srv[s]]

\* F-044, F-046: a photo is chosen or taken; its seed leaves at once, or waits
\* for the network (D-120, D-122).
Choose(s) ==
    /\ alive
    /\ draft = "open"
    /\ s \notin used
    /\ used' = used \cup {s}
    /\ chosen' = chosen \cup {s}
    /\ IF net
       THEN /\ server' = [server EXCEPT ![s] = "draft"]
            /\ age' = [age EXCEPT ![s] = 0]
            /\ UNCHANGED waitSeed
       ELSE /\ waitSeed' = waitSeed \cup {s}
            /\ UNCHANGED <<server, age>>
    /\ UNCHANGED <<alive, net, draft, waitErase, post, profile, usedP, queueP,
                   serverP, abandoned, neverSent>>

\* F-044: a photo is removed from the draft. A seed not sent yet never is;
\* a sent one is erased, at once or through FL-12 (D-121, D-122).
Remove(s) ==
    /\ alive
    /\ draft = "open"
    /\ s \in chosen
    /\ chosen' = chosen \ {s}
    /\ abandoned' = abandoned \cup {s}
    /\ IF s \in waitSeed
       THEN /\ waitSeed' = waitSeed \ {s}
            /\ neverSent' = neverSent \cup {s}
            /\ UNCHANGED <<server, waitErase>>
       ELSE /\ IF net
               THEN /\ server' = EraseOnServer(server, {s})
                    /\ UNCHANGED waitErase
               ELSE /\ waitErase' = waitErase \cup {s}
                    /\ UNCHANGED server
            /\ UNCHANGED <<waitSeed, neverSent>>
    /\ UNCHANGED <<alive, net, draft, used, age, post, profile, usedP, queueP, serverP>>

\* F-005.a "Fermer": the draft is abandoned; the same as removing every photo (D-121).
Close ==
    /\ alive
    /\ draft = "open"
    /\ LET sent == chosen \ waitSeed IN
       /\ IF net
          THEN /\ server' = EraseOnServer(server, sent)
               /\ UNCHANGED waitErase
          ELSE /\ waitErase' = waitErase \cup sent
               /\ UNCHANGED server
    /\ draft' = "gone"
    /\ chosen' = {}
    /\ abandoned' = abandoned \cup chosen
    /\ waitSeed' = waitSeed \ chosen
    /\ neverSent' = neverSent \cup (waitSeed \cap chosen)
    /\ UNCHANGED <<alive, net, used, age, post, profile, usedP, queueP, serverP>>

\* The draft is lost without "Fermer" (app killed, phone off): waiting seeds are
\* never sent, sent ones are left to FL-14 (D-122, D-123).
Lose ==
    /\ alive
    /\ draft = "open"
    /\ draft' = "gone"
    /\ chosen' = {}
    /\ abandoned' = abandoned \cup chosen
    /\ waitSeed' = waitSeed \ chosen
    /\ neverSent' = neverSent \cup (waitSeed \cap chosen)
    /\ UNCHANGED <<alive, net, used, waitErase, server, age, post, profile, usedP,
                   queueP, serverP>>

\* F-051, recorded by the server: waiting seeds go with the publication
\* (D-120), seeds the server no longer has are sent again (D-123), and every
\* seed of the draft is attached. A failed publication (P-13.b) changes nothing.
Publish ==
    /\ alive
    /\ net
    /\ draft = "open"
    /\ chosen # {}
    /\ draft' = "published"
    /\ post' = chosen
    /\ chosen' = {}
    /\ waitSeed' = waitSeed \ chosen
    /\ server' = [s \in Seeds |-> IF s \in chosen THEN "attached" ELSE server[s]]
    /\ UNCHANGED <<alive, net, used, waitErase, age, profile, usedP, queueP,
                   serverP, abandoned, neverSent>>

\* FL-12 sends a waiting seed (D-122).
SendSeed(s) ==
    /\ alive
    /\ net
    /\ s \in waitSeed
    /\ waitSeed' = waitSeed \ {s}
    /\ server' = [server EXCEPT ![s] = "draft"]
    /\ age' = [age EXCEPT ![s] = 0]
    /\ UNCHANGED <<alive, net, draft, chosen, used, waitErase, post, profile, usedP,
                   queueP, serverP, abandoned, neverSent>>

\* FL-12 sends a waiting erase; after FL-14 it is refused for good (D-113, D-122).
SendErase(s) ==
    /\ alive
    /\ net
    /\ s \in waitErase
    /\ waitErase' = waitErase \ {s}
    /\ server' = EraseOnServer(server, {s})
    /\ UNCHANGED <<alive, net, draft, chosen, used, waitSeed, age, post, profile,
                   usedP, queueP, serverP, abandoned, neverSent>>

\* Time passes for every seed nothing took.
Tick ==
    /\ \E s \in Seeds : server[s] = "draft" /\ age[s] < MaxAge
    /\ age' = [s \in Seeds |-> IF server[s] = "draft" /\ age[s] < MaxAge
                               THEN age[s] + 1 ELSE age[s]]
    /\ UNCHANGED <<alive, net, draft, chosen, used, waitSeed, waitErase, server, post,
                   profile, usedP, queueP, serverP, abandoned, neverSent>>

\* FL-14: 24 h after its arrival, a seed nothing took is erased (D-123).
Cleanup(s) ==
    /\ server[s] = "draft"
    /\ age[s] = MaxAge
    /\ server' = [server EXCEPT ![s] = "absent"]
    /\ UNCHANGED <<alive, net, draft, chosen, used, waitSeed, waitErase, age, post,
                   profile, usedP, queueP, serverP, abandoned, neverSent>>

\* F-058: a new profile photo shows at once on the phone; its seed waits in FL-12 (D-100).
ChangeProfile(p) ==
    /\ alive
    /\ p \notin usedP
    /\ usedP' = usedP \cup {p}
    /\ profile' = p
    /\ queueP' = Append(queueP, p)
    /\ UNCHANGED <<alive, net, draft, chosen, used, waitSeed, waitErase, server, age,
                   post, serverP, abandoned, neverSent>>

\* FL-12 sends the oldest profile photo seed; once recorded, the seed of the
\* photo before it is erased (D-100, D-125).
SendProfile ==
    /\ alive
    /\ net
    /\ queueP # <<>>
    /\ LET p == Head(queueP) IN
       serverP' = [q \in Profiles |-> IF q = p THEN "attached" ELSE "absent"]
    /\ queueP' = Tail(queueP)
    /\ UNCHANGED <<alive, net, draft, chosen, used, waitSeed, waitErase, server, age,
                   post, profile, usedP, abandoned, neverSent>>

NetUp ==
    /\ ~net
    /\ net' = TRUE
    /\ UNCHANGED <<alive, draft, chosen, used, waitSeed, waitErase, server, age, post,
                   profile, usedP, queueP, serverP, abandoned, neverSent>>

NetDown ==
    /\ net
    /\ net' = FALSE
    /\ UNCHANGED <<alive, draft, chosen, used, waitSeed, waitErase, server, age, post,
                   profile, usedP, queueP, serverP, abandoned, neverSent>>

\* F-063: every media of the account and everything waiting for it go at once (D-101).
DeleteAccount ==
    /\ alive
    /\ alive' = FALSE
    /\ draft' = IF draft = "open" THEN "gone" ELSE draft
    /\ chosen' = {}
    /\ waitSeed' = {}
    /\ waitErase' = {}
    /\ server' = [s \in Seeds |-> "absent"]
    /\ queueP' = <<>>
    /\ serverP' = [p \in Profiles |-> "absent"]
    /\ UNCHANGED <<net, used, age, post, profile, usedP, abandoned, neverSent>>

Next ==
    \/ Close \/ Lose \/ Publish \/ Tick \/ SendProfile \/ NetUp \/ NetDown
    \/ DeleteAccount
    \/ \E s \in Seeds :
          \/ Choose(s) \/ Remove(s) \/ SendSeed(s) \/ SendErase(s) \/ Cleanup(s)
    \/ \E p \in Profiles : ChangeProfile(p)

\* The network always comes back. FL-12 keeps sending whenever it is there, even
\* if it comes and goes; the server's clock and FL-14 always run.
Fairness ==
    /\ WF_vars(NetUp)
    /\ \A s \in Seeds : SF_vars(SendSeed(s)) /\ SF_vars(SendErase(s))
    /\ \A s \in Seeds : WF_vars(Cleanup(s))
    /\ SF_vars(SendProfile)
    /\ WF_vars(Tick)

Spec == Init /\ [][Next]_vars /\ Fairness

-----------------------------------------------------------------------------
(* Rules, from the table "Modèles TLA+" of the Conception système.         *)

\* A published post or story always has the seeds of its art, even when FL-14
\* erased them before the publication (D-120, D-123).
D120_D123_PublishedHasArt ==
    (alive /\ draft = "published") => \A s \in post : server[s] = "attached"

\* A removed photo, or a photo of a lost draft, is never attached to anything (D-121).
D121_AbandonedNeverAttached == \A s \in abandoned : server[s] # "attached"

\* A seed dropped on the phone before it left never reaches the server (D-121, D-122).
D122_DroppedNeverSent == \A s \in neverSent : s \notin waitSeed /\ server[s] = "absent"

\* An erase that waits never targets a published seed (D-121, D-122).
D122_EraseNeverHitsPublished == waitErase \cap post = {}

\* The server holds at most one profile photo seed (D-125).
D125_OneProfilePhoto == Cardinality({p \in Profiles : serverP[p] = "attached"}) <= 1

\* Once nothing waits, the server holds the phone's profile photo (D-100, D-125).
D100_D125_ProfileIsCurrent ==
    (alive /\ queueP = <<>> /\ profile # NoPhoto) => serverP[profile] = "attached"

\* After F-063, nothing of the account is left, on the server or the phone (D-101).
D101_NothingAfterDeletion ==
    ~alive =>
        /\ \A s \in Seeds : server[s] = "absent"
        /\ \A p \in Profiles : serverP[p] = "absent"
        /\ waitSeed = {} /\ waitErase = {} /\ queueP = <<>>

\* A seed of a photo that will not be published ends erased (D-121, D-122, D-123) ...
D121_AbandonedEndsErased ==
    \A s \in Seeds : (s \in abandoned) ~> (server[s] = "absent" /\ s \notin waitErase)

\* ... and never comes back.
D121_ErasedStaysErased ==
    [][\A s \in abandoned : server[s] = "absent" => server'[s] = "absent"]_vars

\* No seed stays on the server unattached: FL-14 erases it (D-123).
D123_NoOrphanForever == \A s \in Seeds : (server[s] = "draft") ~> (server[s] # "draft")

\* A profile photo seed that waits ends recorded, or dropped with the account (D-100, D-101).
D100_ProfileQueueEnds == <>[](queueP = <<>>)
====
