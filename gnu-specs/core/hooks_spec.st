"Specs for hooks (before/after)"

| hookCounter |
hookCounter := 0.

ShellStone.Describe the: 'Hooks' do: [:spec |

    spec before: #each do: [
        hookCounter := hookCounter + 1.
    ].

    spec context: 'expect syntax' do: [:ctx |
        ctx it: 'runs before each example' do: [
            (self expect: hookCounter) to beGreaterThan: 0.
        ].

        ctx it: 'runs before each example again' do: [
            (self expect: hookCounter) to beGreaterThan: 1.
        ].

        ctx context: 'nested context' do: [:inner |
            inner before: #each do: [
                "Child before hook"
            ].

            inner it: 'inherits parent before hooks' do: [
                (self expect: hookCounter) to beGreaterThan: 2.
            ].
        ].
    ].

    spec context: 'should syntax' do: [:ctx |
        ctx it: 'runs before each example' do: [
            hookCounter should beGreaterThan: 0.
        ].

        ctx it: 'runs before each example again' do: [
            hookCounter should beGreaterThan: 1.
        ].

        ctx context: 'nested context' do: [:inner |
            inner before: #each do: [
                "Child before hook"
            ].

            inner it: 'inherits parent before hooks' do: [
                hookCounter should beGreaterThan: 2.
            ].
        ].
    ].
].
