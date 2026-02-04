"Feature: respondTo matcher"

Namespace current: ShellStone [

Describe the: 'respondTo matcher' do: [:spec |
  spec context: 'with common objects' do: [:ctx |
    ctx it: 'passes for String methods' do: [
      (self expect: 'hello') to respondTo: #size.
      (self expect: 'hello') to respondTo: #asUppercase.
      (self expect: 'hello') to respondTo: #asLowercase.
    ].

    ctx it: 'passes for Collection methods' do: [
      (self expect: #(1 2 3)) to respondTo: #size.
      (self expect: #(1 2 3)) to respondTo: #first.
      (self expect: #(1 2 3)) to respondTo: #last.
      (self expect: #(1 2 3)) to respondTo: #do:.
    ].

    ctx it: 'passes for Number methods' do: [
      (self expect: 42) to respondTo: #negated.
      (self expect: 42) to respondTo: #abs.
      (self expect: 42) to respondTo: #+.
    ].

    ctx it: 'passes for Object methods' do: [
      (self expect: Object new) to respondTo: #class.
      (self expect: Object new) to respondTo: #printString.
      (self expect: Object new) to respondTo: #yourself.
    ].
  ].

  spec context: 'with keyword methods' do: [:ctx |
    ctx it: 'passes for single keyword methods' do: [
      (self expect: OrderedCollection new) to respondTo: #add:.
      (self expect: Dictionary new) to respondTo: #at:.
    ].

    ctx it: 'passes for multi-keyword methods' do: [
      (self expect: Dictionary new) to respondTo: #at:put:.
      (self expect: 'hello') to respondTo: #copyFrom:to:.
    ].
  ].

  spec context: 'negative matching' do: [:ctx |
    ctx it: 'fails for non-existent methods' do: [
      (self expect: 'hello') toNot respondTo: #nonExistentMethod.
      (self expect: 42) toNot respondTo: #fooBar:.
    ].

    ctx it: 'fails for methods from unrelated classes' do: [
      (self expect: 42) toNot respondTo: #asUppercase.
      (self expect: 'hello') toNot respondTo: #negated.
    ].
  ].
].

]
