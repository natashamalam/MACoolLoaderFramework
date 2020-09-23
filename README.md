# MACoolLoaderFramework

MACoolLoaderFramework is a light-weight, easy to use library providing 6 kinds of custom loading indicator. 

# Requirements
 - *iOS 10.0*
 - *Swift 5.0*

# Installation
#### Through CocoaPods

Make sure CocoaPods is install in your machine. If not, open the terminal and type ```sudo gem install cocoapods```.

Walk Through- 
 - Open the Terminal
 - Navigate to the app's project directory by typing ``cd [application directory]``
 - Create a pod file with ``pod init``
 - Open the pod file. To open in Xcode, type ``open Podfile -a Xcode``.
 - In the Podfile, add following lines-
 
 ``` 
     target 'SampleApp' do
        pod 'MACoolLoaderFramework', '~> 1.0'
     end
 ```
 - save and close it.
 - Now type - ```pod install``
 - Sometimes, to get the latest release, you have to do ```pod update```
 
 
# Loader Categories
```
  - MASolidBeapingLoader
  - MAVanishingLoader
  - MATranslucentLoader
  - MAMultiLayeredLoader
  - MAWavingBlobLoader
  - MARadiatingBlobLoader
```

The initializer takes the view on which the loader will be presented and the size of the loader. Size is defined with a set of enum choices (.small, .medium, .large)

#### MASolidBeapingLoader

The loader background and border both colors can be changed.

![1](https://user-images.githubusercontent.com/8694816/93937066-1938da00-fd62-11ea-925d-ac17b3aef41d.gif)


##### properties:
```
var loaderLineWidth: CGFloat
var loaderBorderColor: UIColor
var loaderBackgroundColor : UIColor
```

##### Sample Code
```
   class SampleViewController: UIViewController {

    @IBOutlet weak var placeHolderImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loader = MASolidBeapingLoader(onView: placeHolderImageView, withSize: .medium)
        loader.show()
    }
   }
   ```
   
#### MAVanishingLoader
MAVanishingLoader is a single circular loader zooming out.

##### A Sample Demo 
![2](https://user-images.githubusercontent.com/8694816/93937133-35d51200-fd62-11ea-8135-5fe5c6b152ab.gif)

##### Customizable Properties
```
var loaderColor: UIColor
```

#### MATranslucentLoader

![3](https://user-images.githubusercontent.com/8694816/93937460-ce6b9200-fd62-11ea-8f5c-3ce80ce55c32.gif)

##### Customizable Properties
```
var loaderColor:UIColor
```

#### MAMultiLayeredLoader
MAMultiLayeredLoader is consist of three layered each of whose color can be changed. 

##### Sample Demo 
![4](https://user-images.githubusercontent.com/8694816/93938003-94e75680-fd63-11ea-90a3-2a361d2963b3.gif)


##### Customizable Properties:

```
 var outerLayerColor: UIColor
 var movingLayerColor: UIColor
 var innerLayerColor: UIColor
 ```


#### MAWavingBlobLoader
MAWavingBlobLoader is almost analogous to face messenger chat in progress loader. However, the blob's color can be changed according to background or superview's color scheme.

##### Customizable Properties:

```
var blobColor : UIColor
 ```
 
![5](https://user-images.githubusercontent.com/8694816/93938305-07583680-fd64-11ea-8893-5961dec4054f.gif)


#### MARadiatingBlobLoader:

Loader with three dotted blobs radiating in-out.

![6](https://user-images.githubusercontent.com/8694816/93938921-fa881280-fd64-11ea-9e5c-598a88a3fde9.gif)

##### Customizable Properties:

```
var blobColor : UIColor
var blobBorderColor : UIColor
 ```

#### Presenting and dismissing:
to present the loader simply call the instance method ```show()``` and to dismiss, add the ```hide()``` method.

##### Sample Code:
Present:
```
loader.show()
```
Dismiss:
```
loader.hide()
```

## License
Distributed under the MIT license. See LICENSE for more information.
