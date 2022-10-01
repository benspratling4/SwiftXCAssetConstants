# SwiftXCAssetConstants
 Get UIColor and UIImage Constants for your xcassets

Creates static constants for UIColor and UIImage from asset names defined in your .xcassets files.

Add the SwiftXCAssetConstants package plug in build tool to your iOS and tvOS swift package, see the "ExampleProject" target for an example of how.


```swift
	.target(name:"ExampleProject" ...
			plugins: [
		"SwiftXCAssetConstants",
	], ...
```


Then access your colors and images anywhere you need a UIColor or UIImage argument, like:

```swift
UIImageView(image:.exampleColor)
```

