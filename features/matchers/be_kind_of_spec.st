"Feature: beA/beKindOf matcher (type checking)"

Namespace current: ShellStone [

Describe the: 'beKindOf matcher' do: [:spec |
  spec context: 'exact class matching' do: [:ctx |
    ctx it: 'passes for String' do: [
      'hello' should beA: String.
    ].

    ctx it: 'passes for Integer' do: [
      42 should beA: Integer.
    ].

    ctx it: 'passes for Array' do: [
      #(1 2 3) should beA: Array.
    ].

    ctx it: 'passes for OrderedCollection' do: [
      OrderedCollection new should beA: OrderedCollection.
    ].

    ctx it: 'passes for Dictionary' do: [
      Dictionary new should beA: Dictionary.
    ].
  ].

  spec context: 'superclass matching' do: [:ctx |
    ctx it: 'passes for Object superclass' do: [
      'hello' should beKindOf: Object.
      42 should beKindOf: Object.
      #(1 2 3) should beKindOf: Object.
    ].

    ctx it: 'passes for Collection superclass' do: [
      #(1 2 3) should beKindOf: Collection.
      OrderedCollection new should beKindOf: Collection.
      Dictionary new should beKindOf: Collection.
    ].

    ctx it: 'passes for Number superclass' do: [
      42 should beKindOf: Number.
      3.14 should beKindOf: Number.
    ].
  ].

  spec context: 'negative matching' do: [:ctx |
    ctx it: 'fails for wrong type with shouldNot' do: [
      'hello' shouldNot beA: Integer.
      42 shouldNot beA: String.
    ].

    ctx it: 'fails for unrelated classes with shouldNot' do: [
      #(1 2 3) shouldNot beA: Dictionary.
      Dictionary new shouldNot beA: Array.
    ].
  ].
].

]
