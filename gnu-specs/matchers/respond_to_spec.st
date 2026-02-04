"Specs for the RespondTo matcher"

ShellStone.Describe the: 'RespondToMatcher' do: [:spec |

    spec context: 'expect syntax' do: [:ctx |
        ctx it: 'passes when object responds to selector' do: [
            (self expect: 'hello') to respondTo: #size.
        ].

        ctx it: 'fails when object does not respond to selector' do: [
            (self expect: 'hello') toNot respondTo: #nonExistentMethod.
        ].

        ctx it: 'works with symbols' do: [
            (self expect: #hello) to respondTo: #asString.
        ].
    ].

    spec context: 'should syntax' do: [:ctx |
        ctx it: 'passes when object responds to selector' do: [
            'hello' should respondTo: #size.
        ].

        ctx it: 'fails when object does not respond to selector' do: [
            'hello' shouldNot respondTo: #nonExistentMethod.
        ].

        ctx it: 'works with symbols' do: [
            #hello should respondTo: #asString.
        ].
    ].
].
