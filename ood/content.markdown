# Software design in agile environment
![without thining][without_think]

[without_think]: http://i.imgur.com/Jp5fYlk.gif



# Why we talk about it
> We want to do our best work, and we want the work we do to have meaning.


![pain][pain]
> ...frustration occurs when it costs too much to get things done.

[pain]: http://i.imgur.com/Iiee3.gif


## Changing requirements...
> ...are the programming equivalent of friction and gravity



# How to fight?


* Write TRUE code
* Design principles
* Design patterns
* Best practices
* ...get your brain in gear!


## TRUE
* **Transparent**

  *The consequences of change should be obvious in the code that is changing and
  in distant code relies upon it.*
* **Reasonable**

  *The cost of any change should be proportional to the benefits the change
  achives.*
* **Usable**

  *Existing code should be usable in new and unexpected contexts.*
* **Examplary**

  *The code itself should encourage those who change it to perpetuate these
  qualities.*


## Design Principles
* [SOLID][solid]
    * [Single Responsibility][srp]
    * [Open-Closed][ocp]
    * [Liskov substitution][lsp]
    * [Interface Segregation][isp]
    * [Dependency Inversion][dip]
* [DRY][dry] - Don't repeat yourself
* Many more, what's your favorite?

[solid]: http://en.wikipedia.org/wiki/SOLID_(object-oriented_design
[srp]: http://en.wikipedia.org/wiki/Single_responsibility_principle
[ocp]: http://en.wikipedia.org/wiki/Open/closed_principle
[lsp]: http://en.wikipedia.org/wiki/Liskov_substitution_principle
[isp]: http://en.wikipedia.org/wiki/Interface_segregation_principle
[dip]: http://en.wikipedia.org/wiki/Dependency_inversion_principle
[dry]: http://en.wikipedia.org/wiki/Don%27t_Repeat_Yourself


## Principles matter
[Principal Components of Orthogonal Object-Oriented Metrics][pcooom]
Victor Laing & Charles Coleman

[pcooom]: http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.95.6760&rep=rep1&type=pdf


## Rocket science
![NASA][nasa]

Yeah, NASA uses Ruby, too!

For example to handle hundreds of gigs of satelite images.
[Langley Research Center][langley],
[NOAA][noaa],
[Ara T. Howard][ara]

[nasa]: http://www.basenow.net/wp-content/meatball.jpg
[noaa]: http://rubyrogues.com/094-rr-robust-ruby-with-ara-t-howard/
[ara]: http://rubyrogues.com/094-rr-robust-ruby-with-ara-t-howard/
[langley]: http://www.nasa.gov/centers/langley/home/index.html


## Design Patterns
* Knowledge of decades
* Simple identification for complex problems and solutions


### We know many from Rails

* MVC (or something like that)
* ActiveRecord (or something like that)
* Observer
* ...
* *What's your favorite?*


## Best practices
* Convention over Configuration
* TDD - BDD as a development practice
* [Rails Best Practices][rbp]
* ...
* *What's your best practice?*

[rbp]: http://rails-bestpractices.com/



# Design object with single responsibility
*not only in class based languages*


* What are your classes?
* What behavior will they implement?
* How many should you have?
* How much of themeselves should they expose?
* How much do they know about other classes?


![god objects][god_objects]

[god_objects]: http://cdn.memegenerator.net/instances/400x/35738960.jpg


> Design is more the art of preserving changeability then it is the act of
> achieving perfection.


## Remember TRUE and the Principles?
* Change without side effects
* Small change in requirements, require small change in code
* Reuseable
* Easiest way to make change is adding new changeable code.


# Code!!!



# Manage dependencies


> An object depends on another object if, when one object changes, the other
> might be forced to change in turn.


## Types of dependency
* object knows the name of other class
* object knows the name of the instance/class method
* object knows what arguments should it pass
* object knows the order of the arguments
* object knows what the other object knows *(method chaining)*
* ...test-to-code over coupling


![knows too much][know_too_much]

[know_too_much]: http://weknowmemes.com/wp-content/uploads/2012/11/he-knew-too-much-dog.jpg


