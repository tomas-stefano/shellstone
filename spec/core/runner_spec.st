ShellStone.Describe the: Runner do: [ :example |
  example it: 'options parser should be instance of OptionsParser' do: [
    Runner new options_parser should be instance_of: OptionsParser
  ].
  
  example it: 'the files to test should be instance of a Set' do: [
    Runner new files_to_test should be instance_of: Set
  ].
]