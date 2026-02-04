"Specs for the Equal matcher"

ShellStone.Describe the: 'EqualMatcher' do: [:spec |

    spec context: 'expect syntax' do: [:ctx |
        ctx context: 'with equal values' do: [:inner |
            inner it: 'passes when integers are equal' do: [
                (self expect: 1) to equal: 1.
            ].

            inner it: 'passes when strings are equal' do: [
                (self expect: 'hello') to equal: 'hello'.
            ].

            inner it: 'passes when arrays are equal' do: [
                (self expect: #(1 2 3)) to equal: #(1 2 3).
            ].
        ].

        ctx context: 'with different values' do: [:inner |
            inner it: 'fails when integers differ' do: [
                (self expect: 1) toNot equal: 2.
            ].

            inner it: 'fails when strings differ' do: [
                (self expect: 'hello') toNot equal: 'world'.
            ].
        ].

        ctx context: 'with nil' do: [:inner |
            inner it: 'passes when both are nil' do: [
                (self expect: nil) to equal: nil.
            ].

            inner it: 'fails when one is nil' do: [
                (self expect: nil) toNot equal: 1.
            ].
        ].
    ].

    spec context: 'should syntax' do: [:ctx |
        ctx context: 'with equal values' do: [:inner |
            inner it: 'passes when integers are equal' do: [
                1 should equal: 1.
            ].

            inner it: 'passes when strings are equal' do: [
                'hello' should equal: 'hello'.
            ].

            inner it: 'passes when arrays are equal' do: [
                #(1 2 3) should equal: #(1 2 3).
            ].
        ].

        ctx context: 'with different values' do: [:inner |
            inner it: 'fails when integers differ' do: [
                1 shouldNot equal: 2.
            ].

            inner it: 'fails when strings differ' do: [
                'hello' shouldNot equal: 'world'.
            ].
        ].

        ctx context: 'with nil' do: [:inner |
            inner it: 'passes when both are nil' do: [
                nil should equal: nil.
            ].

            inner it: 'fails when one is nil' do: [
                nil shouldNot equal: 1.
            ].
        ].
    ].
].
