"Feature: spies"

Namespace current: ShellStone [

Describe the: 'spies' do: [:spec |
  spec context: 'creating spies' do: [:ctx |
    ctx it: 'wraps a real object' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      (self expect: spy target) to equal: list.
    ].
  ].

  spec context: 'delegating to real object' do: [:ctx |
    ctx it: 'forwards method calls to collection' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy add: 1.
      spy add: 2.

      (self expect: list size) to equal: 2.
      (self expect: list first) to equal: 1.
    ].
  ].

  spec context: 'recording calls' do: [:ctx |
    ctx it: 'records that method was called' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy add: 'item'.

      (self expect: (spy received: #add:)) to equal: true.
    ].

    ctx it: 'records that method was not called' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      (self expect: (spy received: #remove:)) to equal: false.
    ].

    ctx it: 'records multiple different calls' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy add: 1.
      spy add: 2.

      (self expect: (spy received: #add:)) to equal: true.
    ].
  ].

  spec context: 'verifying call counts' do: [:ctx |
    ctx it: 'verifies exact call count' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy add: 1.
      spy add: 2.
      spy add: 3.

      (self expect: (spy received: #add: times: 3)) to equal: true.
      (self expect: (spy received: #add: times: 2)) to equal: false.
    ].
  ].

  spec context: 'verifying arguments' do: [:ctx |
    ctx it: 'tracks all argument combinations' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy add: 'first'.
      spy add: 'second'.

      (self expect: (spy received: #add: withArgs: #('first'))) to equal: true.
      (self expect: (spy received: #add: withArgs: #('second'))) to equal: true.
      (self expect: (spy received: #add: withArgs: #('third'))) to equal: false.
    ].
  ].

  spec context: 'getting call information' do: [:ctx |
    ctx it: 'gets all calls to a method' do: [
      | list spy calls |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy add: 'a'.
      spy add: 'b'.

      calls := spy callsTo: #add:.

      (self expect: calls size) to equal: 2.
    ].
  ].

  spec context: 'resetting' do: [:ctx |
    ctx it: 'clears recorded messages' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy add: 1.
      (self expect: (spy received: #add:)) to equal: true.

      spy reset.

      (self expect: (spy received: #add:)) to equal: false.
    ].
  ].

  spec context: 'realistic examples' do: [:ctx |
    ctx it: 'spies on a queue' do: [
      | queue spy |
      queue := OrderedCollection new.
      spy := Spy on: queue.

      spy addLast: 'job1'.
      spy addLast: 'job2'.
      spy removeFirst.

      (self expect: (spy received: #addLast:)) to equal: true.
      (self expect: (spy received: #addLast: times: 2)) to equal: true.
      (self expect: (spy received: #removeFirst)) to equal: true.
    ].
  ].
].

]
