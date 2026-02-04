"Specs for the Describe DSL entry point"

ShellStone.Describe the: 'Describe' do: [:spec |

    spec context: 'expect syntax' do: [:ctx |
        ctx it: 'creates an example group' do: [
            (self expect: ShellStone.World instance groups) toNot beNil.
        ].

        ctx it: 'allows string descriptions' do: [
            (self expect: true) to beTrue.
        ].

        ctx context: 'nested contexts' do: [:inner |
            inner it: 'supports nested describe blocks' do: [
                (self expect: true) to beTrue.
            ].

            inner context: 'deeply nested' do: [:deeper |
                deeper it: 'can nest multiple levels' do: [
                    (self expect: true) to beTrue.
                ].
            ].
        ].
    ].

    spec context: 'should syntax' do: [:ctx |
        ctx it: 'creates an example group' do: [
            ShellStone.World instance groups shouldNot beNil.
        ].

        ctx it: 'allows string descriptions' do: [
            true should beTrue.
        ].

        ctx context: 'nested contexts' do: [:inner |
            inner it: 'supports nested describe blocks' do: [
                true should beTrue.
            ].

            inner context: 'deeply nested' do: [:deeper |
                deeper it: 'can nest multiple levels' do: [
                    true should beTrue.
                ].
            ].
        ].
    ].
].
