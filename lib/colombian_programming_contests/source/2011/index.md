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

The fact that's key to solve this problem is noticing that there are at most 16 different terms among all possible documents. This is good news because there are only `2^16 = 65536` different subsets of terms. Some of these subsets must be the documents we want to codify. Since this is a small number, we can simply precompute how many basis documents we need to form each of the 65536 possible subsets and then read the answer for each document we want to codify in `O(1)`.

When working with subsets, it's usually very helpful to use bitwise operations. We will represent a subset of terms `S` with a single integer `x`, where the `i`-th bit of `x` (in binary representation) is 1 if `i+1` is present in `S` and 0 otherwise. For example, if `S = {2, 3, 7, 15, 16}` then `x = 1100000001000110`:

![Binary representation of sets](../images/binary_representation_of_sets.png)

This is useful because we can find the union of two subsets with a single bitwise `or`, which is blazingly fast and simple (we can also find the intersection with a bitwise `and`, but we don't need that in this problem).

Now, how do we find the minimum number of basis documents needed to form each possible subset of terms? Let's consider a graph where each node is a subset of terms and there's an edge from `u` to node `v` if we can mix `u` with a basis document and get `v`. It's easier to explain with an example, so let's imagine we have the following basis documents:

<pre>
  b[0] = {1}
  b[1] = {1, 3}
  b[2] = {2, 4}
  b[3] = {1, 2, 3}
</pre>

The graph we're talking about would look something like this (the index of the actual basis document that was used on each edge is shown in red):

![Document graph](../images/document_graph.png)

Every path in this graph from `0000` to any node `v` represents a subset of basis documents that were chosen and mixed together to encode document `v`. Since we want to use the least possible number of basis documents, the answer is simply the shortest path in this graph (starting from `0000`).

For example, in the graph above we can see that the shortest path from `0000` to `0001` is 1. This means that we can form the document `{1}` using a single basis document (indeed, we just need `b[0]`). There are three different paths to `0111`; the shortest one has length 1. This means that we can form the document `{1, 2, 3}` with a single basis document (indeed, we just need `b[4]`). There are several paths to `1111`; the shortest one has length 2 (indeed, we can form `{1, 2, 3, 4}` mixing two basis documents, `b[2]` and `b[3]`, or `b[1]` and `b[2]`). There is no path to `0110`. This means we cannot form `{2, 3}` no matter how hard we try.

Since we have a directed graph where all edges have the same length, we can use a classical algorithm known as Breadth First Search (BFS) to find the shortest path from the first node to all others.

It's worth noting that we don't really need to explicitly build the graph above. We can just build it on the fly as we traverse it.

Here's a sample implementation in C++:

<pre class="brush: cpp">
  Coming soon
</pre>


### Exercises ###
* Modify the algorithm above to not only tell what's the minimum number of basis documents needed, but actually tell which are the basis documents used.
* Modify the algorithm above to calculate in how many different ways you can form some given document.

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
