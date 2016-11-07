# Deck of Cards

![](http://i.imgur.com/vXV2sLG.jpg?1)

We're going to be working with the [Deck of Cards API](http://deckofcardsapi.com).

There is _no_ client ID or secret needed when making `GET` requests. Take a look through the documentation to see what the responses look like.

Ultimately, we will be building `Deck` and `Card` classes that will represent this data we get back from the Deck of Cards API, but for now I want you to first look through the various requests we can make from their web-site.

The ones we're most concerned with for our app are the following:
*	Shuffle the Cards: `https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1`
* 	Draw a Card: `https://deckofcardsapi.com/api/deck/<<deck_id>>/draw/?count=2`

**FINAL PRODUCT**:

[![Deck of Cards Demo](http://img.youtube.com/vi/_wLx2srsSQM/0.jpg)](https://www.youtube.com/watch?v=StTqXEQ2l-Y "Deck of Cards Demo")

# Instructions

# API

Create a `CardAPIClient.swift` file. Within it, create a `CardAPIClient` struct. This struct should ultimately have three functions:

* `newDeckShuffled`
* `drawCards`
* `downloadImage`

As well, it should have a type property called `shared` which will be our singleton. You can set this up as follows:

```swift
static let shared = CardAPIClient()
```

As to the arguments of these various functions, I will leave that up to you to decide. But `newDeckShuffled` should look to take advantage of one of the URL's posted above. `drawCards` should utilize one of the URL's above as well. `downloadImage`s implementation is something you can skip over (for now). `downloadImage` will ultimately be in charge of downloading an image at specific URL.

I would prefer that you don't use Alamofire when making these requests.

---

# Deck

Create a `Deck.swift` file. In it, make a new class called `Deck`.

The `Deck` class should have properties that relate to this response `Dictionary` we get back from the request we will be making from the API Client.

```swift
{
    "success": true,
    "deck_id": "3p40paa87x90",
    "shuffled": true,
    "remaining": 52
}
```

Think about this for a second. When creating your instance properties for your `Deck`, what should the name of these properties be? What should their types be? Well.. it should match up with this response.

**MAJOR HINT INCOMING**

* `success` should be a stored property of type `Bool`.
* `deckID` should be a stored property of type `String`.
* `shuffled` should be a stored property of type `Bool`.
* `remaining` should be a stored property of type `Int`.

**--End of major hint**

As well, this class should have a stored property called `apiClient` where we assign it a default value. The default value should be the singleton we've created in the `CardAPIClient` struct. 

```swift
let apiClient = CardAPIClient.shared
```

Create a function called `newDeck(_:)`. This function takes in one argument.. which is another function! The parameter should be called `handler` (or `completion`) of type (`Bool`) -> `Void`. In your implementation of this function, you should look to call on the `newDeckShuffled` function available to your `apiClient` property. If you've setup your `newDeckShuffled` function correctly, in its completion handler you should be getting back a `JSON` object of type [`String` : `Any`]. With this `JSON` object, you should look to update all of your stored properties with the various `values` that are part of the dictionary.

**NOTE:** You might notice something. Our stored properties won't have values assigned to them at this point, so how can we possibly call on an instance method if we don't have an `init` function setup? Instead of making an `init` function, the stored properties should be implicitly unwrapped optionals. 

That means, your stored properties should look like this:

```swift
var success: Bool!
var id: String!
var shuffled: Bool!
var remaining: Int!
let apiClient = CardAPIClient.shared
```

After assigning values from the `JSON` object to the various stored properties, call on the `handler` argument and pass it the `true` value signifying that our deck is fully setup.


---

# Card

Create a `Card.swift` file. In this file, create a `Card` class.

Here's what part of the draw cards response looks like. This is only part of the entire response.. this part only relates to what a Card looks like.

```swift
{
   "image": "https://deckofcardsapi.com/static/img/KH.png",
   "value": "KING",
   "suit": "HEARTS",
   "code": "KH"
}
```

So we should look to create our stored properties in relation to this.

The stored properties on our `Card` class should be the following:

* Constant named `imageURLString` of type `String`
* Constant named `url` of type `URL?`
* Constant named `code` of type `String`
* Variable named `image` of type `UIImage?`
* Constant named `value` of type `String`
* Constant named `suit` of type `String`
* Constant named `apiClient` with a default value of `CardAPIClient.shared`
* Variabled named `isDownloading` with a default value of `false`. 

Looking at what the response looks like above, we have various key-value pairs. Our `init` function should take in a dictionary as its argument. Within your implementation of the `init` function, you be able to access the values from the dictionary passed in and assign  those values to the appropriate stored properties. 

In your `init` function, after you're able to extract out info for the following: `imageURLString`, `code`, `value`, `suit`--you should then look to create a `URL` instance from the `imageURLString` you should now have and assign that `URL` instance back to the `url` stored properties.

**MAJOR HINT INCOMING**

```swift
imageURLString = dictionary["image"] as? String ?? "n/a"
url = URL(string: imageURLString)
```

**--End of major hint**

Now we can make `Card`s. Lets head back over to the `Deck` class.


---

# Back to Deck

(Back to Back)

![](http://i.imgur.com/UTWJkqu.jpg)

Create a function within the `Deck` class named `drawCards(numberOfCards:handler:)`. The first argument should be named `count` of type `Int`. The second argument should be named `handler` of type (`Bool`, [`Card`]?) -> `Void`. The second argument is a function that takes in two arguments, the first argument is a `Bool` and the second argument is a [`Card`]? (an optional array of `Card`s).

In your implementation you should make sure that the `count` argument doesn't exceed the `remaining` cards available in the deck.

You should then call on the `drawCards` function available to the `apiClient` stored property. That call should (through its completion handler) give us back the following response:

```swift
[
    {
        "image": "https://deckofcardsapi.com/static/img/KH.png",
        "value": "KING",
        "suit": "HEARTS",
        "code": "KH"
     },
     {
    	 "image": "https://deckofcardsapi.com/static/img/8C.png",
         "value": "8",
         "suit": "CLUBS",
         "code": "8C"
     }
]
```

It's an array of dictionaries that represent our cards. Before we carry on--you should add one more stored property to our `Deck`.

```swift
var cards: [Card] = []  
```

Ok.. back to the problem at hand. Loop through that array of dictionaries which we're receiving. For each dictionary, create a new `Card` instance (passing in the dictionary to the `Card` `init` function). After creating a `Card` instance, append that new `Card` to the `cards` stored property.

After this for-loop, you should call on the completion handler passing along `true` and `self.cards`.

---

# Back to API

Lets talk about the `downloadImage` function.

Its signature should be the following: `downloadImage(at:handler:)`. The first argument should be named `url` of type `URL`. The second argument should be named `handler` of type (`Bool`, `UIImage?`) -> `Void`. In your implementation, you should look to make a request at the `url` passed in. You should then look to create a `UIImage` with the `Data` you will receive back from the `dataTask` completion handler.

Pass that new `UIImage` back to the caller of the function by calling on `handler` passing it `true` along with the `UIImage` instance you just made.

This method will be used by our `Card` class. So lets head on back there!

---

# Back to Card

Create a function within the `Card` class called `downloadImage(_:)` that takes in one argument called `handler` of type (`Bool`) -> `Void`. 


In your implementation you should call on the `downloadImage` function available now to the `apiClient`. In doing so, we should be getting back a `UIImage` through its completion handler. You should assign that `UIImage` instance to our `image` stored property.

After doing so, you should call on the `handler` argument, passing it a `true` value.

---

# Card View

There has been some code that's been written for you. Take a look at the `CardView.xib` file. It includes a custom view that we've designed. It's associated with the `CardView.swift` file which contains a `CardView` class subclassed from `UIView`.

Create the following stored property in the `CardView.swift` file.


```swift
    weak var card: Card! {
        didSet {
            updateViewToReflectNewCard()
        }
        
    }
```

**Watch this video for further instruction**:

[![Card View Instructions](http://img.youtube.com/vi/P--CeyNSim0/0.jpg)](https://www.youtube.com/watch?v=P--CeyNSim0 "Card View Instructions")


---

# ViewController

Create the following stored property in the `ViewController.swift` file.

```swift
var deck = Deck()
```

Take a look at the TODO: comments. It's up to you how you want to finish this project. I have it setup where when someone taps the Draw button, it will place a card randomly on the screen after making the appropriate API call.

Here's how I place the `Card` on screen using the `CardView`.

You can attempt to try this out on your own before looking at this hint.

**Hint:**

```swift
    func newCardDealt(_ card: Card) {
        
        let viewHeight = view.frame.size.height
        let cardViewHeight = viewHeight * 0.2
        let percentage: CGFloat = 226 / 314
        let cardViewWidth = cardViewHeight * percentage

        let minX = 0 + (cardViewWidth / 2)
        let maxX = view.frame.size.width - (cardViewWidth)
        let minY = 0 + (cardViewHeight / 2)
        let maxY = view.frame.size.height - (cardViewHeight)
        
        let randomX = CGFloat(arc4random_uniform(UInt32(maxX - minX))) + minX
        let randomY = CGFloat(arc4random_uniform(UInt32(maxY - minY))) + minY
        
        let cardView = CardView(frame: CGRect(x: randomX, y: randomY, width: cardViewWidth, height: cardViewHeight))
        view.addSubview(cardView)

        cardView.delegate = self
        cardView.card = card
    }
```












