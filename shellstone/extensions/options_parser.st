Object subclass: OptionsParser [
  <category: 'Extensions'>
  <comment: 'Class Responsible to handle the Command Line Arguments'>
  
  OptionsParser class >> new [
    ^self basicNew initialize
  ]
  
  initialize [
    <comment: 'Initializing the OptionsParser and set the options in instance variables.'>
    |help_string|
    
    help_string := 'Usage: shellstone [files or directories]'.
    Smalltalk arguments: '-h|--help' do: [ :opt :arg |
      opt = 'help' ifTrue: [
        help_string displayOn: stdout.
        ObjectMemory quit: 0
      ].
    ]
  ]
]