---
layout: post
title:  "Help Your Compiler Generate Good Code"
date:   2014-11-04 10:51:29
categories: C++ Optimization
excerpt: >
    Some examples on how to get your compiler to generate better assembly.
---

Take a look at the seemly inoccuous looking function in `Enhedron/Examples/Add.cpp`

{% highlight C++ %}
{% include how-to-make-your-compiler-love-you/Enhedron/Examples/Add.cpp %}
{% endhighlight %}

Then take a look at the generated assembly!

{% highlight gas %}
{% include how-to-make-your-compiler-love-you/Add.s %}
{% endhighlight %}

What's going on here? The problem is, the compiler can't make any assumptions about the arguments we provide. Let's take a look at each assumption that would make the compilers life easier, one by one.

1. `source` and `destination` are aligned on 32 byte boundries.
2. `size` is > 0.
3. `size` is divisible by 4 (`4 * sizeof(double) == 32`).

The code in `Enhedron/Examples/AddAligned.cpp` tells the compiler that it can make these assumptions.

{% highlight C++ %}
{% include how-to-make-your-compiler-love-you/Enhedron/Examples/AddAligned.cpp %}
{% endhighlight %}

This is the generated assembly.

{% highlight gas %}
{% include how-to-make-your-compiler-love-you/AddAligned.s %}
{% endhighlight %}

This won't have much of an effect for large arrays. There's one final assumption that will really help our compiler out though, which is that `source` and `destination` do not overlap. For example, currently we could use our `add` function to perform a [prefix sum](http://en.wikipedia.org/wiki/Prefix_sum) with `add(data, data + 1, size - 1)`. The compiler has to generate code that fits with those semantics.

The code in `Enhedron/Examples/AddAligned.cpp` tells the compiler that it can assume source and destination don't overlap, using a `Restrict` template on the arguments (see [Appendix](#Appendix)).

{% highlight C++ %}
{% include how-to-make-your-compiler-love-you/Enhedron/Examples/AddStrict.cpp %}
{% endhighlight %}

This is the generated assembly.

{% highlight gas %}
{% include how-to-make-your-compiler-love-you/AddStrict.s %}
{% endhighlight %}

Now gcc was able to vectorize our code.

## <a name="Appendix"></a>Appendix ##

Here's the support files we used, followed by build instructions.

`Enhedron/Util/Optimization.h`

{% highlight C++ %}
{% include how-to-make-your-compiler-love-you/Enhedron/Util/Optimization.h %}
{% endhighlight %}

`Enhedron/Util/Math.h`

{% highlight C++ %}
{% include how-to-make-your-compiler-love-you/Enhedron/Util/Math.h %}
{% endhighlight %}

`Enhedron/Examples/Main.cpp`

{% highlight C++ %}
{% include how-to-make-your-compiler-love-you/Enhedron/Examples/Main.cpp %}
{% endhighlight %}


To build the examples with gcc 4.8.2 on linux

    g++ -std=c++11 -mavx -O3 -I. -DNDEBUG Enhedron/Examples/*.cpp -o add

To generate the assembly

    g++ -std=c++11 -mavx -O3 -S -I. -DNDEBUG Enhedron/Examples/*.cpp

