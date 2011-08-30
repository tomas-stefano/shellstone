ShellStone
==========

Behavior Driven Development for Smalltalk

Usage
-----

      Describe the: Person do: [ :example |
        example it: 'should be an instance of Person' do: [
          Person new should be an instance of: Person
        ].
      ]

Hooks
-----

    Describe the: Person do: [ :example |
      "Or you can call just call setUp"
      example before: #all do: [
      ]
      
      example before: #each do: [
        
      ]

      "Or you can call just call tearDown"      
      example after: #all do: [
      ]
      
      example after: #each do: [
      ]
    ]

Running
-------

    $ shellstone --help
