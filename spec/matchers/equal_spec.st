ShellStone.Describe the: Equal do: [ :example |
  example it: 'should matches when actual is equal to expected' do: [
    1 should be equal: 1
  ].
  
  example it: 'should does not match when actual is different to expected' do: [
    1 should_not be equal: 2
  ].
]