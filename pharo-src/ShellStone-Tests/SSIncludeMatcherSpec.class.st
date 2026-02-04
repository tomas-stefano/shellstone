"Specs for include matcher using ShellStone DSL"
Class {
	#name : #SSIncludeMatcherSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSIncludeMatcherSpec class >> loadSpecs [
	SSWorld reset.

	SSDescribe the: 'include matcher' do: [ :spec |
		spec context: 'with arrays' do: [ :ctx |
			ctx it: 'passes when array includes item' do: [
				(SSExpectationTarget for: #(1 2 3)) to include: 2
			].

			ctx it: 'fails when array does not include item' do: [
				(SSExpectationTarget for: #(1 2 3)) toNot include: 5
			]
		].

		spec context: 'with strings' do: [ :ctx |
			ctx it: 'passes when string includes substring' do: [
				(SSExpectationTarget for: 'hello world') to include: 'world'
			].

			ctx it: 'fails when string does not include substring' do: [
				(SSExpectationTarget for: 'hello world') toNot include: 'foo'
			]
		]
	].

	self collectExamples
]
