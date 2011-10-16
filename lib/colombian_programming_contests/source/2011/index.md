# Solutions to problems from Colombian National Programming Contest 2011

<div class="author">
  <p class="name">by Andrés Mejía</p>
  <p class="date"><%= l Time.now, :format => "%B %d, %Y" %></p>
</div>

<a name="contents"></a>

## Table of contents ##

* [Solution to problem A - The Starflyer Agents](#solution-a)
* [Solution to problem B - Sewing Buttons with Grandma](#solution-b)
* [Solution to problem C - Document Compression](#solution-c)
* [Solution to problem D - Digital Roulette](#solution-d)
* [Solution to problem E - Edgetown's Traffic Jams](#solution-e)
* [Solution to problem F - Flight Control](#solution-f)
* [Solution to problem G - Gas Stations](#solution-g)
* [Solution to problem H - Handgun Shooting Sport](#solution-h)
* [Solution to problem I - Inspecting Radars](#solution-i)
* [Solution to problem J - Philip J. Fry Problem](#solution-j)


<a name="solution-a"></a>

## Solution to problem A - The Starflyer Agents ##

<a name="solution-b"></a>

## Solution to problem B - Sewing Buttons with Grandma ##

<a name="solution-c"></a>

## Solution to problem C - Document Compression ##

<a name="solution-d"></a>

## Solution to problem D - Digital Roulette ##

The problem can be rephrased as follows: count the number of different values of the expression `P(x) % (n + 1)` for all `x`'s between 0 and `M`. Since the constraints are small (`M` ≤ 10000 and `k` ≤ 10), we can use brute force to evaluate the polynomial on every possible `x`.

There are two caveats, however:

First, notice that when evaluating the polynomial we'll have to compute expressions of the form `a[i] * x^i`. In the worst case, `i` might be as big as 10, `x` might be as big as 100000, and `a[i]` might be as big as 10000000, which means that `a[i] * x^i` might be as big as 10^57. This doesn't fit in any native data type (recall that currently in C++ the biggest integer we can store in a native data type is 2^64 - 1 which fits in a `long long`).

Luckily, we don't really care about `a[i] * x^i`, we just care about `(a[i] * x^i) % (n + 1)`, so we can compute the expression without overflow. Recall from modular arithmetic properties that `(a * b) % n == ((a % n) * (b % n)) % n`, so we just have to compute `(a[i] * (x % (n + 1)) * (x % (n + 1)) * ... * (x % (n + 1))) % (n + 1)`, where there are exactly `i` `x`'s in the expression (in other words, start with `a[i]` and multiply it `i` times with `x`, taking the result `% (n + 1)` after every step).

There's still a slight possibility of overflow: when we evaluate `(a[i] * x) % (n + 1)`, `a[i] * x` might be as big as 10^7 * 10^5 = 10^12, but this fits comfortably in a `long long` so everything will be all right if we use `long long`s when calculating this product.

The second consideration is that since we are potentially evaluating the polynomial 10000 times, we need to be able to compute it as fast as possible. There's something known as Horner's rule, that lets us evaluate the polynomial in O(`n`), where `n` is its degree. This is fast enough. Basically, it's just a clever way of factoring out powers of `x`. Namely, Horner's rule says that:

![Horner's Rule](../images/horner.png)

Finally, in C++, the easiest way to count the number of different answers is using a `set`. We just add all possible answers to the `set` and then ask for its size.

Here's a sample implementation in C++:

<pre class="brush: cpp">
<%= File.read "source/2011/d.cpp" %>
</pre>


The complexity of this algorithm is O(`m * k * log(n)`) (the `log` factor is what it takes to store a number in the `set`).

[Back to top](#contents)

<a name="solution-e"></a>

## Solution to problem E - Edgetown's Traffic Jams ##

<a name="solution-f"></a>

## Solution to problem F - Flight Control ##

<a name="solution-g"></a>

## Solution to problem G - Gas Stations ##

<a name="solution-h"></a>

## Solution to problem H - Handgun Shooting Sport ##

<a name="solution-i"></a>

## Solution to problem I - Inspecting Radars ##

<a name="solution-j"></a>

## Solution to problem J - Philip J. Fry Problem ##
