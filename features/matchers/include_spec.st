"Feature: include matcher"

Namespace current: ShellStone [

Describe the: 'include matcher' do: [:spec |
  spec context: 'with arrays' do: [:ctx |
    ctx it: 'passes when array includes element' do: [
      #(1 2 3) should include: 2.
    ].

    ctx it: 'passes when array includes first element' do: [
      #(1 2 3) should include: 1.
    ].

    ctx it: 'passes when array includes last element' do: [
      #(1 2 3) should include: 3.
    ].

    ctx it: 'fails when array does not include element' do: [
      #(1 2 3) shouldNot include: 4.
    ].

    ctx it: 'works with string elements' do: [
      #('a' 'b' 'c') should include: 'b'.
    ].

    ctx it: 'works with symbol elements' do: [
      #(#foo #bar #baz) should include: #bar.
    ].
  ].

  spec context: 'with ordered collections' do: [:ctx |
    ctx it: 'passes when collection includes element' do: [
      | coll |
      coll := OrderedCollection with: 1 with: 2 with: 3.
      coll should include: 2.
    ].

    ctx it: 'fails when collection does not include element' do: [
      | coll |
      coll := OrderedCollection with: 1 with: 2 with: 3.
      coll shouldNot include: 5.
    ].
  ].

  spec context: 'with strings' do: [:ctx |
    ctx it: 'passes when string includes substring' do: [
      'hello world' should include: 'world'.
    ].

    ctx it: 'passes when string includes prefix' do: [
      'hello world' should include: 'hello'.
    ].

    ctx it: 'passes when string includes single character' do: [
      'hello' should include: 'e'.
    ].

    ctx it: 'fails when string does not include substring' do: [
      'hello world' shouldNot include: 'foo'.
    ].

    ctx it: 'is case sensitive' do: [
      'Hello' shouldNot include: 'hello'.
    ].
  ].
].

]
