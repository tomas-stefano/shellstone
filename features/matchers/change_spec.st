"Feature: change matcher"

Namespace current: ShellStone [

Describe the: 'change matcher' do: [:spec |
  spec context: 'basic change detection' do: [:ctx |
    ctx it: 'passes when value changes' do: [
      | counter |
      counter := 0.
      (self expect: [counter := counter + 1]) to change: [counter].
    ].

    ctx it: 'detects string changes' do: [
      | str |
      str := 'hello'.
      (self expect: [str := str, ' world']) to change: [str].
    ].

    ctx it: 'detects collection changes' do: [
      | coll |
      coll := OrderedCollection new.
      (self expect: [coll add: 1]) to change: [coll size].
    ].
  ].
].

]
