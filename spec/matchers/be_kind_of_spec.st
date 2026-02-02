"Specs for the BeKindOf matcher"

ShellStone.Describe the: 'BeKindOfMatcher' do: [:spec |

    spec it: 'passes when actual is instance of expected class' do: [
        5 should beKindOf: SmallInteger.
    ].

    spec it: 'passes when actual is instance of a subclass' do: [
        5 should beKindOf: Integer.
        5 should beKindOf: Number.
    ].

    spec it: 'fails when actual is not of expected type' do: [
        'hello' shouldNot beKindOf: Integer.
    ].

    spec context: 'with beA alias' do: [:ctx |
        ctx it: 'works the same as beKindOf' do: [
            'hello' should beA: String.
        ].

        ctx it: 'beAn works for vowel class names' do: [
            #(1 2 3) should beAn: Array.
        ].
    ].
].
