"Specs for match matcher using ShellStone DSL"
Class {
	#name : #SSMatchMatcherSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSMatchMatcherSpec class >> loadSpecs [
	SSWorld reset.

	SS describe: 'match matcher' do: [ :spec |
		spec it: 'passes when string contains pattern' do: [
			(SS expect: 'hello world') to match: 'world'
		].

		spec it: 'passes for partial match' do: [
			(SS expect: 'user@example.com') to match: '@example'
		].

		spec it: 'fails when pattern not found' do: [
			(SS expect: 'hello world') toNot match: 'foo'
		].

		spec it: 'is case sensitive' do: [
			(SS expect: 'Hello World') toNot match: 'hello'
		]
	].

	self collectExamples
]
