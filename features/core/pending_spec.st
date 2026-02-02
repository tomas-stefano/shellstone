"Feature: pending examples"

Namespace current: ShellStone [

Describe the: 'pending examples' do: [:spec |
  spec context: 'implicit pending (no block)' do: [:ctx |
    ctx it: 'is pending without a block'.

    ctx it: 'another pending example'.
  ].

  spec context: 'regular examples still work' do: [:ctx |
    ctx it: 'this example runs normally' do: [
      true should equal: true.
    ].

    ctx it: 'pending without block'.

    ctx it: 'this also runs normally' do: [
      1 should equal: 1.
    ].
  ].
].

]
