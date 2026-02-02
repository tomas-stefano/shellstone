"Wire up should/should_not to Object"

"Extend Object to provide should/should_not syntax"
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
]
