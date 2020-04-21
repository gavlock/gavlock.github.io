---
series: Lambda on Lisp
index: 0
title: Exploring the lambda calculus using Common Lisp
tags: [lambda-calculus, lisp]
excerpt: A Lisper's commentary on the "Fundamentals of Lambda Calculus & Functional Programming in Javascript".
image: Lambda xxx.svg
---

## Overview {#overview}

In this series of articles we'll explore the lambda calculus and
implement a lambda calculus syntax *on* Common Lisp. Our emphasis will
be on the lambda calculus, with just enough Lisp to give us an
environment to play in.

I said *on*, rather than *in*, Common Lisp because I would like to
start with a thin-as-possible abstraction layer that transforms lambda
calculus syntax into Lisp functions and function calls. See Paul
Graham's excellent book, "[On
Lisp](http://www.paulgraham.com/onlisp.html)", for more details.

> The title is intended to stress the importance of bottom-up
> programming in Lisp. Instead of just writing your program in Lisp,
> you can write your own language **on Lisp**, and write your program
> in that.
>
> Paul Graham, "On Lisp: Advanced Techniques for Common Lisp", 1993

As with anything else, this approach has some upsides and some
downsides. 

One advantage is that our lambda calculus will have full access to
Lisp functions and values, which will be quite useful while we
implement a language that, in the beginning, won't even have the
concept of natural numbers.

Another advantage is that Lisp will have full access to our lambda
calculus. We'll see examples of this later.

One disadvantage stems from my choice of Common Lisp rather than, say,
Scheme or Clojure. Common Lisp is the lisp I know and love, but it is
a Lisp-2. Don't worry if you don't know what that means right now ---
later on we'll see how calling a function returned by a function is
just a little bit tricky. This would have been easier in a Lisp-1 like
Scheme, but it's not going to be too much of a problem.

One cute side-benefit of doing it this way is that, because our lambda
calculus functions will be transformed into Lisp functions, they can
be byte-compiled --- so your idle playing around with a language
that no-one actually uses will at least be at breakneck speed.

## What?! But, why? {#why-lambda-calculus}

*"What do you mean no-one actually uses it?"* someone asks, quite
indignant. Someone else wonders, *"Then why should I bother learning
it?"*

OK. So it's true --- as far as I know, no-one uses actual lambda
calculus in production code --- in the same way that no-one builds
actual Turing machines to solve real-world problems. And, yes, you
*can* learn functional programming without knowing a lambda calculus;
just as you can learn imperative programming without every hearing of
a Turing machine; but please consider:

1. *Lambda calculus is beautiful.*
2. *The Turing machine and the lambda calculus are two of the purest
   forms of expressing computation that we have*. They give us ways of
   thinking about what programming languages *do* and, possibly more
   importantly, what programming languages *are*.
3. *Lambda calculus and Turing machines are two very different ways of
   thinking about computation.* At the risk of over-simplifying, Turing
   machines are the epitome of imperative programming, with their
   state, and with the machine's head stepping along the tape one
   block at a time (albeit in either direction) --- while the lambda
   calculus, consisting only of functions, offers the base model of
   functional programming. Exploring these differences can teach us a lot.
4. *Lambda calculus and Turing machines are exactly the same.* OK,
   not *exactly* the same, but equivalent. The Church-Turing
   hypothesis teaches us that they are, in a sense, isomorphic. They
   are two side of the same coin, two faces of the same Batman
   villain. Exploring their similarities can teach us a lot.
5. *The idea that __everything__ that can be computed, can be computed
   using something as simple as the lambda calculus is mind-blowing.*
   We'll take a look at syntax in the next article, but for now I'll
   just mention that the entire syntax can be expressed in only three
   rules.
6. *Lambda calculus is beautiful.*

## Why does this article's abstract mention JavaScript? {#why-javascript}

This series was inspired by a Fullstack Academy talk presented by
Gabriel Lebec.

*Before you run off and watch the video*, be aware that the flow of
this series will follow that of the talk; and that each major section
will contain a timestamped link to the next part of the video so that
you can work through Gabriel's talk and this series in parallel, while
avoiding spoilers. But --- if you'd prefer to watch the whole video
first, here ya go: [Lambda Calculus - Fundamentals of Lambda Calculus
& Functional Programming in
JavaScript](https://www.youtube.com/watch?v=3VQ382QG-y4).

Part 1 of Gabriel's talk gave me a clearer understanding of the lambda
calculus than anything I had previously read or watched. I enjoyed it
so much that partway through, I decided I needed to stop watching and
play around with what he had already presented before I continued.

<takeaway>
I figured that implementing a lambda calculus in Lisp would
further my understanding of both the calculus *and* Lisp --- a
language I love but am still learning.  Please, pull up a chair and
join me for the ride!
</takeaway>

<!--
## Where do we go from here?

There are various lambda calculii (or λ-calculii), but usually, people
refer to Alonzo Church's as *the* lambda calculus. (Note all the
lower-case letters in that sentence.) I'll call our implementation of
Church's λ-calculus "Lambda" or "Λ" (with a capital "l" or a capital
"λ"). This, I admit, is mostly so that I don't have to keep typing
"lambda calculus" in full.
-->

