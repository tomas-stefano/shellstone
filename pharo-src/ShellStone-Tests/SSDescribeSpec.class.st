"Specs for the Describe DSL entry point"
Class {
	#name : #SSDescribeSpec,
	#superclass : #SSSpecRunner,
	#category : #'ShellStone-Tests'
}

{ #category : #specs }
SSDescribeSpec class >> loadSpecs [
	SSWorld reset.

	SS describe: 'Describe DSL' do: [ :spec |
		spec it: 'creates an example group' do: [
			(SS expect: SSWorld instance groups) toNot beNil
		].

		spec it: 'allows string descriptions' do: [
			(SS expect: true) to beTrue
		].

		spec context: 'nested contexts' do: [ :ctx |
			ctx it: 'supports nested describe blocks' do: [
				(SS expect: true) to beTrue
			].

			ctx context: 'deeply nested' do: [ :inner |
				inner it: 'can nest multiple levels' do: [
					(SS expect: true) to beTrue
				]
			]
		]
	].

	self collectExamples
]
