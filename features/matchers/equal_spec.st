"Feature: equal matcher"

Namespace current: ShellStone [

Describe the: 'equal matcher' do: [:spec |
  spec context: 'with identical values' do: [:ctx |
    ctx it: 'passes for equal integers' do: [
      (self expect: 1) to equal: 1.
    ].

    ctx it: 'passes for equal strings' do: [
      (self expect: 'hello') to equal: 'hello'.
    ].

    ctx it: 'passes for equal symbols' do: [
      (self expect: #foo) to equal: #foo.
    ].

    ctx it: 'passes for equal arrays' do: [
      (self expect: #(1 2 3)) to equal: #(1 2 3).
    ].

    ctx it: 'passes for equal booleans' do: [
      (self expect: true) to equal: true.
      (self expect: false) to equal: false.
    ].

    ctx it: 'passes for nil' do: [
      (self expect: nil) to equal: nil.
    ].
  ].

  spec context: 'with different values' do: [:ctx |
    ctx it: 'passes for unequal integers with toNot' do: [
      (self expect: 1) toNot equal: 2.
    ].

    ctx it: 'passes for unequal strings with toNot' do: [
      (self expect: 'hello') toNot equal: 'world'.
    ].

    ctx it: 'passes for different types with toNot' do: [
      (self expect: 1) toNot equal: '1'.
      (self expect: 'true') toNot equal: true.
    ].
  ].

  spec context: 'with collections' do: [:ctx |
    ctx it: 'compares ordered collections' do: [
      | a b |
      a := OrderedCollection with: 1 with: 2.
      b := OrderedCollection with: 1 with: 2.
      (self expect: a) to equal: b.
    ].

    ctx it: 'compares dictionaries' do: [
      | a b |
      a := Dictionary new at: 'key' put: 'value'; yourself.
      b := Dictionary new at: 'key' put: 'value'; yourself.
      (self expect: a) to equal: b.
    ].

    ctx it: 'detects different collection contents' do: [
      (self expect: #(1 2 3)) toNot equal: #(1 2 4).
    ].

    ctx it: 'detects different collection sizes' do: [
      (self expect: #(1 2 3)) toNot equal: #(1 2).
    ].
  ].
].

]
