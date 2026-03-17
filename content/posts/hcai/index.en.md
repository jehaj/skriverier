+++
title = 'The More the Merrier'
subtitle = "The Future of AI is not a Single Chatbot but a Deliberative Mini-Public"
date = 2026-03-17T21:15:48+01:00
updated = 2026-03-18T16:15:00+01:00
draft = true
+++

{{ $bigimage := .Resources.Get "YutongLiu-DigitDigitalNomads Across Time-2560x1440.png" }}
<img src="{{ $image.RelPermalink }}" width="{{ $image.Width }}" height="{{ $image.Height }}" alt="The Plurals Structures: Chain, Graph, Debate, and Ensemble.">
<!-- Caption: Plurals is a digital mini-public where diverse LLM agents deliberate through custom structures to escape the view from nowhere. (Yutong Liu & Digit / https://betterimagesofai.org / https://creativecommons.org/licenses/by/4.0/) -->

Imagine you want to send an e-mail to all your colleagues at work and send your draft to ChatGPT for a review. It probably provides a polite and neutral response, what might be called a view from nowhere. But there is a problem. Humans are rarely neutral. We differ in our values, life experiences, and concerns, and a neutral LLM response might fail to mediate those differences.

In 2025, Joshua Ashkinaze along with colleagues at University of Michigan introduced Plurals, a system that simulates a social ensemble to combat this view from nowhere. Instead of just using one generalist model to find the answer, Plurals creates a digital room with many different personas who deliberate in order to find a better answer. We are going to discuss what the system does, how it is an improvement and finally its limitations.

As mentioned Plurals has different personas. One way of getting these is by using the American National Election Studies (ANES), which is integrated in system, and used to provide personas to the agents. Rather than just telling an LLM to act like a liberal, the system samples actual data from ANES, ages, geographic regions and political stances to create personas with depth.

In one test, the researchers found that using these deep personas reduced output collapse, which is the tendency of LLMs to provide the same consistent and safe answers. Giving the agents a deep and detailed background resulted in the outputs that were far more diverse and representative.


{{ $image := .Resources.Get "plurals_structures.png" }}
<img src="{{ $image.RelPermalink }}" width="{{ $image.Width }}" height="{{ $image.Height }}" alt="The Plurals Structures: Chain, Graph, Debate, and Ensemble.">
The Structures implemented in Plurals. (Ashkinaze et al. 2025) <!-- Should be a caption for the figure -->

Plurals is more than just the agents and their personas. It allows for different kinds of deliberation between the agents (if any) which are called Structures. They have implemented some structures, but the modularity of the system allows for any structure to be implemented given the technical know-how. The chain structure views the agents as links of the chain and the deliberation moves in sequence of these links with the option of randomizing the order of agents between rounds.

The deliberation is supervised by a Moderator, which can even be an Auto-Moderator who generates its own instructions based on the task, and their objective is to unify the group of agents deliberation into a final output which becomes the output of the Plurals system.

To test if the group of agents outperformed a single LLM, the team conducted case studies. They asked Plurals to generate marketing ideas for solar panels that would appeal to conservatives. A single LLM prompt tended to lean on stereotypes, like mentioning military veterans. However, the agents from Plurals, who were simulating actual conservative concerns, focused on practicalities like rural weather durability. Human evaluators were asked to choose between the two and chose the Plurals-generated output over standard zero-shot LLM responses in 75% of trials across three different domains.

Plurals is not just better at writing, it also offers a new way to handle LLM safety. Instead of a black box filter, users can create steerable moderators based on specific values, such as avoiding environmental or physical harm. In tests, these moderators were 91% accurate in rejecting harmful tasks based on such custom value sets.

Plurals is currently available as an open-source Python library on GitHub. It is not meant to replace human deliberation, but it offers a powerful tool for researchers and developers to build AI systems that uses the complexity of human perspectives rather than trying to average them away.

You can try it out yourself by checking out the Quick Start guide at their GitHub. You might also want to read the paper in its entirety. See

> Joshua Ashkinaze, Emily Fry, Narendra Edara, Eric Gilbert, and Ceren Budak. 2025. Plurals: A System for Guiding LLMs via Simulated Social Ensembles. In Proceedings of the 2025 CHI Conference on Human Factors in Computing Systems (CHI '25). Association for Computing Machinery, New York, NY, USA, Article 245, 1–21. https://doi.org/10.1145/3706598.3713675

The following video provides a deeper dive into the Plurals system.

<!-- Need to find the link, but should be an embedded video. -->

*The LLM Gemini Flash 3.1 (11/03–2026) was used to brainstorm the structure of this piece, fix grammar issues and find less than ideal sentence structures.*