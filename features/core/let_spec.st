"Feature: let (memoized helpers)"

Namespace current: ShellStone [

Describe the: 'let' do: [:spec |
  spec context: 'basic usage' do: [:ctx |
    ctx let: #value do: [42].

    ctx it: 'provides access to defined value' do: [
      (self expect: ctx value) to equal: 42.
    ].

    ctx it: 'works in multiple examples' do: [
      (self expect: ctx value) to equal: 42.
    ].
  ].

  spec context: 'lazy evaluation' do: [:ctx |
    | callCount |

    ctx before: #each do: [
      callCount := 0.
    ].

    ctx let: #lazyValue do: [
      callCount := callCount + 1.
      'computed'
    ].

    ctx it: 'does not evaluate until accessed' do: [
      (self expect: callCount) to equal: 0.
      ctx lazyValue.
      (self expect: callCount) to equal: 1.
    ].

    ctx it: 'resets between examples' do: [
      (self expect: callCount) to equal: 0.
    ].
  ].

  spec context: 'memoization' do: [:ctx |
    | evalCount |

    ctx before: #each do: [
      evalCount := 0.
    ].

    ctx let: #memoized do: [
      evalCount := evalCount + 1.
      'result'
    ].

    ctx it: 'evaluates only once per example' do: [
      ctx memoized.
      ctx memoized.
      ctx memoized.
      (self expect: evalCount) to equal: 1.
    ].
  ].

  spec context: 'composing lets' do: [:ctx |
    ctx let: #first do: ['hello'].
    ctx let: #second do: [(ctx first), ' world'].

    ctx it: 'can reference other lets' do: [
      (self expect: ctx second) to equal: 'hello world'.
    ].
  ].

  spec context: 'with different types' do: [:ctx |
    ctx let: #aString do: ['test string'].
    ctx let: #aNumber do: [42].
    ctx let: #aCollection do: [OrderedCollection with: 1 with: 2 with: 3].

    ctx it: 'works with strings' do: [
      (self expect: ctx aString) to equal: 'test string'.
    ].

    ctx it: 'works with numbers' do: [
      (self expect: ctx aNumber) to equal: 42.
    ].

    ctx it: 'works with collections' do: [
      (self expect: ctx aCollection size) to equal: 3.
      (self expect: ctx aCollection) to include: 2.
    ].
  ].
].

]
