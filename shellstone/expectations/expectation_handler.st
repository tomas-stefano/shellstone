Object subclass: ExpectationHandler [
  <category: 'Expectations'>
  <comment: ''>
  
  ExpectationHandler class >> new: anObject [
    ^self basicNew initialize: anObject
  ]
  
  initialize: anObject [
    ^self
  ]
  
  "Helper methods to be a syntax sugar for specs"
  be [
  ]
  
  a [
  ]
  
  an [
  ]
]