"Feature: test doubles"

Namespace current: ShellStone [

Describe the: 'test doubles' do: [:spec |
  spec context: 'creating doubles' do: [:ctx |
    ctx it: 'creates a named double' do: [
      | dbl |
      dbl := Double named: 'database'.
      dbl should respondTo: #name.
      dbl name should equal: 'database'.
    ].

    ctx it: 'creates multiple independent doubles' do: [
      | db1 db2 |
      db1 := Double named: 'db1'.
      db2 := Double named: 'db2'.
      db1 shouldNot equal: db2.
    ].
  ].

  spec context: 'stubbing methods' do: [:ctx |
    ctx it: 'stubs a method with return value' do: [
      | dbl |
      dbl := Double named: 'service'.
      dbl stub: #fetch andReturn: 'data'.
      (dbl fetch) should equal: 'data'.
    ].

    ctx it: 'stubs method with argument' do: [
      | dbl |
      dbl := Double named: 'repo'.
      dbl stub: #find: andReturn: 'found'.
      (dbl find: 1) should equal: 'found'.
    ].

    ctx it: 'stubs multiple methods' do: [
      | dbl |
      dbl := Double named: 'api'.
      dbl stub: #get andReturn: 'get result'.
      dbl stub: #post: andReturn: 'post result'.
      dbl stub: #delete: andReturn: 'delete result'.

      (dbl get) should equal: 'get result'.
      (dbl post: 'data') should equal: 'post result'.
      (dbl delete: 1) should equal: 'delete result'.
    ].

    ctx it: 'stubs method returning collection' do: [
      | dbl users |
      users := #('Alice' 'Bob' 'Charlie').
      dbl := Double named: 'userRepo'.
      dbl stub: #allUsers andReturn: users.

      (dbl allUsers) should equal: users.
      (dbl allUsers) size should equal: 3.
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

      (repo findById: 1) should equal: user.
      ((repo findById: 1) at: 'name') should equal: 'Alice'.
      (repo save: user) should equal: true.
    ].

    ctx it: 'mocks an HTTP client' do: [
      | http response |
      response := Dictionary new
        at: 'status' put: 200;
        at: 'body' put: '{"success": true}';
        yourself.

      http := Double named: 'HttpClient'.
      http stub: #get: andReturn: response.

      ((http get: '/api/users') at: 'status') should equal: 200.
    ].

    ctx it: 'mocks a mailer service' do: [
      | mailer |
      mailer := Double named: 'Mailer'.
      mailer stub: #send: andReturn: true.
      mailer stub: #sendBulk: andReturn: 5.

      (mailer send: 'email') should equal: true.
      (mailer sendBulk: #('a@b.com' 'c@d.com')) should equal: 5.
    ].
  ].
].

]
