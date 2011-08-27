Describe the: Equal do: [
  self it: 'should matches when actual is equal to expected' [
    1 should equal: 1
  ]
  
  self it: 'should does not match when actual is different to expected' [
    1 should_not equal: 2
  ]
]