---
series: Lambda on Lisp
index: 2
permalink: /blog/lambda-on-lisp/2-syntax
title: Lambda on Lisp - Syntax
tags: [lambda-calculus, lisp]
teaser: TODO
stub: TODO
image: Lambda xxx.svg
---

[Gabriel's video: From 1m48s to 9m15s](https://www.youtube.com/embed/3VQ382QG-y4?start=108&end=555&autoplay=1)

## Lambda abstractions {#lambda-abstractions}

The lambda calculus is all about functions. You might even say it's
*only* about functions --- after all, functions are the only values
the calculus has.

So it's quite understandable that the calculus gives us a very compact
syntax for defining functions. In the previous article we looked at a
Lisp implementation of the identity function: `(lambda (a) a)`.

Granted, that's not particularly verbose, but in the lambda calculus
it's even terser: `λa.a`

Let's break that down. The lowercase lambda (11th letter in the Greek
alphabet) introduces a *lambda abstraction* or, in Lisp terms, an
unnamed function definition. In fact, this is exactly why Lisp uses
the `lambda` symbol for that purpose.

After the 'λ', we have the function's argument. Remember that lambda
calculus abstractions are always unary functions --- there will always
be exactly one argument.

The full stop (the period) separates the argument from the "body" of
the abstraction. The rest of the expression is greedily parsed as the
body.

<aside markdown="1">
### Binding vs β-reduction

To avoid getting into a lengthy discussion of the lambda calculus'&nbsp;
β-reduction and α-conversion right now, I'm going to talk about things
in terms of Lisp functions, binding and evaluation rather than how
they are actually defined in the calculus. While not entirely
accurate, the concepts are close enough for now.
</aside>

## Handling the λ syntax in Lisp {#handling-lambda-syntax-in-lisp}

To allow us to type expressions like `λa.a` directly into Lisp, we'll 
