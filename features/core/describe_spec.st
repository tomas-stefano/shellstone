"Feature: describe and context blocks"

Namespace current: ShellStone [

Describe the: 'describe blocks' do: [:spec |
  spec context: 'basic structure' do: [:ctx |
    ctx it: 'runs examples inside describe' do: [
      (self expect: true) to equal: true.
    ].

    ctx it: 'can have multiple examples' do: [
      (self expect: 1) to equal: 1.
    ].

    ctx it: 'examples are independent' do: [
      (self expect: 2) to equal: 2.
    ].
  ].

  spec context: 'nested contexts' do: [:ctx |
    ctx context: 'first level' do: [:inner |
      inner it: 'works at first level' do: [
        (self expect: 'first') to equal: 'first'.
      ].

      inner context: 'second level' do: [:deeper |
        deeper it: 'works at second level' do: [
          (self expect: 'second') to equal: 'second'.
        ].

        deeper context: 'third level' do: [:deepest |
          deepest it: 'works at third level' do: [
            (self expect: 'third') to equal: 'third'.
          ].
        ].
      ].
    ].
  ].

  spec context: 'variable isolation' do: [:ctx |
    | sharedVar |

    ctx before: #each do: [
      sharedVar := 0.
    ].

    ctx it: 'starts with initial value' do: [
      (self expect: sharedVar) to equal: 0.
      sharedVar := 10.
    ].

    ctx it: 'resets between examples' do: [
      (self expect: sharedVar) to equal: 0.
    ].
  ].

  spec context: 'with strings as descriptions' do: [:ctx |
    ctx it: 'accepts string descriptions' do: [
      (self expect: 'works') to equal: 'works'.
    ].
  ].
].

Describe the: 'another describe block' do: [:spec |
  spec it: 'can have multiple describe blocks' do: [
    (self expect: true) to equal: true.
  ].
].

]
