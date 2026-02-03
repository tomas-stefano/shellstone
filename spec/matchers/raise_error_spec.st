"Specs for the RaiseError matcher"

ShellStone.Describe the: 'RaiseErrorMatcher' do: [:spec |

    spec context: 'expect syntax' do: [:ctx |
        ctx it: 'passes when block raises any error' do: [
            (self expect: [Error signal: 'test']) to raiseError.
        ].

        ctx it: 'passes when block raises specific error type' do: [
            (self expect: [ZeroDivide signal]) to raiseError: ZeroDivide.
        ].

        ctx it: 'fails when block does not raise error' do: [
            (self expect: [1 + 1]) toNot raiseError.
        ].

        ctx it: 'fails when block raises different error type' do: [
            (self expect: [Error signal: 'test']) toNot raiseError: ZeroDivide.
        ].
    ].

    spec context: 'should syntax' do: [:ctx |
        ctx it: 'passes when block raises any error' do: [
            [Error signal: 'test'] should raiseError.
        ].

        ctx it: 'passes when block raises specific error type' do: [
            [ZeroDivide signal] should raiseError: ZeroDivide.
        ].

        ctx it: 'fails when block does not raise error' do: [
            [1 + 1] shouldNot raiseError.
        ].

        ctx it: 'fails when block raises different error type' do: [
            [Error signal: 'test'] shouldNot raiseError: ZeroDivide.
        ].
    ].
].
