# Substance Song

After completing the [Beer Song on Exercism's Ruby Track](https://exercism.org/tracks/ruby/exercises/beer-song), I thought it might be a fun exercise to build [my solution](https://github.com/bensaunders/exercism-beer-song) into a Rails app.

The basis of the solution is that we consider the Beer Song to be one instance of a general "Substance Song", in which each verse presents a substance situation (e.g. 99 bottles of beer being on a wall), which suggests a certain action (e.g. taking one down and passing it around). The action results in a new situation (e.g. 98 bottles of beer being on the wall), which is used as the end of that verse and the beginning of the next one.

Hopefully it goes without saying that this is an over-complicated analysis of a fairly simple song! If we really wanted to achieve nothing more than to print out the song, we could do it much more simply. We're assuming that the puzzle is standing in for a real-world problem, which would need to be worked on and extended by a team of developers over a period of time, and which therefore deserves such an in-depth treatment.
