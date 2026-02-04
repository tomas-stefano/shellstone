"Specs for equal matcher using ShellStone DSL"
Class {
	#name : #SSEqualMatcherSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSEqualMatcherSpec class >> loadSpecs [
	"Define specs using ShellStone DSL"
	SSWorld reset.

	SSDescribe the: 'equal matcher' do: [ :spec |
		spec context: 'with identical values' do: [ :ctx |
			ctx it: 'passes for equal integers' do: [
				| target |
				target := SSExpectationTarget for: 1.
				target to equal: 1
			].

			ctx it: 'passes for equal strings' do: [
				| target |
				target := SSExpectationTarget for: 'hello'.
				target to equal: 'hello'
			].

			ctx it: 'passes for equal arrays' do: [
				| target |
				target := SSExpectationTarget for: #(1 2 3).
				target to equal: #(1 2 3)
			]
		].

		spec context: 'with different values' do: [ :ctx |
			ctx it: 'fails with toNot for equal values' do: [
				| target |
				target := SSExpectationTarget for: 1.
				target toNot equal: 2
			].

			ctx it: 'fails with toNot for different strings' do: [
				| target |
				target := SSExpectationTarget for: 'hello'.
				target toNot equal: 'world'
			]
		]
	].

	self collectExamples
]
