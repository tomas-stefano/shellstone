"Specs for the Describe DSL entry point"

ShellStone.Describe the: 'Describe' do: [:spec |

    spec it: 'creates an example group' do: [
        ShellStone.World instance groups shouldNot beNil.
    ].

    spec it: 'allows string descriptions' do: [
        "This test itself demonstrates string descriptions work"
        true should beTrue.
    ].

    spec context: 'nested contexts' do: [:ctx |
        ctx it: 'supports nested describe blocks' do: [
            true should beTrue.
        ].

        ctx context: 'deeply nested' do: [:inner |
            inner it: 'can nest multiple levels' do: [
                true should beTrue.
            ].
        ].
    ].
].
