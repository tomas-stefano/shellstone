"Specs for the Equal matcher"

ShellStone.Describe the: 'EqualMatcher' do: [:spec |

    spec context: 'with equal values' do: [:ctx |
        ctx it: 'passes when integers are equal' do: [
            1 should equal: 1.
        ].

        ctx it: 'passes when strings are equal' do: [
            'hello' should equal: 'hello'.
        ].

        ctx it: 'passes when arrays are equal' do: [
            #(1 2 3) should equal: #(1 2 3).
        ].
    ].

    spec context: 'with different values' do: [:ctx |
        ctx it: 'fails when integers differ' do: [
            1 shouldNot equal: 2.
        ].

        ctx it: 'fails when strings differ' do: [
            'hello' shouldNot equal: 'world'.
        ].
    ].

    spec context: 'with nil' do: [:ctx |
        ctx it: 'passes when both are nil' do: [
            nil should equal: nil.
        ].

        ctx it: 'fails when one is nil' do: [
            nil shouldNot equal: 1.
        ].
    ].
].
