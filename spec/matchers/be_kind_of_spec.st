"Specs for the BeKindOf matcher"

ShellStone.Describe the: 'BeKindOfMatcher' do: [:spec |

    spec context: 'expect syntax' do: [:ctx |
        ctx it: 'passes when actual is instance of expected class' do: [
            (self expect: 5) to beKindOf: SmallInteger.
        ].

        ctx it: 'passes when actual is instance of a subclass' do: [
            (self expect: 5) to beKindOf: Integer.
            (self expect: 5) to beKindOf: Number.
        ].

        ctx it: 'fails when actual is not of expected type' do: [
            (self expect: 'hello') toNot beKindOf: Integer.
        ].

        ctx context: 'with beA alias' do: [:inner |
            inner it: 'works the same as beKindOf' do: [
                (self expect: 'hello') to beA: String.
            ].

            inner it: 'beAn works for vowel class names' do: [
                (self expect: #(1 2 3)) to beAn: Array.
            ].
        ].
    ].

    spec context: 'should syntax' do: [:ctx |
        ctx it: 'passes when actual is instance of expected class' do: [
            5 should beKindOf: SmallInteger.
        ].

        ctx it: 'passes when actual is instance of a subclass' do: [
            5 should beKindOf: Integer.
            5 should beKindOf: Number.
        ].

        ctx it: 'fails when actual is not of expected type' do: [
            'hello' shouldNot beKindOf: Integer.
        ].

        ctx context: 'with beA alias' do: [:inner |
            inner it: 'works the same as beKindOf' do: [
                'hello' should beA: String.
            ].

            inner it: 'beAn works for vowel class names' do: [
                #(1 2 3) should beAn: Array.
            ].
        ].
    ].
].