Our design challange is to manage dependencies, to make the fewest possible.


# Solutions


## Dependency injection

    def how_old_is_the_captain?(weight, height, blood_pressure)
      MAGIC_FACTOR * blood_pressure * BMI.new(weight, height)
    end

    def how_old_is_the_captain?(bmi, blood_pressure)
      MAGIC_FACTOR * blood_pressure * bmi
    end

    how_old_is_the_captain?(Bmi.new(80, 189), 90) # => 42


## Dependency isolation

    class CaptainAgeSolver
      attr_accessor :weight, :height

      def initialize(weight, height)
        # ...
      end

      def how_old_is_the_captain?(blood_pressure)
        MAGIC_FACTOR * blood_pressure * bmi
      end

      def bmi
        @bmi ||= Bmi.new(weight, heigh)
      end
    end


## Remove Argument-Order Dependencies with Hash

    class CaptainAgeSolver
      def initialize(weight, height)
        # ...
      end
    end

    class CaptainAgeSolver
      def initialize(args)
        @weight = args[:weight] || 50       # falsy values won't make it
        @height = args.fetch(:height, 160)  # any value will make it
      end
    end


## Dependency direction
### How to choose the direction of the dependency?

* Some classes are more likely then others to have changes in requirements
* Concrete classes are more likely to change than abstract classes
* Changing a class with many dependents will cause
  [shotgun-surgery][shotgun_surgery]

[shotgun_surgery]: http://en.wikipedia.org/wiki/Shotgun_surgery


## Summary
* Dependency management is core to creating future-proof applications.
* Injecting dependencies creates loosely coupled objects.
* Isolating dependencies allows objects to quickly adapt to unexpected changes.
* The key to managing dependencies is to control their direction.



# Interfaces


> Program to an **interface**, not an implementation.
>
> Gang of Four, 1995

### What does it mean...


## ...and what are interfaces for?
![Communication](https://dl.dropboxusercontent.com/u/519915/interface_comm.png)


## Public interface
* Others will depend on it
* so don't change a lot
* document well with tests
* minimize implementation details


## Private interface
* Others won't depend on it (or they take the risk)
* can change any time
* may not show up in tests
* handle implementation details


## How to find the public interface?
* Public methods should read like the description of responsibilities of the
  containing class.
* Design maximum future flexibility,
* while writing the smallest amount of code.
* It is an art!


### Sequence Diagrams
* Ask "What" instead of "How"
* If you have the question, who should answer it?
* Seek context independence

![Sequence diagram][seq_diag]
[seq_diag]: https://dl.dropboxusercontent.com/u/519915/sequenceDiagramEnrollInSeminar.jpg


* From procedural to OO style
* Minimalize public interface
* Trust receiver

![Trip-Bikes-Mechanic](https://dl.dropboxusercontent.com/u/519915/seq_diag_evolv.png)


## Summary
* Object-oriented applications are defined by the messages that pass between
  objects.
* Public interfaces consist of stable methods that expose the
  responsibilities of their classes.
* Focusing on messages reveals objects that might otherwise be overlooked.
* Trust objects, do not tell them how to behave



# Aquire behaviour
* via classical inheritence
* via sharing role behaviours with modules
* via composition


## Inheritence
## Role behaviours via modules
## Composition



# Sources
* [Sandi Metz - Practical Object-Oriented Design in Ruby][poodr]
* [Design Patterns - Belarus RUG (Speaker Deck)][dpbrug]

[poodr]: http://www.informit.com/store/practical-object-oriented-design-in-ruby-an-agile-primer-9780321721334?w_ptgrevartcl=Practical%20Object%20Oriented%20Design%20in%20Ruby%3a%20Interfaces_1834700
[dpbrug]: https://speakerdeck.com/lest/design-patterns-belarus-ruby-on-rails-user-group-23-feb-2013



## Thanks
# Questions?

* Twitter: [@trekdemo][twitter]
* Github: [@trekdemo][github]

[twitter]: http://twitter.com/trekdemo
[github]: http://github.com/trekdemo

