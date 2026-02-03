"Feature: include matcher"

Namespace current: ShellStone [

Describe the: 'include matcher' do: [:spec |
  spec context: 'with arrays' do: [:ctx |
    ctx it: 'passes when array includes element' do: [
      (self expect: #(1 2 3)) to include: 2.
    ].

    ctx it: 'passes when array includes first element' do: [
      (self expect: #(1 2 3)) to include: 1.
    ].

    ctx it: 'passes when array includes last element' do: [
      (self expect: #(1 2 3)) to include: 3.
    ].

    ctx it: 'fails when array does not include element' do: [
      (self expect: #(1 2 3)) toNot include: 4.
    ].

    ctx it: 'works with string elements' do: [
      (self expect: #('a' 'b' 'c')) to include: 'b'.
    ].

    ctx it: 'works with symbol elements' do: [
      (self expect: #(#foo #bar #baz)) to include: #bar.
    ].
  ].

  spec context: 'with ordered collections' do: [:ctx |
    ctx it: 'passes when collection includes element' do: [
      | coll |
      coll := OrderedCollection with: 1 with: 2 with: 3.
      (self expect: coll) to include: 2.
    ].

    ctx it: 'fails when collection does not include element' do: [
      | coll |
      coll := OrderedCollection with: 1 with: 2 with: 3.
      (self expect: coll) toNot include: 5.
    ].
  ].

  spec context: 'with strings' do: [:ctx |
    ctx it: 'passes when string includes substring' do: [
      (self expect: 'hello world') to include: 'world'.
    ].

    ctx it: 'passes when string includes prefix' do: [
      (self expect: 'hello world') to include: 'hello'.
    ].

    ctx it: 'passes when string includes single character' do: [
      (self expect: 'hello') to include: 'e'.
    ].

    ctx it: 'fails when string does not include substring' do: [
      (self expect: 'hello world') toNot include: 'foo'.
    ].

    ctx it: 'is case sensitive' do: [
      (self expect: 'Hello') toNot include: 'hello'.
    ].
  ].
].

]
