"Feature: test doubles"

Namespace current: ShellStone [

Describe the: 'test doubles' do: [:spec |
  spec context: 'creating doubles' do: [:ctx |
    ctx it: 'creates a named double' do: [
      | dbl |
      dbl := Double named: 'database'.
      (self expect: dbl) to respondTo: #name.
      (self expect: dbl name) to equal: 'database'.
    ].

    ctx it: 'creates multiple independent doubles' do: [
      | db1 db2 |
      db1 := Double named: 'db1'.
      db2 := Double named: 'db2'.
      (self expect: db1) toNot equal: db2.
    ].
  ].

  spec context: 'stubbing methods' do: [:ctx |
    ctx it: 'stubs a method with return value' do: [
      | dbl |
      dbl := Double named: 'service'.
      dbl stub: #fetch andReturn: 'data'.
      (self expect: dbl fetch) to equal: 'data'.
    ].

    ctx it: 'stubs method with argument' do: [
      | dbl |
      dbl := Double named: 'repo'.
      dbl stub: #find: andReturn: 'found'.
      (self expect: (dbl find: 1)) to equal: 'found'.
    ].

    ctx it: 'stubs multiple methods' do: [
      | dbl |
      dbl := Double named: 'api'.
      dbl stub: #get andReturn: 'get result'.
      dbl stub: #post: andReturn: 'post result'.
      dbl stub: #delete: andReturn: 'delete result'.

      (self expect: dbl get) to equal: 'get result'.
      (self expect: (dbl post: 'data')) to equal: 'post result'.
      (self expect: (dbl delete: 1)) to equal: 'delete result'.
    ].

    ctx it: 'stubs method returning collection' do: [
      | dbl users |
      users := #('Alice' 'Bob' 'Charlie').
      dbl := Double named: 'userRepo'.
      dbl stub: #allUsers andReturn: users.

      (self expect: dbl allUsers) to equal: users.
      (self expect: dbl allUsers size) to equal: 3.
    ].
  ].

  spec context: 'realistic examples' do: [:ctx |
    ctx it: 'mocks a database repository' do: [
      | repo user |
      user := Dictionary new
        at: 'id' put: 1;
        at: 'name' put: 'Alice';
        at: 'email' put: 'alice@example.com';
        yourself.

      repo := Double named: 'UserRepository'.
      repo stub: #findById: andReturn: user.
      repo stub: #save: andReturn: true.

      (self expect: (repo findById: 1)) to equal: user.
      (self expect: ((repo findById: 1) at: 'name')) to equal: 'Alice'.
      (self expect: (repo save: user)) to equal: true.
    ].

    ctx it: 'mocks an HTTP client' do: [
      | http response |
      response := Dictionary new
        at: 'status' put: 200;
        at: 'body' put: '{"success": true}';
        yourself.

      http := Double named: 'HttpClient'.
      http stub: #get: andReturn: response.

      (self expect: ((http get: '/api/users') at: 'status')) to equal: 200.
    ].

    ctx it: 'mocks a mailer service' do: [
      | mailer |
      mailer := Double named: 'Mailer'.
      mailer stub: #send: andReturn: true.
      mailer stub: #sendBulk: andReturn: 5.

      (self expect: (mailer send: 'email')) to equal: true.
      (self expect: (mailer sendBulk: #('a@b.com' 'c@d.com'))) to equal: 5.
    ].
  ].
].

]
