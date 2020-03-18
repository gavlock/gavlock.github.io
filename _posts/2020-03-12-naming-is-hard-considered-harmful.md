---
title: "“Naming is hard” considered harmful"
tags: [naming]
abstract: "Is good naming inherently hard - or is it a design smell?<br/>
  Does good design beget good naming?"
image: Bad naming.svg
---

Let's start by taking as given that good naming is important. Many
people smarter than I have already covered this, and *this* article is
not about persuading the unconvinced.

Next --- I was inspired to actually sit down and commit my thoughts to
text after watching [Kate
Gregory's](http://www.gregcons.com/kateblog/) excellent ["Naming is
Hard: Let's Do Better"](https://www.youtube.com/watch?v=MBRoCdtZOYg
"Kate Gregory at CppCon 2019") talk from CppCon 2019. I highly
recommend it.

Good naming *should* be easy. We should be able to name a thing — a
variable, function, class, module, etc. — just by describing what it
is or what it does, right? So when does naming become hard?
1. *When we don’t know what the thing is or does.*
2. *When the thing is or does too much.*

Both of these problems are bigger than naming. As important as naming
is --- and it *is* important --- ensuring that each piece of code has
a *single*, *well understood* responsibility is more important. Good
architecture reduces bugs, improves maintainability and testability,
and (as a free side-effect) makes choosing names easier.

Just to clarify, I'm not talking about naming *conventions*. If you
need to write a predicate that indicates whether or not an invoice has
been paid, you might call it `paidp` in Common Lisp, `paid?` in Scheme
or `isPaid` in Haskell. The *decoration* of the word "paid" is part of
your coding convention --- and the only advice I'll give regarding
that is (1) Have a convention, and (2) Follow it! What we're talking
about here is the choice of the word "paid" itself.

Looking at the first problem, when you don't know what real-world
concept a class models, or what a function is supposed to do, naming
it will be difficult --- but writing and testing it effectively will
be impossible. This might sound blindingly obvious (at least, I hope
it does), but too often we see developers diving into code before
understanding its requirements, or how to meet those requirements, all
in the name of "exploratory programming". They confuse *"I know what I
need to do, but not yet how to do it,"* with *"I don't yet know what I
need to do."*

Once you understand what a code artefact is supposed to do, you can
evaluate the scope of its work. Does this class model one, and only
one, real-world object from my business domain? Does this function
perform exactly one complete task or subtask? These questions are
basically the "S" in [SOLID](https://en.wikipedia.org/wiki/SOLID
"Definition of SOLID on Wikipedia"), i.e. the single responsibility
principle --- but don't be fooled. This principle is not limited to
class design in OOP --- it applies to all your code (for my
generation: All your (code)base are belong to it.)

Once a "thing" in your code performs one, and only one, role --- and
once you understand that role --- it should be easy to find a
business-domain term for that role. *Et voilà!* There's your name.

<takeaway>Next time you find yourself struggling to name something in
your code, rather than just excusing yourself with "naming is hard"
and rushing on full-steam, first ask *why* it's hard. Is there some
deficit in your design that makes selecting a good name difficult?
Could some remodelling or refactoring make the naming easier? And,
would that work improve the code beyond just issues of naming?
</takeaway>

<!-- [^1]: Kate Gregory (she/her) \| <a class="twitter-handle" href="https://twitter.com/gregcons">@gregcons</a> \| [www.gregcons.com/kateblog/](http://www.gregcons.com/kateblog/) -->

