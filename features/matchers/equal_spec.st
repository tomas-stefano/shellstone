"Feature: equal matcher"

Namespace current: ShellStone [

Describe the: 'equal matcher' do: [:spec |
  spec context: 'with identical values' do: [:ctx |
    ctx it: 'passes for equal integers' do: [
      1 should equal: 1.
    ].

    ctx it: 'passes for equal strings' do: [
      'hello' should equal: 'hello'.
    ].

    ctx it: 'passes for equal symbols' do: [
      #foo should equal: #foo.
    ].

    ctx it: 'passes for equal arrays' do: [
      #(1 2 3) should equal: #(1 2 3).
    ].

    ctx it: 'passes for equal booleans' do: [
      true should equal: true.
      false should equal: false.
    ].

    ctx it: 'passes for nil' do: [
      nil should equal: nil.
    ].
  ].

  spec context: 'with different values' do: [:ctx |
    ctx it: 'passes for unequal integers with shouldNot' do: [
      1 shouldNot equal: 2.
    ].

    ctx it: 'passes for unequal strings with shouldNot' do: [
      'hello' shouldNot equal: 'world'.
    ].

    ctx it: 'passes for different types with shouldNot' do: [
      1 shouldNot equal: '1'.
      'true' shouldNot equal: true.
    ].
  ].

  spec context: 'with collections' do: [:ctx |
    ctx it: 'compares ordered collections' do: [
      | a b |
      a := OrderedCollection with: 1 with: 2.
      b := OrderedCollection with: 1 with: 2.
      a should equal: b.
    ].

    ctx it: 'compares dictionaries' do: [
      | a b |
      a := Dictionary new at: 'key' put: 'value'; yourself.
      b := Dictionary new at: 'key' put: 'value'; yourself.
      a should equal: b.
    ].

    ctx it: 'detects different collection contents' do: [
      #(1 2 3) shouldNot equal: #(1 2 4).
    ].

    ctx it: 'detects different collection sizes' do: [
      #(1 2 3) shouldNot equal: #(1 2).
    ].
  ].
].

]
