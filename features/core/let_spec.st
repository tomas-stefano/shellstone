"Feature: let (memoized helpers)"

Namespace current: ShellStone [

Describe the: 'let' do: [:spec |
  spec context: 'basic usage' do: [:ctx |
    ctx let: #value do: [42].

    ctx it: 'provides access to defined value' do: [
      ctx value should equal: 42.
    ].

    ctx it: 'works in multiple examples' do: [
      ctx value should equal: 42.
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
      callCount should equal: 0.
      ctx lazyValue.
      callCount should equal: 1.
    ].

    ctx it: 'resets between examples' do: [
      callCount should equal: 0.
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
      evalCount should equal: 1.
    ].
  ].

  spec context: 'composing lets' do: [:ctx |
    ctx let: #first do: ['hello'].
    ctx let: #second do: [(ctx first), ' world'].

    ctx it: 'can reference other lets' do: [
      ctx second should equal: 'hello world'.
    ].
  ].

  spec context: 'with different types' do: [:ctx |
    ctx let: #aString do: ['test string'].
    ctx let: #aNumber do: [42].
    ctx let: #aCollection do: [OrderedCollection with: 1 with: 2 with: 3].

    ctx it: 'works with strings' do: [
      ctx aString should equal: 'test string'.
    ].

    ctx it: 'works with numbers' do: [
      ctx aNumber should equal: 42.
    ].

    ctx it: 'works with collections' do: [
      ctx aCollection size should equal: 3.
      ctx aCollection should include: 2.
    ].
  ].
].

]
