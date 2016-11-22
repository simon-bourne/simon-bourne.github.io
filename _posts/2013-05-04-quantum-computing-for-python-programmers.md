---
layout: post
title:  Quantum Computing For Python Programmers
date:   2013-05-04 10:51:29
categories: Python
excerpt: >
    Explanation and implementation of a simple quantum computer simulator in python.
---

## Introduction

This post is based on knowledge gleaned from Michael Nielsen's excellent course [Quantum Computing for the Determined](http://michaelnielsen.org/blog/quantum-computing-for-the-determined/).

The simulator ended up at just over a hundred (non blank) lines of python. It contains an implementation of the [Deutsch-Jozsa algorithm](http://en.wikipedia.org/wiki/Deutsch%E2%80%93Jozsa_algorithm). Unfortunately it's not possible to run quantum algorithms at full speed on a classical computer, so don't expect to use it to break any encryption algorithms! The simulator runs a quantum algorithm and gives the expected result.

## Quantum Computing
You might have heard of a Qubit. It's the quantum equivalent of a classical bit. A classical bit can be either 1 or 0. A quantum Qubit can only ever be observed to be 1 or 0, but internally it looks quite different. Think of a clock face with only 8 hours on it, with 8 o'clock at the top. Imagine an hour hand on that clock. If the hour hand is at 4 or 8 o'clock (straight down or straight up), you'll always observe a one on the Qubit. If the hour hand is at 2 or 6 o'clock (horizontal), you'll always observe a zero. If the hour hand is at an odd numbered hour, it'll be 50/50 whether you observe a 0 or a 1. This is known as a superposition of 1 and 0. Once you've observed a 1 or a 0 on the Qubit, you'll always observe a 1 or 0 unless you do something to change it. In fact, it's as if the act of looking at it moves the hour hand to 8 o'clock or 2 o'clock. We can't ever see the internal state of a Qubit. That seems to be a fundamental part of quantum mechanics. We'll only ever see 8 o'clock or 2 o'clock.

**Always observed to be 0**

![Qubit at 2](/images/quantum-computing-for-python-programmers/qubit-2.svg) | ![Qubit at 6](/images/quantum-computing-for-python-programmers/qubit-6.svg)

**Always observed to be 1**

![Qubit at 0](/images/quantum-computing-for-python-programmers/qubit-0.svg) | ![Qubit at 4](/images/quantum-computing-for-python-programmers/qubit-4.svg)


**Observed to be either 0 or 1 with equal probability**

![Qubit at 1](/images/quantum-computing-for-python-programmers/qubit-1.svg) | ![Qubit at 3](/images/quantum-computing-for-python-programmers/qubit-3.svg) | ![Qubit at 5](/images/quantum-computing-for-python-programmers/qubit-5.svg) | ![Qubit at 7](/images/quantum-computing-for-python-programmers/qubit-7.svg)

We can represent a single Qubit with a line pointing in a certain direction, like the hour hand on our clock.

![Qubit Vector](/images/quantum-computing-for-python-programmers/qubit-vector.svg)

The length of the line must always be 1 (corresponding to a probability of 1), so, from Pythagoras, the sum of the squares of x and y must be 1. The probability of a Qubit being in the 1 state is y squared, and the probability of it being in the 0 state is x squared.

## More Qubits

We're going to represent the internal state of our quantum computer simulator as an array of numbers. We're going to have 1 element for each possible state of the system, and it's value will be the square root of the probability that the system is in this state. A single Qubit system has 2 possible states, 0 and 1, so it'll be represented by a 2 element array. One element will correspond to x in the diagram, and the other will correspond to y.

Adding another Qubit doubles the number of possible states the system can be in. Think of it like this: The computer can be in all the states it was before, with the new Qubit set to 0. It can also be in all the states it was before with the new Qubit set to 1. So for a 2 Qubit system, we'd have a 4 element array, and for a 3 Qubit system, we'd have an 8 element array. For a N Qubit system we'd have a pow(2, N) element array.

A quantum computer can act on all of these states in parallel. This is where the power of quantum computers comes from, and makes simulating a quantum computer an NP complete problem. Note that it doesn't mean quantum computers can solve NP complete problems, because we can only ever observe one of these states. Quantum algorithms can still employ some clever trickery to exploit some of this parallelism. We'll see one of them in action in our simulator later.

The index to our state array will be the state of our computer. The square of the value of each element will be the probability that the computer is in that state. The initial state of our quantum computer must be known with certainty. This means one element of the state array will have a probability of 1, and all the other elements will have a probability of 0. The element with probability 1 represents the initial known state of the machine.

Our state array is private. This is the same in the real world. We have no way to determine the quantum state until we observe something, at which point a Qubit becomes 0 or 1 with complete certainty. For simplicity, we're only going to allow observation of Qubits that are in a known state in our simulator. In a real quantum computer you can look at any Qubit, but if it is not in a known state, other Qubits may be affected. Consider for example:

 State | `sqrt(probability)`
------:|-------------------:
    00 | 0
    01 | 0.5
    10 | 0.5
    11 | sqrt(2)/2

State 00 and 10 are the only states with a 0 in the least significant bit. Since state 00 has 0 probability, if you happen to observe a 0 in the least significant Qubit, your computer will definitely be in state 10. So we now know that the most significant Qubit is 1. This is quantum decoherence, and the 2 qubits are said to be entangled with one another.

## Quantum Logic Gates

We're only going to simulate one quantum logic gate in our system, as that's all that's required to implement a basic quantum algorithm that is exponentially faster than a classic computer. The gate is called a Hadamard gate. On a single Qubit, all it does is advance the clock by one hour and flip the hour hand. On a 2 Qubit system, our state array is already a 4 dimensional vector, so it's not possible to visualise. A Hadamard gate applied to a Qubit in the 1 state will result in a Qubit in a state that is equally likely to be 1 or 0. This is called a superposition of 1 and 0 if you remember. I'm not sure why it flips the line. Maybe it's so that applying it twice gets you back to your starting point, or maybe it's just easier to implement them with this behaviour.

|           | Initial state                                                               | Add 1 hour                                                                  | Flip
| Example 1 | ![Qubit at 0](/images/quantum-computing-for-python-programmers/qubit-0.svg) | ![Qubit at 1](/images/quantum-computing-for-python-programmers/qubit-1.svg) | ![Qubit at 3](/images/quantum-computing-for-python-programmers/qubit-3.svg)
| Example 2 | ![Qubit at 3](/images/quantum-computing-for-python-programmers/qubit-3.svg) | ![Qubit at 4](/images/quantum-computing-for-python-programmers/qubit-4.svg) | ![Qubit at 0](/images/quantum-computing-for-python-programmers/qubit-0.svg)

To apply a Hadamard gate to a single Qubit system with it's state represented by x and y for 0 and 1 respectively, we transform x and y like this:

{% highlight python %}
x = (x + y) / sqrt(2)
y = (x - y) / sqrt(2)
{% endhighlight %}

To apply a Hadamard gate to a Qubit in a multi Qubit system, we need to find all the pairs of states that differ by only that Qubit, and apply the transformation above to each pair. The pairs correspond to the 0, or x, axis of the Qubit and the 1, or y, axis of the Qubit.

|State | Binary
|-----:|------:
|  0   | 000
|  1   | 001
|  2   | 010
|  3   | 011
|  4   | 100
|  5   | 101
|  6   | 110
|  7   | 111

For example, the pairs for the least significant bit are:

X (binary) | Y (binary)
----------:|----------:
   0 (000) | 1 (001)
   2 (010) | 3 (011)
   4 (100) | 5 (101)
   6 (110) | 7 (111)

For the middle Qubit:

X (binary) | Y (binary)
----------:|----------:
   0 (000) | 2 (010)
   1 (001) | 3 (011)
   4 (100) | 6 (110)
   5 (101) | 7 (111)

And for the most significant qubit:

X (binary) | Y (binary)
----------:|----------:
   0 (000) | 4 (100)
   1 (001) | 5 (101)
   2 (010) | 6 (110)
   3 (011) | 7 (111)

## A Quantum Algorithm

Now all we need is a quantum algorithm to run on our simulator. We're going to implement the Deutsch-Jozsa algorithm as it's pretty simple (to implement, if not to understand). It's not a very useful algorithm, but it is the basis of other quantum algorithms, such as Shor's for prime factoring. RSA encryption relies on prime factoring being a hard problem, so Shor's algorithm could be used to break RSA.

The Deutsch-Jozsa algorithm will take a function as it's input. The function must take a number and map it to either 0 or 1. For every input, we'll promise that the function will either:

* Always return 0
* Always return 1
* Return 1 or 0, but the same number of inputs will map to 0 as map to 1. For example, a function that returns 1 if the number is even, or 0 if it's odd.

Deutsch-Jozsa will tell us if the function is constant or not. If you were to solve this problem on a classical computer, worst case you'd have to call the function for half the inputs + 1 to be sure which type of function you had. Deutsch-Jozsa will only call the function once (or rather, it will ask a quantum oracle to transform a carefully crafted superposition of possible states).

Our algorithm requires enough Qubits to represent the number passed to the function, and one extra. So if the input to our function was an 8 bit number, we'd need 9 bits for our algorithm. The extra Qubit will be the first Qubit, just for ease of implementation. This means that the even numbered indexes of the state array correspond to states where the extra bit is 0.

## The Quantum Oracle

For each state, the Quantum Oracle will call the function with all the bits of that state, except the extra bit, as input. If the function returns one, the Quantum Oracle will negate the probability root of that state.
Even though the Quantum Oracle and the Hadamard gate are implemented as a loop in our simulator, a quantum computer does all this in parallel. We have to be a bit clever to exploit this parallelism due to the restrictions on observing Qubits.

## Implementing The Quantum Algorithm

We'll start off with our extra Qubit in the 1 state, and every other Qubit in the 0 state. Then we'll apply the Hadamard gate to each Qubit to create a quantum superposition of every possible state. In other words, every state in which our quantum computer could be is equally likely. You can see this in the log line just before the Quantum Oracle is applied. Next we'll apply the Quantum Oracle. The 1st Qubit is now irrelevant. Next we apply the Hadamard gate to each of the other Qubits, then we'll observe them. If they're all 0, our function was constant, otherwise it isn't.

Here's the code. It's written in python and has been tested with version 2.7.6 and 3.4.0 on linux.

{% highlight python %}
{% include quantum-computing-for-python-programmers/QuantumComputerSimulator.py %}
{% endhighlight %}

