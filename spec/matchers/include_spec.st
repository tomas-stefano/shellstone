"Specs for the Include matcher"

ShellStone.Describe the: 'IncludeMatcher' do: [:spec |

    spec context: 'with arrays' do: [:ctx |
        ctx it: 'passes when array includes item' do: [
            #(1 2 3) should include: 2.
        ].

        ctx it: 'fails when array does not include item' do: [
            #(1 2 3) shouldNot include: 5.
        ].
    ].

    spec context: 'with strings' do: [:ctx |
        ctx it: 'passes when string includes substring' do: [
            'hello world' should include: 'world'.
        ].

        ctx it: 'fails when string does not include substring' do: [
            'hello world' shouldNot include: 'foo'.
        ].
    ].

    spec context: 'with sets' do: [:ctx |
        ctx it: 'passes when set includes item' do: [
            (Set with: 1 with: 2 with: 3) should include: 2.
        ].
    ].
].
