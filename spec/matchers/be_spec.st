"Specs for the Be matcher"

ShellStone.Describe the: 'BeMatcher' do: [:spec |

    spec context: 'expect syntax' do: [:ctx |
        ctx context: 'truthy' do: [:inner |
            inner it: 'passes for true' do: [
                (self expect: true) to beTruthy.
            ].

            inner it: 'passes for non-nil values' do: [
                (self expect: 1) to beTruthy.
                (self expect: 'hello') to beTruthy.
            ].

            inner it: 'fails for false' do: [
                (self expect: false) toNot beTruthy.
            ].

            inner it: 'fails for nil' do: [
                (self expect: nil) toNot beTruthy.
            ].
        ].

        ctx context: 'falsy' do: [:inner |
            inner it: 'passes for false' do: [
                (self expect: false) to beFalsy.
            ].

            inner it: 'passes for nil' do: [
                (self expect: nil) to beFalsy.
            ].

            inner it: 'fails for true' do: [
                (self expect: true) toNot beFalsy.
            ].
        ].

        ctx context: 'nil' do: [:inner |
            inner it: 'passes for nil' do: [
                (self expect: nil) to beNil.
            ].

            inner it: 'fails for non-nil' do: [
                (self expect: 1) toNot beNil.
            ].
        ].

        ctx context: 'true and false' do: [:inner |
            inner it: 'beTrue passes for true' do: [
                (self expect: true) to beTrue.
            ].

            inner it: 'beFalse passes for false' do: [
                (self expect: false) to beFalse.
            ].
        ].
    ].

    spec context: 'should syntax' do: [:ctx |
        ctx context: 'truthy' do: [:inner |
            inner it: 'passes for true' do: [
                true should beTruthy.
            ].

            inner it: 'passes for non-nil values' do: [
                1 should beTruthy.
                'hello' should beTruthy.
            ].

            inner it: 'fails for false' do: [
                false shouldNot beTruthy.
            ].

            inner it: 'fails for nil' do: [
                nil shouldNot beTruthy.
            ].
        ].

        ctx context: 'falsy' do: [:inner |
            inner it: 'passes for false' do: [
                false should beFalsy.
            ].

            inner it: 'passes for nil' do: [
                nil should beFalsy.
            ].

            inner it: 'fails for true' do: [
                true shouldNot beFalsy.
            ].
        ].

        ctx context: 'nil' do: [:inner |
            inner it: 'passes for nil' do: [
                nil should beNil.
            ].

            inner it: 'fails for non-nil' do: [
                1 shouldNot beNil.
            ].
        ].

        ctx context: 'true and false' do: [:inner |
            inner it: 'beTrue passes for true' do: [
                true should beTrue.
            ].

            inner it: 'beFalse passes for false' do: [
                false should beFalse.
            ].
        ].
    ].
].
