"Specs for beKindOf matcher using ShellStone DSL"
Class {
	#name : #SSBeKindOfMatcherSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSBeKindOfMatcherSpec class >> loadSpecs [
	SSWorld reset.

	SS describe: 'beKindOf matcher' do: [ :spec |
		spec context: 'beA' do: [ :ctx |
			ctx it: 'passes for exact class match' do: [
				(SS expect: 'hello') to beA: String
			].

			ctx it: 'passes for superclass match' do: [
				(SS expect: 42) to beA: Number
			].

			ctx it: 'fails for wrong class' do: [
				(SS expect: 'hello') toNot beA: Number
			]
		].

		spec context: 'beAn' do: [ :ctx |
			ctx it: 'works as alias for beA' do: [
				(SS expect: #(1 2 3)) to beAn: Array
			]
		].

		spec context: 'beKindOf' do: [ :ctx |
			ctx it: 'passes for kind of class' do: [
				(SS expect: 3.14) to beKindOf: Number
			].

			ctx it: 'passes for collection subclass' do: [
				(SS expect: OrderedCollection new) to beKindOf: Collection
			]
		]
	].

	self collectExamples
]
