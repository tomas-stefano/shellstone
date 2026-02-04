"Specs for raiseError matcher using ShellStone DSL"
Class {
	#name : #ShRaiseErrorMatcherSpec,
	#superclass : #ShSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
ShRaiseErrorMatcherSpec class >> loadSpecs [
	ShWorld reset.

	Sh describe: 'raiseError matcher' do: [ :spec |
		spec context: 'with any error' do: [ :ctx |
			ctx it: 'passes when block raises error' do: [
				(Sh expect: [ self error: 'boom' ]) to raiseError
			].

			ctx it: 'fails when block does not raise' do: [
				(Sh expect: [ 1 + 1 ]) toNot raiseError
			]
		].

		spec context: 'with specific error class' do: [ :ctx |
			ctx it: 'passes for matching error class' do: [
				(Sh expect: [ 1 / 0 ]) to raiseError: ZeroDivide
			].

			ctx it: 'fails for non-matching error class' do: [
				(Sh expect: [ self error: 'boom' ]) toNot raiseError: ZeroDivide
			]
		]
	].

	self collectExamples
]
