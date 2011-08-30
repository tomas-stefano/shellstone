Object subclass: Runner [
  <category: 'Extensions'>
  <comment: 'Class Responsible to manage all the users specifications.'>
  |options spec_files load_path|
  load_path := ''.
  
  Runner class >> new [
    ^self basicNew initialize
  ]
  
  Runner class >> load_path: aPath [
    load_path := aPath.
    ^load_path
  ]
  
  Runner class >> get_load_path [
    ^load_path
  ]
  
  initialize [
    options := OptionsParser new.
    spec_files := Set new.
    ^self
  ]
  
  options_parser [
    <comment: 'Return the options_parser instance variable.'>
    ^options
  ]
  
  files_to_test [
    <comment: 'Return the spec_files instance variable.'>
    ^spec_files
  ]

  start [
    self load_spec_helper.
    self load_files_from_load_path.
    self load_spec_files.
    ^self
  ]
  
  load_spec_helper [
    "TODO: Change this to user config"
    Directory working allFilesMatching: 'spec/spec_helper.st' do: [:file | 
      FileStream fileIn: file asString
    ].
  ]
  
  load_files_from_load_path [
    |a_load_path|
    self class get_load_path isEmpty ifFalse: [
      "TODO: Change this to user config"
      a_load_path := self class get_load_path, '/*/*.st'.
      Directory working allFilesMatching: a_load_path do: [:file | 
        FileStream fileIn: (file asString) 
      ].
    ].
    ^self
  ]
  
  " Find spec files match by the pattern *_spec.st in spec folder"
  find_spec_files [
    "TODO: Change this to user config"
    Directory working allFilesMatching: 'spec/*/*_spec.st' do: [ :file | spec_files add: file ]
  ]
  
  load_spec_files [
    self find_spec_files.
    spec_files do: [ :spec_file | FileStream fileIn: spec_file asString ]
  ]
]