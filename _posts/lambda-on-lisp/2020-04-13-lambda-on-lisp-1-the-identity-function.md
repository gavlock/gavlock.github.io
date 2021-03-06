---
series: Lambda on Lisp
index: 1
permalink: /blog/lambda-on-lisp/1-the-identity-function
title: Lambda on Lisp - The identity function
tags: [lambda-calculus, lisp]
teaser: "Constant and Identity: &ldquo;These are not the symbol-values you're looking for.&rdquo;"
stub: "Possibly the simplest type of function in Lisp is one taking no
arguments and returning a constant value.  The returned value could be
&ldquo;nothing&rdquo; as in `(lambda () nil)`, or any other constant value,
`(lambda () 42)`"
image: lambda-on-lisp-identity.svg
---

[Gabriel's video: From the beginning to the discussion of lambda syntax at 1m48s](https://www.youtube.com/embed/3VQ382QG-y4?start=1&end=108&autoplay=1)

## Foreshadowing the constant function {#constant-function}

Possibly the simplest type of function in Lisp is one taking no
arguments and returning a constant value.  The returned value could be
"nothing" as in `(lambda () nil)`, or any other constant value,
`(lambda () 42)`

As we'll see later, the lambda calculus doesn't have functions that
take no arguments.  Every function in the calculus takes exactly one
argument, so the two Lisp expressions above become something like
`(lambda (_) nil)` and `(lambda (_) 42)`.

<aside markdown="1">
I'm assuming you have a basic-to-intermediate grasp of Lisp, such as
understanding Lisp lambdas, and the fact that the underscore is a
valid symbol and argument name, with no special meaning (other than my
convention of using it for ignored values).

I'll do my best to explain only what I think needs explaining, but if
I gloss over something you feel needs more detail (or spend too long
waffling on over something trivial), please comment.  I would
appreciate the feedback.
</aside>

In the spirit of following Gabriel's video, I'll get back to the
constant function later.  For now, we'll start with the next simplest
function ...

## The identity function {#identity-function}

Because every function in the lambda calculus takes exactly one
argument, the next simplest thing we could do is to just return that
argument: `(lambda (a) a)`

Let's give it a try:

```console?lang=lisp&prompt=>comments=false
CL-USER> ((lambda (a) a) 1)
1
CL-USER> ((lambda (a) a) 2)
2
CL-USER> ((lambda (a) a) (lambda (a) a))
#<FUNCTION (LAMBDA (A)) {10024F117B}>
```

How do we give that lambda a name? Well, in Lisp that's just a `defun`.

```console?lang=lisp&prompt=>&comments=true
CL-USER> (defun I (a) a)
I
CL-USER> (I 1)
1
CL-USER> (I 2)
2
CL-USER> (I I)
# [Condition of type UNBOUND-VARIABLE] The variable I is unbound.
```

## The identity of identity {#identity-of-identity}

If you've been working with Common Lisp long enough, that last one
won't surprise you too much.  As I mentioned in the intro, CL is a
Lisp-2.  It has 2 separate "namespaces" for symbol values and symbol
functions, but *the only values in lambda calculus are functions*.

This is one of the places a Lisp-1 (like Scheme) would have made our
lives a little easier, but there is a workaround.  If we copy `I`'s
symbol function to its symbol value we get the effect we're looking
for.

```console?lang=lisp&prompt=>&comments=true
CL-USER> (defparameter I #'I)
I
CL-USER> (I I)
#<FUNCTION I>
```

So that we don't have to keep on repeating that step, let's define a
version of `defun` specifically for lambda functions.

```lisp
(defmacro deflambda (sym args &body body)
  "Defines a lambda calculus function (using Lisp's native `defun`),
but also copies the function to `sym`'s symbol-value to give us the
lambda calculus' value semantics in which we can refer to function ƒ
as just `ƒ` rather than (function ƒ)` or `#'ƒ`."
  `(prog1
     (defun ,sym ,args ,@body)
     (defparameter ,sym #',sym)))
```

```console?lang=lisp&prompt=>&comments=true
CL-USER> (deflambda I (a) a)
I
CL-USER> (I I)
#<FUNCTION I>
```

There is one more small problem with CL's Lisp-2 nature, which we'll
get to later.  (Hint: What should `((I I) I)` return?)

<takeaway>
In this part of the Lambda on Lisp series, we took a look at the
identity function, and implemented our first workaround for treating
lambda functions as *values*.
</takeaway>
