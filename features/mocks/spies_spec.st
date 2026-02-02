"Feature: spies"

Namespace current: ShellStone [

Describe the: 'spies' do: [:spec |
  spec context: 'creating spies' do: [:ctx |
    ctx it: 'wraps a real object' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy target should equal: list.
    ].
  ].

  spec context: 'delegating to real object' do: [:ctx |
    ctx it: 'forwards method calls to collection' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy add: 1.
      spy add: 2.

      list size should equal: 2.
      list first should equal: 1.
    ].
  ].

  spec context: 'recording calls' do: [:ctx |
    ctx it: 'records that method was called' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy add: 'item'.

      (spy received: #add:) should equal: true.
    ].

    ctx it: 'records that method was not called' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      (spy received: #remove:) should equal: false.
    ].

    ctx it: 'records multiple different calls' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy add: 1.
      spy add: 2.

      (spy received: #add:) should equal: true.
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

      (spy received: #add: times: 3) should equal: true.
      (spy received: #add: times: 2) should equal: false.
    ].
  ].

  spec context: 'verifying arguments' do: [:ctx |
    ctx it: 'tracks all argument combinations' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy add: 'first'.
      spy add: 'second'.

      (spy received: #add: withArgs: #('first')) should equal: true.
      (spy received: #add: withArgs: #('second')) should equal: true.
      (spy received: #add: withArgs: #('third')) should equal: false.
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

      calls size should equal: 2.
    ].
  ].

  spec context: 'resetting' do: [:ctx |
    ctx it: 'clears recorded messages' do: [
      | list spy |
      list := OrderedCollection new.
      spy := Spy on: list.

      spy add: 1.
      (spy received: #add:) should equal: true.

      spy reset.

      (spy received: #add:) should equal: false.
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

      (spy received: #addLast:) should equal: true.
      (spy received: #addLast: times: 2) should equal: true.
      (spy received: #removeFirst) should equal: true.
    ].
  ].
].

]
