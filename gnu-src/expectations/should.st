"Wire up should/should_not to Object and expect: factory"

"Extend Object to provide should/should_not syntax (legacy) and expect:"
Object extend [
  should [
    ^ShellStone.PositiveHandler for: self
  ]

  shouldNot [
    ^ShellStone.NegativeHandler for: self
  ]

  "Alias for Ruby-style snake_case"
  should_not [
    ^self shouldNot
  ]

  "RSpec 3 style expect: factory - returns ExpectationTarget"
  expect: aValue [
    ^ShellStone.ExpectationTarget for: aValue
  ]
]

"Extend BlockClosure for block-based expectations (raise_error, change)"
BlockClosure extend [
  should [
    ^ShellStone.PositiveHandler for: self
  ]

  shouldNot [
    ^ShellStone.NegativeHandler for: self
  ]

  should_not [
    ^self shouldNot
  ]

  "RSpec 3 style expect: factory"
  expect: aValue [
    ^ShellStone.ExpectationTarget for: aValue
  ]
]
