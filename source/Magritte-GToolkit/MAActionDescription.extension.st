Extension { #name : #MAActionDescription }

{ #category : #'*Magritte-GToolkit' }
MAActionDescription >> gtAction: aValuable [
	"aValuable - optional arguments:
		- aGtPhlowNoAction (same as the argument to a standard GT action method)
		- this description
		- NB. the receiver is *not* passed as an argument, because it should be available in the description creation method"

	^ self propertyAt: #gtAction put: aValuable
]

{ #category : #'*Magritte-GToolkit' }
MAActionDescription >> gtActionOf: anObject [

	(self enableBlock cull: anObject) ifFalse: [ ^ GtPhlowAction noAction ].
	
	^ self
		propertyAt: #gtAction
		ifPresent: [ :valuable | 
			valuable cull: GtPhlowAction noAction cull: self ]
		ifAbsent: [ 
			| button icn |
			button := GtPhlowAction noAction button.
			self comment ifNotEmpty: [ :tt | button tooltip: tt ].
			icn := self gtIcon ifNil: [ self icon ].
			icn ifNotNil: [ :i | button icon: i ].
			self isLabelVisible ifTrue: [ button label: self label ].
			button
				action: [ self performOn: anObject ];
				yourself ].
]

{ #category : #'*Magritte-GToolkit' }
MAActionDescription >> gtIcon [
	^ self propertyAt: #gtIcon ifPresent: [ :i | i value ].
	"Implementation note: see setter"
]

{ #category : #'*Magritte-GToolkit' }
MAActionDescription >> gtIcon: formValuable [
	self propertyAt: #gtIcon put: formValuable.
	"Implementation note: Store as a valuable so that potentially expensive form creation can be deferred until use. Use property instead of inst var because:
		- we can scope this to GToolkit as an extension method
		- It seems to fit with the 'instVar=mandatory, prop=optional' guideline"
]
