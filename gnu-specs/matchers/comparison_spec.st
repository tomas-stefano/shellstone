"Specs for comparison matchers"

ShellStone.Describe the: 'ComparisonMatcher' do: [:spec |

    spec context: 'expect syntax' do: [:ctx |
        ctx context: 'greater than' do: [:inner |
            inner it: 'passes when actual > expected' do: [
                (self expect: 5) to beGreaterThan: 3.
            ].

            inner it: 'fails when actual <= expected' do: [
                (self expect: 3) toNot beGreaterThan: 5.
                (self expect: 3) toNot beGreaterThan: 3.
            ].
        ].

        ctx context: 'less than' do: [:inner |
            inner it: 'passes when actual < expected' do: [
                (self expect: 3) to beLessThan: 5.
            ].

            inner it: 'fails when actual >= expected' do: [
                (self expect: 5) toNot beLessThan: 3.
                (self expect: 3) toNot beLessThan: 3.
            ].
        ].

        ctx context: 'greater than or equal to' do: [:inner |
            inner it: 'passes when actual >= expected' do: [
                (self expect: 5) to beGreaterThanOrEqualTo: 3.
                (self expect: 5) to beGreaterThanOrEqualTo: 5.
            ].

            inner it: 'fails when actual < expected' do: [
                (self expect: 3) toNot beGreaterThanOrEqualTo: 5.
            ].
        ].

        ctx context: 'less than or equal to' do: [:inner |
            inner it: 'passes when actual <= expected' do: [
                (self expect: 3) to beLessThanOrEqualTo: 5.
                (self expect: 3) to beLessThanOrEqualTo: 3.
            ].

            inner it: 'fails when actual > expected' do: [
                (self expect: 5) toNot beLessThanOrEqualTo: 3.
            ].
        ].
    ].

    spec context: 'should syntax' do: [:ctx |
        ctx context: 'greater than' do: [:inner |
            inner it: 'passes when actual > expected' do: [
                5 should beGreaterThan: 3.
            ].

            inner it: 'fails when actual <= expected' do: [
                3 shouldNot beGreaterThan: 5.
                3 shouldNot beGreaterThan: 3.
            ].
        ].

        ctx context: 'less than' do: [:inner |
            inner it: 'passes when actual < expected' do: [
                3 should beLessThan: 5.
            ].

            inner it: 'fails when actual >= expected' do: [
                5 shouldNot beLessThan: 3.
                3 shouldNot beLessThan: 3.
            ].
        ].

        ctx context: 'greater than or equal to' do: [:inner |
            inner it: 'passes when actual >= expected' do: [
                5 should beGreaterThanOrEqualTo: 3.
                5 should beGreaterThanOrEqualTo: 5.
            ].

            inner it: 'fails when actual < expected' do: [
                3 shouldNot beGreaterThanOrEqualTo: 5.
            ].
        ].

        ctx context: 'less than or equal to' do: [:inner |
            inner it: 'passes when actual <= expected' do: [
                3 should beLessThanOrEqualTo: 5.
                3 should beLessThanOrEqualTo: 3.
            ].

            inner it: 'fails when actual > expected' do: [
                5 shouldNot beLessThanOrEqualTo: 3.
            ].
        ].
    ].
].
