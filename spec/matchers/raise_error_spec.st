"Specs for the RaiseError matcher"

ShellStone.Describe the: 'RaiseErrorMatcher' do: [:spec |

    spec it: 'passes when block raises any error' do: [
        [Error signal: 'test'] should raiseError.
    ].

    spec it: 'passes when block raises specific error type' do: [
        [ZeroDivide signal] should raiseError: ZeroDivide.
    ].

    spec it: 'fails when block does not raise error' do: [
        [1 + 1] shouldNot raiseError.
    ].

    spec it: 'fails when block raises different error type' do: [
        [Error signal: 'test'] shouldNot raiseError: ZeroDivide.
    ].
].
