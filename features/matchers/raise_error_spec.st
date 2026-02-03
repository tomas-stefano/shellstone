"Feature: raiseError matcher"

Namespace current: ShellStone [

Describe the: 'raiseError matcher' do: [:spec |
  spec context: 'any error' do: [:ctx |
    ctx it: 'passes when block raises any error' do: [
      (self expect: [self error: 'boom']) to raiseError.
    ].

    ctx it: 'passes when block raises ZeroDivide' do: [
      (self expect: [1 / 0]) to raiseError.
    ].

    ctx it: 'fails when block does not raise' do: [
      (self expect: [1 + 1]) toNot raiseError.
    ].

    ctx it: 'fails for normal return with toNot' do: [
      (self expect: ['hello']) toNot raiseError.
    ].
  ].

  spec context: 'specific error class' do: [:ctx |
    ctx it: 'passes for matching error class' do: [
      (self expect: [1 / 0]) to raiseError: ZeroDivide.
    ].

    ctx it: 'passes for Error class' do: [
      (self expect: [self error: 'message']) to raiseError: Error.
    ].

    ctx it: 'fails for wrong error class with toNot' do: [
      (self expect: [1 / 0]) toNot raiseError: MessageNotUnderstood.
    ].
  ].

  spec context: 'error from method calls' do: [:ctx |
    ctx it: 'catches message not understood' do: [
      (self expect: [Object new unknownMethod]) to raiseError: MessageNotUnderstood.
    ].

    ctx it: 'catches index out of bounds' do: [
      (self expect: [#(1 2 3) at: 10]) to raiseError.
    ].
  ].

  spec context: 'nested blocks' do: [:ctx |
    ctx it: 'catches errors from nested blocks' do: [
      (self expect: [
        | x |
        x := [self error: 'inner'].
        x value.
      ]) to raiseError.
    ].
  ].
].

]
