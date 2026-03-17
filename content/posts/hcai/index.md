+++
title = 'Jo Flere, Jo Bedre'
subtitle = "Fremtidens AI er ikke én chatbot, men en deliberativ mini-offentlighed"
date = 2026-03-17T21:15:48+01:00
updated = 2026-03-18T16:15:00+01:00
draft = true
+++

![Plurals er en digital mini-offentlighed, hvor forskellige LLM-agenter delibererer gennem tilpassede strukturer.](YutongLiu-DigitDigitalNomads%20Across%20Time-2560x1440.png "Plurals er en digital mini-offentlighed, hvor forskellige LLM-agenter delibererer gennem tilpassede strukturer for at undslippe et neutralt ingenmandsblik. Kilde: Yutong Liu & Digit, betterimagesofai.org, CC BY 4.0")

Forestil dig, at du vil sende en e-mail til alle dine kollegaer på arbejdet og sender dit udkast til ChatGPT for at få feedback. Den giver sandsynligvis et høfligt og neutralt svar, noget man kunne kalde et ingenmandsblik. Men der er et problem. Mennesker er sjældent neutrale. Vi er forskellige i vores værdier, livserfaringer og bekymringer, og et neutralt LLM-svar kan have svært ved at mægle mellem de forskelle.

I 2025 introducerede Joshua Ashkinaze sammen med kollegaer fra University of Michigan Plurals, et system der simulerer et socialt ensemble for at modvirke dette ingenmandsblik. I stedet for kun at bruge én generalistmodel til at finde svaret, skaber Plurals et digitalt rum med mange forskellige personaer, som delibererer for at nå frem til et bedre svar. Vi skal se på, hvad systemet gør, hvordan det forbedrer eksisterende praksis, og hvilke begrænsninger det har.

Som nævnt arbejder Plurals med forskellige personaer. En måde at skabe dem på er via American National Election Studies (ANES), som er integreret i systemet og bruges til at give agenterne personaer. I stedet for blot at bede en LLM om at opføre sig som for eksempel liberal, udtrækker systemet reelle data fra ANES om alder, geografi og politiske holdninger for at skabe personaer med dybde.

I en test fandt forskerne, at brugen af disse dybe personaer reducerede outputkollaps, altså tendensen til at LLM'er leverer de samme, konsistente og sikre svar igen og igen. Når agenterne fik en detaljeret baggrund, blev outputtet langt mere varieret og repræsentativt.


![Strukturerne i Plurals: Chain, Graph, Debate og Ensemble.](plurals_structures.png "Strukturerne implementeret i Plurals. (Ashkinaze et al. 2025)")

Plurals er mere end bare agenter og deres personaer. Systemet giver mulighed for forskellige former for deliberation mellem agenterne, kaldet Structures. Der er implementeret en række strukturer, men systemets modularitet gør det muligt at implementere nye, hvis man har den tekniske kunnen. I chain-strukturen ses agenterne som led i en kæde, hvor deliberationen bevæger sig sekventielt gennem leddene med mulighed for at randomisere rækkefølgen mellem runder.

Deliberationen overvåges af en Moderator, som endda kan være en Auto-Moderator, der selv genererer instruktioner ud fra opgaven. Målet er at samle gruppens deliberation i et endeligt output, som bliver Plurals-systemets svar.

For at teste om gruppen af agenter overgik en enkelt LLM, gennemførte holdet flere casestudier. De bad Plurals om at generere markedsføringsidéer til solpaneler, der skulle appellere til konservative vælgere. En enkelt LLM-prompt lænede sig ofte op ad stereotyper, for eksempel henvisninger til militærveteraner. Plurals-agenterne, som simulerede faktiske konservative bekymringer, fokuserede derimod på praktiske forhold som holdbarhed i landlige vejrforhold. Menneskelige evaluatorer skulle vælge mellem de to typer svar og valgte Plurals-outputtet frem for standard zero-shot-svar i 75 % af forsøgene på tværs af tre domæner.

Plurals er ikke kun bedre til tekstproduktion, men tilbyder også en ny måde at håndtere LLM-sikkerhed på. I stedet for et black-box-filter kan brugere skabe styrbare moderatorer baseret på konkrete værdier, for eksempel at undgå miljømæssig eller fysisk skade. I tests var disse moderatorer 91 % præcise i at afvise skadelige opgaver ud fra sådanne tilpassede værdisæt.

Plurals er i øjeblikket tilgængeligt som open source Python-bibliotek på GitHub. Det er ikke tænkt som en erstatning for menneskelig deliberation, men som et stærkt værktøj for forskere og udviklere, der vil bygge AI-systemer, som bruger kompleksiteten i menneskelige perspektiver i stedet for at udjævne dem.

Du kan selv prøve systemet via Quick Start-guiden på [deres GitHub](https://github.com/josh-ashkinaze/plurals). Det kan også anbefales at læse hele artiklen. Se

> Joshua Ashkinaze, Emily Fry, Narendra Edara, Eric Gilbert, and Ceren Budak. 2025. Plurals: A System for Guiding LLMs via Simulated Social Ensembles. In Proceedings of the 2025 CHI Conference on Human Factors in Computing Systems (CHI '25). Association for Computing Machinery, New York, NY, USA, Article 245, 1–21. https://doi.org/10.1145/3706598.3713675

Følgende video går mere i dybden med Plurals-systemet.

<!-- Mangler at finde linket, men der skal være en indlejret video. -->

*LLM'en Gemini Flash 3.1 (11/03-2026) blev brugt til at brainstorme struktur for denne tekst, rette grammatiske fejl og finde mindre heldige sætningskonstruktioner.*

*GPT-5.3-Codex (17/03-2026) gav et dansk udkast fra min engelske tekst. Jeg har tjekket at indholdet ikke er ændret, at tonen er uændret og rettet til.*