"Feature: beA/beKindOf matcher (type checking)"

Namespace current: ShellStone [

Describe the: 'beKindOf matcher' do: [:spec |
  spec context: 'exact class matching' do: [:ctx |
    ctx it: 'passes for String' do: [
      (self expect: 'hello') to beA: String.
    ].

    ctx it: 'passes for Integer' do: [
      (self expect: 42) to beA: Integer.
    ].

    ctx it: 'passes for Array' do: [
      (self expect: #(1 2 3)) to beA: Array.
    ].

    ctx it: 'passes for OrderedCollection' do: [
      (self expect: OrderedCollection new) to beA: OrderedCollection.
    ].

    ctx it: 'passes for Dictionary' do: [
      (self expect: Dictionary new) to beA: Dictionary.
    ].
  ].

  spec context: 'superclass matching' do: [:ctx |
    ctx it: 'passes for Object superclass' do: [
      (self expect: 'hello') to beKindOf: Object.
      (self expect: 42) to beKindOf: Object.
      (self expect: #(1 2 3)) to beKindOf: Object.
    ].

    ctx it: 'passes for Collection superclass' do: [
      (self expect: #(1 2 3)) to beKindOf: Collection.
      (self expect: OrderedCollection new) to beKindOf: Collection.
      (self expect: Dictionary new) to beKindOf: Collection.
    ].

    ctx it: 'passes for Number superclass' do: [
      (self expect: 42) to beKindOf: Number.
      (self expect: 3.14) to beKindOf: Number.
    ].
  ].

  spec context: 'negative matching' do: [:ctx |
    ctx it: 'fails for wrong type with toNot' do: [
      (self expect: 'hello') toNot beA: Integer.
      (self expect: 42) toNot beA: String.
    ].

    ctx it: 'fails for unrelated classes with toNot' do: [
      (self expect: #(1 2 3)) toNot beA: Dictionary.
      (self expect: Dictionary new) toNot beA: Array.
    ].
  ].
].

]
