ShellStone
==========

Behavior Driven Development for Smalltalk

Usage
-----

      Describe the: Person do: [
        should_return_the_fullname [
          |person|
          person := Person new firstname: 'Tomas' lastname: 'Stefano'.
          person fullname should be_equal: 'Tomas Stefano'
        ]
      ]

Expectations
------------

      #be_equal
      #be_true
      #be_false
      #be_nil
      #include
      #be_instance_of
      #be_kind_of
      #respond_to
      #raise
      #include
      #have: <n> items
      #have at least: <n> items
      #have at most: <n> items

Hooks
-----

    Describe the: Person do: [
      "Or you can call just call setUp"
      self before: #all [
      ]
      
      self before: #each [
        
      ]

      "Or you can call just call tearDown"      
      self after: #all [
      ]
      
      self after: #each [
      ]
    ]

Running
-------

    $ shellstone --help
