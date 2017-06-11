This README would describes whatever steps are necessary to get the application up and running. This file also
describes code guidelines and Git flow.

## System information and environment setting up

* Ruby version 2.4.1

* Rails version 5.0.3

* Database PostgreSQL

* Deployment instructions
  * Database creation
    * If you're running the application **_for the first time_** you will probably need to run the command to create the 
      database. Remember to specify witch environment you want before create the database, check the following example:

     <center>**_RAILS_ENV=production rake db:create db:migrate db:seed_**</center>

   	   The above code will create the application database in production mode.

    <center>**_RAILS_ENV=development rake db:create db:migrate db:seed_**</center>

  	   The above code will create the application database in development mode.
   	   
## Code guidelines

With the standardization of code style, our code becomes more readable, organized and intuitive, especially for new 
developers. Remember that much of the life of a project cycle is spent on maintenance and code refactoring. Contribute! 
And let's keep the code organized.

### Avoid monkey patches!

Avoid monkey-patches. The supposed convenience removes maintainability and predictability of the code . Prefer 
thin-wrappers:

```ruby
  # No
  class String
    def to_hash_object
      JSON.parse(self.gsub(/:([a-zA-Z]+)/,'"\\1"').gsub('=>', ': '))
    end
  end

  # Yes
  module WebService
    class Response
      def initialize(string)
        @string = string
      end

      def to_h
        JSON.parse(@string.gsub(/:([a-zA-Z]+)/,'"\\1"').gsub('=>', ': '))
      end
    end
  end
```

### Be descriptive and clear

Use methods and variable names that mean something, rather than trying to be short.

```ruby
  # No
  def verifyToken(token)
    # Check if Facebook token is valid
  end
  
  # Yes
  def verifyFbAccessTokenAuthenticity(token)
    # Check if Facebook token is valid
  end
```

### Soon...

When working with strings, prefer to use single quotation marks instead of double, unless you need to process the 
string.

```ruby
  # No
  puts "Hello World"

  # Yes
  puts 'Hello World'
  puts "Hello World #{user_name}"
```

### Code
#### Formatting

* Each indentation level uses 2 spaces (don't use tabs)
* Break long lines in 80 chars
* Remove additional whitespaces (trailing whitespaces)

#### HTML

```html
    <!-- No -->
    <ul><li>Item1</li><li>Item2</li><li>Item3</li></ul>

    <!-- Yes  -->
    <ul>
      <li>Item1</li>
      <li>Item2</li>
      <li>Item3</li>
    </ul>
```

#### CSS

Attributes like classes and ids, adopt the convention with lower case letter separated by __-__ (dash), the same 
convection used by Foundation & Bootstrap

```html
    <!-- No -->
    <div id='videoArea' class='specialContainer'>

    </div>

    <!-- No -->
    <div id='video_area' class='special_container'>

    </div>

    <!-- Yes -->
    <div id='video-area' class='special-container'>

    </div>
```

#### Javascript
Braces are nice use them always, even for single-line if statements and the like.

```javascript
  // No
  if (true)
    console.log('Hello World');
  else
    console.log('Will never enter here');

  // Yes
  if (true) {
    console.log('Hello World');
  } else {
    console.log('Will never enter here');
  }
```

#### Ruby
Use () when the method accepts arguments, otherwise use nothing

```ruby
    # Yes
    def my_method(argument)
    end

    # No
    def my_method argument
    end

    # Yes
    def my_method
    end

    # No
    def my_method()
    end
 ```
Do not use __;__ to separate expressions, unless when more than one expression is defined per line

```ruby
  # No
  puts 'Hello World';

  # Yes
  puts 'Hello World'
```

#### RSpec

* One assertion per test unit
* In integration tests, you can write more than one assertion to gain more speed
* Use single quotes for description

#### Annotations

* __TODO__ flags a missing feature that needs to be added in the future
* __FIXME__ broken code that needs to be fixed
* __OPTIMIZE__ inefficient code that can be improved
* __REFACTOR__ flags a "code smell" or code that should be refactored in the future

## Git Workflow

#### Commits

* Commit messages should be written in English in present tense. Ex: "Fix failing coupons test"
* Capitalize the subject line
* Summarize changes in around 50 chars or less (the subject)
* To write a good subject line, apply the rule ``If applied, this commit will [your subject line here]``
* Do not end with a period
* Use the imperative mood in the __subject line__
* Be descriptive this helps to read the code timeline
* Adding only files that have correlated changes facilitates the commit message
* Wrap the body at 72 chars

An example of a good git commit

 ```git
 Summarize changes in around 50 characters or less

More detailed explanatory text, if necessary. Wrap it to about 72
characters or so. In some contexts, the first line is treated as the
subject of the commit and the rest of the text as the body. The
blank line separating the summary from the body is critical (unless
you omit the body entirely); various tools like `log`, `shortlog`
and `rebase` can get confused if you run the two together.

Explain the problem that this commit is solving. Focus on why you
are making this change as opposed to how (the code explains that).
Are there side effects or other unintuitive consequences of this
change? Here's the place to explain them.

Further paragraphs come after blank lines.

 - Bullet points are okay, too

 - Typically a hyphen or asterisk is used for the bullet, preceded
   by a single space, with blank lines in between, but conventions
   vary here

If you use an issue tracker, put references to them at the bottom,
like this:

Resolves: #123
See also: #456, #789
 ```
 