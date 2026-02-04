"Specs for pending examples"

ShellStone.Describe the: 'Pending' do: [:spec |

    spec it: 'this is a pending example'.  "No block = pending"

    spec it: 'can use pending in block' do: [
        pending.
    ].

    spec it: 'can use pending with message' do: [
        self pending: 'Not implemented yet'.
    ].
].
