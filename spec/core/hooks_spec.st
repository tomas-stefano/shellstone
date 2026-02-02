"Specs for hooks (before/after)"

| hookCounter |
hookCounter := 0.

ShellStone.Describe the: 'Hooks' do: [:spec |

    spec before: #each do: [
        hookCounter := hookCounter + 1.
    ].

    spec it: 'runs before each example' do: [
        hookCounter should beGreaterThan: 0.
    ].

    spec it: 'runs before each example again' do: [
        hookCounter should beGreaterThan: 1.
    ].

    spec context: 'nested context' do: [:ctx |
        ctx before: #each do: [
            "Child before hook"
        ].

        ctx it: 'inherits parent before hooks' do: [
            hookCounter should beGreaterThan: 2.
        ].
    ].
].
