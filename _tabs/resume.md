---
layout: page_toc
toc: true
order: 4
---

## Introduction

My name is Thomas Bidne, and I am a software engineer with 10 years of professional experience. I have been writing code since I was 14, for both academic and personal reasons.

I write code most days, whether it is paid work, open-source contributions, or just plain experimentation for fun 🙂.

My programming experience is broad. Briefly, I have worked in the following areas:

- FinTech (with a heavy emphasis on correctness)
- Web programming:
  - Data processing and visualization
  - Applications modeling complex workflow
  - Personal websites
- Distributed simulations

This has required extensive usage of the following technologies:

- Programming languages: Haskell, Java, Java/Typescript, Python, C++.
- Web frameworks: Angular (JS), Node, React
- Databases: PostgreSQL, Oracle, SQLite
- DevOps: Nix, Docker, OpenShift
- CI/CD: Github Actions, Jenkins, Gitlab

See my [Professional Experience](#professional_experience) for more details.

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

4. Smart contracts

   My most recent work has been in the "smart-contract" space i.e. implementing financial systems that come with rigorous guarantees. This includes, for instance, maintaining system invariants e.g. that transactions are "atomic" i.e. either fully-complete or encounter some error. This work has primarily used Haskell and Nix, both with large, open-source projects (i.e. [cardano](<https://en.wikipedia.org/wiki/Cardano_(blockchain_platform)>)) and custom, private ones.

3. Data Visualization And Machine learning

   This client wanted a website that could make market predictions for their product line, based on sales data and machine learning. I designed and implemented the website, using Python and the [dash](https://plotly.com/dash/) data visualization framework, per the client's wishes. I also implemented the DevOps instances with Microsoft Azure.

2. API Correctness Enhancements

   For this project I was tasked with improving the robustness of the client's software. In particular, the client has applications that communicated through various untyped APIs. This software was fragile in the sense that changes to an API in one place necessitated corresponding changes in another, yet there was nothing to verify the second updates had been made. This led to numerous bug reports and production issues.

   I led a small team that addressed this issue. We did this by porting the mutable portion of the APIs into Haskell. Haskell's static type system ensured that any changes made to one end of an API must also be accounted for at the other. We were able to integrate this statically typed Haskell code into the client's javascript codebase via `GhcJS`, a `haskell <-> javascript` compiler.

   This project required considerable research on our part due to how niche haskell's web integration is. Despite those risks, we were able to satisfy the client's requests, and their systems are more robust as a result.

1. Supply-chain analysis

   For this client I worked on a full-stack Haskell web-application designed for monitoring and analyzing supply-chain risks. I implemented new features, fixed bugs, and improved performance in numerous areas.

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

{% assign projects_url = "heyyooo" %}
{% for tab in site.tabs %}
{% if tab.title == 'Projects' %}
{% assign projects_url = tab.url %}
{% endif %}
{% endfor %}

My personal projects are on [my github](https://www.github.com/tbidne). These projects range from experiments, libraries for public consumption, and applications that I use every day. For a quick overview, see
<a href="{{ projects_url | relative_url }}" target="_self">projects</a>.

Futhermore, I have made contributions to the following open-source communities.

### Haskell

I have contributed code to several widely used haskell libraries such as:

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

## Contact

- <a href="javascript:location.href = 'mailto:' + ['tbidne','gmail.com'].join('@')" aria-label="email"> <i class="fas fa-envelope"></i> : tbidne [at] gmail [dot] com</a>
- <a href="https://www.linkedin.com/in/tbidne" aria-label="linkedin" target="_blank" rel="noopener noreferrer"> <i class="fab fa-linkedin"></i> : https://www.linkedin.com/in/tbidne</a>
