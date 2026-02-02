"Specs for test doubles"

ShellStone.Describe the: 'Double' do: [:spec |

    spec context: 'stubbing' do: [:ctx |
        ctx it: 'returns stubbed value' do: [
            | db |
            db := ShellStone.Double named: 'database'.
            db stub: #find: andReturn: 'user'.
            (db find: 1) should equal: 'user'.
        ].

        ctx it: 'can stub multiple methods' do: [
            | api |
            api := ShellStone.Double named: 'api'.
            api stub: #get andReturn: 'data'.
            api stub: #post andReturn: 'created'.
            api get should equal: 'data'.
            api post should equal: 'created'.
        ].
    ].

    spec context: 'recording calls' do: [:ctx |
        ctx it: 'records received messages' do: [
            | obj |
            obj := ShellStone.Double named: 'object'.
            obj stub: #doSomething andReturn: nil.
            obj doSomething.
            (obj received: #doSomething) should beTrue.
        ].

        ctx it: 'tracks call count' do: [
            | counter |
            counter := ShellStone.Double named: 'counter'.
            counter stub: #increment andReturn: nil.
            counter increment.
            counter increment.
            counter increment.
            (counter received: #increment times: 3) should beTrue.
        ].
    ].
].
