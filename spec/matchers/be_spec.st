"Specs for the Be matcher"

ShellStone.Describe the: 'BeMatcher' do: [:spec |

    spec context: 'truthy' do: [:ctx |
        ctx it: 'passes for true' do: [
            true should beTruthy.
        ].

        ctx it: 'passes for non-nil values' do: [
            1 should beTruthy.
            'hello' should beTruthy.
        ].

        ctx it: 'fails for false' do: [
            false shouldNot beTruthy.
        ].

        ctx it: 'fails for nil' do: [
            nil shouldNot beTruthy.
        ].
    ].

    spec context: 'falsy' do: [:ctx |
        ctx it: 'passes for false' do: [
            false should beFalsy.
        ].

        ctx it: 'passes for nil' do: [
            nil should beFalsy.
        ].

        ctx it: 'fails for true' do: [
            true shouldNot beFalsy.
        ].
    ].

    spec context: 'nil' do: [:ctx |
        ctx it: 'passes for nil' do: [
            nil should beNil.
        ].

        ctx it: 'fails for non-nil' do: [
            1 shouldNot beNil.
        ].
    ].

    spec context: 'true and false' do: [:ctx |
        ctx it: 'beTrue passes for true' do: [
            true should beTrue.
        ].

        ctx it: 'beFalse passes for false' do: [
            false should beFalse.
        ].
    ].
].
