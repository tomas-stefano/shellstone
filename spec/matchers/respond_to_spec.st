"Specs for the RespondTo matcher"

ShellStone.Describe the: 'RespondToMatcher' do: [:spec |

    spec it: 'passes when object responds to selector' do: [
        'hello' should respondTo: #size.
    ].

    spec it: 'fails when object does not respond to selector' do: [
        'hello' shouldNot respondTo: #nonExistentMethod.
    ].

    spec it: 'works with symbols' do: [
        #hello should respondTo: #asString.
    ].
].
