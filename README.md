gear⚙
=====
gear is a modular native extension dependency builder for Ruby
  
Basically formatted "package" like build scrips called "gears" are used to compile native libraries ON the platform where a bundle is being installed and packages said dependencies within the gems. Or at least that was the idea. In the end it would take a massive ammount of effort to try and match a similar system like, say, homebrew.  
  
Initially the idea was to call gear from extconf.rb in a native extension and build any requirements on-demand when they are not found on the system. Unfortunately this is immensely clumsy and is officially frowned upon. Gear does work for compiling a set of dependencies but the current implementation is clumsy. In the future, if there is a demand, gear development will resume. If you are someone who would like to adopt the project please contact @Kagetsuki on github.

*DO NOT RELY ON THIS. Currently gear should not be considered stable or fully usable.*

Revisions / Contributions
-------------------------
If you have an idea and can write some specs for it then it's highly likely I'll accept a merge request and push a new gem version for you.

License
-------
GPLv3
