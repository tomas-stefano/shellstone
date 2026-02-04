"Specs for spies"

ShellStone.Describe the: 'Spy' do: [:spec |

    spec context: 'expect syntax' do: [:ctx |
        ctx it: 'forwards messages to target' do: [
            | spy |
            spy := ShellStone.Spy on: 'hello'.
            (self expect: spy asUppercase) to equal: 'HELLO'.
        ].

        ctx it: 'records received messages' do: [
            | spy |
            spy := ShellStone.Spy on: 'hello'.
            spy asUppercase.
            spy asLowercase.
            (self expect: (spy received: #asUppercase)) to beTrue.
            (self expect: (spy received: #asLowercase)) to beTrue.
        ].

        ctx it: 'tracks call count' do: [
            | arr spy |
            arr := OrderedCollection new.
            spy := ShellStone.Spy on: arr.
            spy add: 1.
            spy add: 2.
            (self expect: (spy received: #add: times: 2)) to beTrue.
        ].
    ].

    spec context: 'should syntax' do: [:ctx |
        ctx it: 'forwards messages to target' do: [
            | spy |
            spy := ShellStone.Spy on: 'hello'.
            spy asUppercase should equal: 'HELLO'.
        ].

        ctx it: 'records received messages' do: [
            | spy |
            spy := ShellStone.Spy on: 'hello'.
            spy asUppercase.
            spy asLowercase.
            (spy received: #asUppercase) should beTrue.
            (spy received: #asLowercase) should beTrue.
        ].

        ctx it: 'tracks call count' do: [
            | arr spy |
            arr := OrderedCollection new.
            spy := ShellStone.Spy on: arr.
            spy add: 1.
            spy add: 2.
            (spy received: #add: times: 2) should beTrue.
        ].
    ].
].
