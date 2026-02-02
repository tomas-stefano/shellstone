"Feature: respondTo matcher"

Namespace current: ShellStone [

Describe the: 'respondTo matcher' do: [:spec |
  spec context: 'with common objects' do: [:ctx |
    ctx it: 'passes for String methods' do: [
      'hello' should respondTo: #size.
      'hello' should respondTo: #asUppercase.
      'hello' should respondTo: #asLowercase.
    ].

    ctx it: 'passes for Collection methods' do: [
      #(1 2 3) should respondTo: #size.
      #(1 2 3) should respondTo: #first.
      #(1 2 3) should respondTo: #last.
      #(1 2 3) should respondTo: #do:.
    ].

    ctx it: 'passes for Number methods' do: [
      42 should respondTo: #negated.
      42 should respondTo: #abs.
      42 should respondTo: #+.
    ].

    ctx it: 'passes for Object methods' do: [
      Object new should respondTo: #class.
      Object new should respondTo: #printString.
      Object new should respondTo: #yourself.
    ].
  ].

  spec context: 'with keyword methods' do: [:ctx |
    ctx it: 'passes for single keyword methods' do: [
      OrderedCollection new should respondTo: #add:.
      Dictionary new should respondTo: #at:.
    ].

    ctx it: 'passes for multi-keyword methods' do: [
      Dictionary new should respondTo: #at:put:.
      'hello' should respondTo: #copyFrom:to:.
    ].
  ].

  spec context: 'negative matching' do: [:ctx |
    ctx it: 'fails for non-existent methods' do: [
      'hello' shouldNot respondTo: #nonExistentMethod.
      42 shouldNot respondTo: #fooBar:.
    ].

    ctx it: 'fails for methods from unrelated classes' do: [
      42 shouldNot respondTo: #asUppercase.
      'hello' shouldNot respondTo: #negated.
    ].
  ].
].

]
