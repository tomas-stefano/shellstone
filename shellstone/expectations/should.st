Object extend [
  should [
    ^PositiveExpectationHandler new: self
  ]
  
  should_not [
    ^NegativeExpectationHandler new: self
  ]
]