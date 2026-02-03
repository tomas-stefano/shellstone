"Specs for the Include matcher"

ShellStone.Describe the: 'IncludeMatcher' do: [:spec |

    spec context: 'expect syntax' do: [:ctx |
        ctx context: 'with arrays' do: [:inner |
            inner it: 'passes when array includes item' do: [
                (self expect: #(1 2 3)) to include: 2.
            ].

            inner it: 'fails when array does not include item' do: [
                (self expect: #(1 2 3)) toNot include: 5.
            ].
        ].

        ctx context: 'with strings' do: [:inner |
            inner it: 'passes when string includes substring' do: [
                (self expect: 'hello world') to include: 'world'.
            ].

            inner it: 'fails when string does not include substring' do: [
                (self expect: 'hello world') toNot include: 'foo'.
            ].
        ].

        ctx context: 'with sets' do: [:inner |
            inner it: 'passes when set includes item' do: [
                (self expect: (Set with: 1 with: 2 with: 3)) to include: 2.
            ].
        ].
    ].

    spec context: 'should syntax' do: [:ctx |
        ctx context: 'with arrays' do: [:inner |
            inner it: 'passes when array includes item' do: [
                #(1 2 3) should include: 2.
            ].

            inner it: 'fails when array does not include item' do: [
                #(1 2 3) shouldNot include: 5.
            ].
        ].

        ctx context: 'with strings' do: [:inner |
            inner it: 'passes when string includes substring' do: [
                'hello world' should include: 'world'.
            ].

            inner it: 'fails when string does not include substring' do: [
                'hello world' shouldNot include: 'foo'.
            ].
        ].

        ctx context: 'with sets' do: [:inner |
            inner it: 'passes when set includes item' do: [
                (Set with: 1 with: 2 with: 3) should include: 2.
            ].
        ].
    ].
].
