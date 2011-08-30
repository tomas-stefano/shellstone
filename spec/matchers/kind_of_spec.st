ShellStone.Describe the: KindOf do: [ :example |
  example it: 'passes if actual is instance of expected' do: [
    5 should be kind_of: SmallInteger
  ].
  
  example it: 'passes if actual is of subclass of expcted class' do: [
    5 should be a kind_of: Integer
  ].
  
"  example it: 'fails for should unless actual is kind of expected' do: [
    expect: [ 5 should be kind_of: Array ] to: raise_error
  ].
  
  example it: 'fails for should not if actual os kind of expected' do: [
    expected: [ 'a' should_not be kind_of: String ] to: fail_example
  ]
"
]