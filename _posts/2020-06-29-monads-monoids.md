---
title: Monads are just monoids in the category of endofunctors, what's the problem?
date: 2020-06-29 12:00:00 +1200
categories: [Math]
tags: [category theory, math]
pin: false
hidden: false
render_with_liquid: false
last_modified_at: 2023-06-29 12:00:00 +1200
---

## Introduction

The title is from James Iry's classic [A Brief, Incomplete, and Mostly Wrong History of Programming Languages](https://james-iry.blogspot.com/2009/05/brief-incomplete-and-mostly-wrong.html), an hilarious rundown of various programming languages. The statement was lifted from an observation in Saunders Mac Lane's _Categories for The Working Mathematician_:

> All told, a monad in X is just a monoid in the category of endofunctors of X, with product × replaced by composition of endofunctors and unit set by the identity endofunctor.

Monads are known for being difficult to learn, and this phrase is a well-known joke in the functional programming community, the joke being that it doesn't make sense to anyone who doesn't already understand it.

The goal of this post is to explain this statement to someone who knows some category theory (e.g. the definition of category, functor), but has yet to put the pieces together.

We will review the definitions in light detail, assuming familiarity. We will also omit some technical requirements, such as commutative diagrams and coherence conditions. To start, we will slightly amend the statement for clarity:

> A monad is an example of a monoid in the category of endofunctors.

Or in symbols,

> $$M$$ is a monad $$\implies M$$ is a monoid in the category of endofunctors.

Notice that the implication is one-way i.e. the converse is not necessarily true. More on this later.

## Monoidal categories

**Definition:** A **monoidal category** $$(C, \otimes, I)$$ is a category $$C$$ equipped with

- $$\otimes : C \times C \rightarrow C$$, a bifunctor called the **monoidal product**.
- $$I$$, an object in $$C$$ that behaves like the identity with $$\otimes$$.

**Definition:** A **monoid object**, or simply **monoid**, is an object $$A$$ in $$C$$ with two arrows:

$$
\begin{align*}
  & \eta : I          && \rightarrow A\\
  & \mu : A \otimes A && \rightarrow A
\end{align*}
$$

**Example:** $$(\textbf{Set}, \times, *)$$ is a monoidal category where $$\times$$ is cartesian product and $$*$$ is any singleton set. A monoid object in this category is a set $$A$$ with functions

$$
\begin{align*}
  & \eta : *         && \rightarrow A\\
  & \mu : A \times A && \rightarrow A
\end{align*}
$$

This yields the familiar definition of a monoid from abstract algebra i.e. a set with a binary function ($$\mu$$) and an identity (given by $$\eta$$).

To see this, consider the cyclic group $$\mathbb{Z}/n\mathbb{Z} := \{1, 2, \ldots, n\}$$ and define functions

$$
\begin{align*}
  & \eta(x)   && = 0\\
  & \mu(x, y) && \equiv x + y \pmod n
\end{align*}
$$

This gives the monoidal structure and is equivalent to the more abstract definition given above.

## Monads

**Definition:** Given a category $$C$$, a **monad** is a triple $$(T, \eta, \mu)$$ with

- $$T : C \rightarrow C$$, an endofunctor on $$C$$.
- Natural transformations:

$$
\begin{align*}
  & \eta : 1_C      && \rightarrow T\\
  & \mu : T \circ T && \rightarrow T
\end{align*}
$$

where $$1_C$$ is the identity functor on $$C$$ and $$T \circ T$$ is $$T$$ composed with itself via _functor_ composition. Note that $$T \circ T$$ is sometimes written as $$T^2$$.

**Example:** Again consider $$\textbf{Set}$$, and let $$T : \textbf{Set} \rightarrow \textbf{Set}$$ be the power set functor. Then $$(T, \eta, \mu)$$ is a monad on $$\textbf{Set}$$ where $$\eta$$ maps each $$a \in A$$ to $$\{a\}$$, and $$\mu$$ maps a nested set to its union. That is,

$$
\begin{align*}
  & \eta(A) = \bigcup_{a \in A} \{a\} \\
  & \mu(A) = \bigcup_{a \in A} a
\end{align*}
$$

## Category of endofunctors

**Definition:** Every category $$C$$ gives rise to a category of endofunctors $$\text{End}_C$$. The objects in this category are endofunctors $$T : C \rightarrow C$$, and the arrows are natural transformations.

## Putting it all together

$$(\text{End}_C, \circ, 1_C)$$ is a monoidal category. A monoid in this category, then, is an endofunctor $$T$$ with natural transformations:

$$
\begin{align*}
  & \eta : 1_C      && \rightarrow T\\
  & \mu : T \circ T && \rightarrow T
\end{align*}
$$

This is exactly the definition of a monad! Putting it back into words:

> A monad $$(T, \eta, \mu)$$ is a monoid in $$(\text{End}_C, \circ, 1_C)$$.

## Coda

Remember this comment?

> Notice that the implication is one-way i.e. the converse is not necessarily true.

This is due to there being more than one way of defining a "monoid in the category of endofunctors". We have taken the monoidal product $$\otimes$$ to be $$\circ$$, functor composition. In this case, yes, a monoid in this category is exactly a monad.

But observe that this definition leaves open the possibility of using a different monoidal product. In particular, we could take $$\otimes$$ to be [**Day Convolution**](https://en.wikipedia.org/wiki/Day_convolution), sometimes written as $$\star$$. In this case we get a _different_ "monoid in the category of endofunctors", and in fact a monoid in this category is a **lax monoidal functor**, not a monad.
