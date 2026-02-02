"Feature: raiseError matcher"

Namespace current: ShellStone [

Describe the: 'raiseError matcher' do: [:spec |
  spec context: 'any error' do: [:ctx |
    ctx it: 'passes when block raises any error' do: [
      [self error: 'boom'] should raiseError.
    ].

    ctx it: 'passes when block raises ZeroDivide' do: [
      [1 / 0] should raiseError.
    ].

    ctx it: 'fails when block does not raise' do: [
      [1 + 1] shouldNot raiseError.
    ].

    ctx it: 'fails for normal return with shouldNot' do: [
      ['hello'] shouldNot raiseError.
    ].
  ].

  spec context: 'specific error class' do: [:ctx |
    ctx it: 'passes for matching error class' do: [
      [1 / 0] should raiseError: ZeroDivide.
    ].

    ctx it: 'passes for Error class' do: [
      [self error: 'message'] should raiseError: Error.
    ].

    ctx it: 'fails for wrong error class with shouldNot' do: [
      [1 / 0] shouldNot raiseError: MessageNotUnderstood.
    ].
  ].

  spec context: 'error from method calls' do: [:ctx |
    ctx it: 'catches message not understood' do: [
      [Object new unknownMethod] should raiseError: MessageNotUnderstood.
    ].

    ctx it: 'catches index out of bounds' do: [
      [#(1 2 3) at: 10] should raiseError.
    ].
  ].

  spec context: 'nested blocks' do: [:ctx |
    ctx it: 'catches errors from nested blocks' do: [
      [
        | x |
        x := [self error: 'inner'].
        x value.
      ] should raiseError.
    ].
  ].
].

]
