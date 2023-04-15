---
layout: page_toc
toc: true
order: 4
---

## Intro

My name is Thomas Bidne, and I am a software engineer with 10 years of professional experience. I have been writing code since I was 14, for both academic and personal reasons.

I write code nearly every day, whether it is paid work, open-source contributions, or just plain experimentation for fun 🙂.

## Education

**2009-2013: Bachelor of Science in Computer Science**

- University of Maryland, College Park
- College Park Scholars Graduate
- Minor in Astronomy
- Selected coursework:
  - Software Engineering
  - Networks
  - Algorithms and Data Structures
  - Cryptology
  - Number Theory

## Professional Experience

### 2020 - Present: Platonic.Systems

**Senior Software Engineer**

For **Platonic.Systems** I have worked with multiple clients. Below are short descriptions of the work I have done for each, in reverse chronological order.

0. Smart contracts

   My most recent work has been in the "smart-contract" space i.e. implementing financial systems that come with rigorous guarantees, for instance, that financial transactions are "atomic" i.e. either fully-complete or encounter some error.

1. Machine learning

   This client wanted a website that could make market predictions for their product line, based on sales data and machine learning. I created the website, including all of the UI and Microsoft Azure integration. This website was implemented in `python`, per the client's instructions.

2. API enhancements

   For this project I was tasked with improving the robustness of the client's software. In particular, the client has applications that communicated through various untyped APIs. This software was fragile in the sense that changes to an API in one place necessitated corresponding changes in another, yet there was nothing to verify the second updates had been made. This led to numerous bug reports and production issues.

   I led a small team that addressed this issue. We did this by porting the malleable portion of the APIs into Haskell. Haskell's static type system ensured that any changes made to one end of an API must also be accounted for at the other. We were able to integrate this statically typed Haskell code into the client's javascript codebase via `GhcJS`, a `haskell <-> javascript` compiler.

3. Supply-chain analysis

   For this client I worked on a full-stack Haskell web-application designed for monitoring and analyzing supply-chain risks. I implemented new features, fixed bugs, and improved performance in numerous areas.
   {: reversed="reversed"}

### 2016 - 2020: BridgePhase - USCIS, Washington D.C.

**Senior DevSecOps Engineer**

Supported the **Electronic Immigration System (ELIS)** for the **U.S. Citizenship and Immigration Services (USCIS)**. **ELIS** is a web-application that provides USCIS officers the ability to process cases corresponding to a person applying for a USCIS benefit (e.g. U.S. Citizenship, Permanent Resident).

The frontend is `AngularJS` and the backend is `Java/Spring` with an `Oracle` database. Continuous Integration/Development (CI/CD) utilizes **Jenkins**.

I maintained several microservices, utilizing:

- `Angular`/`Typescript`
- `PostgreSQL`
- `Docker`
- `Openshift`

Other responsibilities included:

- Maintaining a Red Hat Enterprise Linux virtual machine for automatic deployment/testing.
- Participating in multiple "tiger teams" for creating cross-team solutions to specialized problems.
- Coordinating production deployments and triaging build pipeline issues on a semi-regular basis.

### 2013 - 2016: GBL Systems - NAS Pax River, Patuxent MD

**Software Engineer**

Worked on the **Next Generation Threat System (NGTS)** for the U.S. Navy. **NGTS** is a real-time distributed simulation, modeling real-world aviation scenarios, primarily written in `C++` with `Qt`. Responsibilities included:

- Implementing network plugins using protocols such as TCP and UDP.
- Providing network support for new features (e.g. new planes, radar systems).
- Integrating **NGTS** with third party software. This included designing/implementing APIs and traveling to customer sites to provide support.

## Opensource Experience

My personal projects are on https://www.github.com/tbidne. These projects range from experiments, libraries for public consumption, and applications that I use every day.

Futhermore, I have made contributions to the following open-source communities.

### Haskell

I have contributed code to several well-known libraries such as:

- `criterion`
- `Glasgow Haskell Compiler (GHC)`
- `hashable`
- `katip`
- `liquidhaskell`
- `text`
- `unliftio`

Additionally, I participate in online discussions, such as the [ghc-proposals process](https://github.com/ghc-proposals/ghc-proposals), where changes to the language (`GHC`) are discussed.

### Nix

I have contributed several packages and bugfixes to [`nixpkgs`](https://github.com/NixOS/nixpkgs), a package manager for the `NixOS` linux operating system.

## Skills

- Programming languages
  - Haskell
  - Java
  - Java/Typescript
  - C++
  - Ruby
- Databases
  - Postgres
  - Oracle
  - SQLite
- DevOps
  - Nix
  - Docker
- CI/CD
  - Github Actions
  - Gitlab
  - Jenkins
- Operating Systems
  - Linux
  - OSX
  - Windows

## Contact

- <a href="javascript:location.href = 'mailto:' + ['tbidne','gmail.com'].join('@')" aria-label="email"> <i class="fas fa-envelope"></i></a>
- <a href="https://github.com/tbidne" aria-label="github" target="_blank" rel="noopener noreferrer"> <i class="fab fa-github"></i></a>
- <a href="https://www.linkedin.com/in/tbidne" aria-label="linkedin" target="_blank" rel="noopener noreferrer"> <i class="fab fa-linkedin"></i></a>
