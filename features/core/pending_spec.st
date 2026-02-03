"Feature: pending examples"

Namespace current: ShellStone [

Describe the: 'pending examples' do: [:spec |
  spec context: 'implicit pending (no block)' do: [:ctx |
    ctx it: 'is pending without a block'.

    ctx it: 'another pending example'.
  ].

  spec context: 'regular examples still work' do: [:ctx |
    ctx it: 'this example runs normally' do: [
      (self expect: true) to equal: true.
    ].

    ctx it: 'pending without block'.

    ctx it: 'this also runs normally' do: [
      (self expect: 1) to equal: 1.
    ].
  ].
].

]
