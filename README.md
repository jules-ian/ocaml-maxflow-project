# OcamlCorp Cybersecurity Project

In this project, we developped a Ford Fulkerson algorithm to maximize the flow in a graph, in order to optimize our response in the event of a cyberattack (medium project).

**Story** : *Several OcamlCorp site have been targeted by cyber-attacks of various kinds.
Fortunately, the INSA Toulouse ClubInfo has "cyber security prodigies" in various fields and many other equally effective people. 
Each site (called local in the rest of the project) can receive help from several people (depending on the criticality of the attack) specialized in the type of cyber-attack it has received (web, reverse, pwn, osint, misc, social-engineering...).
Each person can only go to 1 local.
Each person can have several specialties. (Except for Baptiste, who only works on the web).
What is the configuration that allows us to send the most people from the club to work on resolving security flaws?*


# Table of Contents

- [Project Structure](#project-structure)
- [Usage](#usage)
- [Example Input File](#example-input-file)
- [Build and Run](#build-and-run)

# Project Structure

- `tools.ml`: Contains some data structures and functions which are used to perform miscellaneous tasks.
- `fordFulkerson.ml`: Contains the data structures and functions used to perform the Ford Fulkerson algorithm.
- `securityProblem.ml`: Contains the data structures and functions related to the OcamlCorp cybersecurity scenario.
- `bipartite_example2.txt`: An example input file for the OcamlCorp scenario.

# Usage

To use this project, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/jules-ian/ocaml-maxflow-project.git
    ```bash

2. Build the project:
    ```bash
    make
    ```bash

3. Watch the beautiful demo we made for you:
    ```bash
    make demo
    ```bash

4. Use the Ford Fulkerson algorithm on your graph :
    ```bash
    ./ftest.exe <path/to/your/graph.txt> <sourceNodeId> <sinkNodeId> <outputfile.txt>
    ```bash

# Example Input File

The bipartite_example2.txt.txt file serves as an example input file. It contains some locals and people declarations with the following syntax : 

```
# this is a comment : People skills must not contain any number
PersonName1, PersonSkillA, PersonSkillB
PersonName2, PersonSkillA, PersonSkillC

# this is another comment : The local capacity is an integer
LocalName1, LocalVulnerabilityA, LocalCapacity1
LocalName2, LocalVulnerabilityC, LocalCapacity2
```

you can test the bipartite matching algorithm with the provided example file with `make demo`
