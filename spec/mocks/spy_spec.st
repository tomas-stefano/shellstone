"Specs for spies"

ShellStone.Describe the: 'Spy' do: [:spec |

    spec it: 'forwards messages to target' do: [
        | spy |
        spy := ShellStone.Spy on: 'hello'.
        spy asUppercase should equal: 'HELLO'.
    ].

    spec it: 'records received messages' do: [
        | spy |
        spy := ShellStone.Spy on: 'hello'.
        spy asUppercase.
        spy asLowercase.
        (spy received: #asUppercase) should beTrue.
        (spy received: #asLowercase) should beTrue.
    ].

    spec it: 'tracks call count' do: [
        | arr spy |
        arr := OrderedCollection new.
        spy := ShellStone.Spy on: arr.
        spy add: 1.
        spy add: 2.
        (spy received: #add: times: 2) should beTrue.
    ].
].
