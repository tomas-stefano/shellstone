"Specs for comparison matchers"

ShellStone.Describe the: 'ComparisonMatcher' do: [:spec |

    spec context: 'greater than' do: [:ctx |
        ctx it: 'passes when actual > expected' do: [
            5 should beGreaterThan: 3.
        ].

        ctx it: 'fails when actual <= expected' do: [
            3 shouldNot beGreaterThan: 5.
            3 shouldNot beGreaterThan: 3.
        ].
    ].

    spec context: 'less than' do: [:ctx |
        ctx it: 'passes when actual < expected' do: [
            3 should beLessThan: 5.
        ].

        ctx it: 'fails when actual >= expected' do: [
            5 shouldNot beLessThan: 3.
            3 shouldNot beLessThan: 3.
        ].
    ].

    spec context: 'greater than or equal to' do: [:ctx |
        ctx it: 'passes when actual >= expected' do: [
            5 should beGreaterThanOrEqualTo: 3.
            5 should beGreaterThanOrEqualTo: 5.
        ].

        ctx it: 'fails when actual < expected' do: [
            3 shouldNot beGreaterThanOrEqualTo: 5.
        ].
    ].

    spec context: 'less than or equal to' do: [:ctx |
        ctx it: 'passes when actual <= expected' do: [
            3 should beLessThanOrEqualTo: 5.
            3 should beLessThanOrEqualTo: 3.
        ].

        ctx it: 'fails when actual > expected' do: [
            5 shouldNot beLessThanOrEqualTo: 3.
        ].
    ].
].
