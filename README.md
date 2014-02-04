README
======

This is a quickie pair of categories on UIAlertView and UIActionSheet which enables you to use blocks to handle the button selection instead of implementing a delegate.

HOW IT WORKS
------------

Using UIAlertView as the main example here, instead of calling the traditional `-initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:` initializer, you call the new initializer: `-initWithTitle:message:cancelButtonItem:otherButtonItems:`.  This works just like the traditional initializer, except instead of using strings for the buttons, it takes instances of RIButtonItem's.  This is a class also defined as part of this framework which simply encapsulates the button label and the action block to execute when that button is tapped.  The last argument to the initializer is variadic, just like the traditional initializer, so it must be `nil` terminated.

The action blocks are of type RISimpleAction, which is typedef'd to be a block as follows:

	typedef void (^RISimpleAction)();

This is just a simple block which takes no arguments and returns nothing.

The RIButtonItem class also provides a convenience method which returns an autoreleased item called, conveniently enough, `+item`. If you don't specify an action, the button will still show, but won't do anything when tapped other than dismiss the dialog. This is pretty common with cancel buttons, so another convenience method called `+itemWithLabel:` allows you to quickly create an item that has no action.

Under the covers, the category takes the button items you pass in, and it stores them as an associated object with the UIAlertView itself.  It then initializes a traditional UIAlertView, setting itself as the delegate.  When the UIAlertView gets the `-alertView:didDismissWithButtonIndex:` delegate method called, it pulls out the button items, looks up the one associated with the tapped button, and executes the block associated with that button.

One little bit of weirdness you may be curious about is this:  In the initializer, it retains itself.  The reason it does this is because the expectation is that you'll basically fire and forget this.  I didn't want to have to hold onto an instance variable for this guy or anything, and I wasn't sure if the didDismiss method was called before or after the alertview was removed from the view hierarchy and thus, possibly deallocated.  Since the UIAlertView itself is it's own delegate, if it gets deallocated before the didDismiss method is called, it would crash, and we don't want that.  By retaining self, we don't need to worry about it.  The only concern then is that we have to remember to release self in the delegate method, which we do.  If anyone can confirm or deny that this code is required, I'd welcome the discussion.  Does retaining self make me feel dirty?  Yes.  And naughty... oh yeah... so naughty... ;)

HOW TO USE IT
-------------

Typically, you'll create items that represent the buttons and the actions to take when they are tapped.  For example imagine a dialog box confirming deletion of an item:

	RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:@"No" action:^{
		// this is the code that will be executed when the user taps "No"
		// this is optional... if you leave the action as nil, it won't do anything
		// but here, I'm showing a block just to show that you can use one if you want to.
	}];

	RIButtonItem *deleteItem = [RIButtonItem itemWithLabel:@"Yes" action:^{
		// this is the code that will be executed when the user taps "Yes"
		// delete the object in question...
		[context deleteObject:theObject];
	}];

The label property on the button items is the text that will be displayed in the button.

Once you've created these, you simply initialize your UIAlertView using the initializer, passing your button items accordingly:

	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Delete This Item?"
	                                                    message:@"Are you sure you want to delete this really important thing?"
											   cancelButtonItem:cancelItem
											   otherButtonItems:deleteItem, nil];
	[alertView show];

Alternatively you can also use a single line to create buttons and declare the alert view

	[[[UIAlertView alloc] initWithTitle:@"Delete This Item?"
	                            message:@"Are you sure you want to delete this really important thing?"
		               cancelButtonItem:[RIButtonItem itemWithLabel:@"Yes" action:^{
		                                  // Handle "Cancel"
		                                }]
				       otherButtonItems:[RIButtonItem itemWithLabel:@"Delete" action:^{
		                                   // Handle "Delete"
				                        }], nil] show];


Again, this is designed to be fire and forget, so you initialize it, show it, and release it.  It'll take care of cleaning up after itself.

You can also add a RIButtonItem to the UIAlertView after initialization, just like you normally would:

    [alertView addButtonItem:deleteItem];

This is useful if building an UIAlertView, or UIActionSheet dynamically from an Array:

    for (RIButtonItem *item in buttonItemArray) {
      [alertView addButtonItem:item];
    }

That's it!

The UIActionSheet category works virtually the same as the UIAlertView.  Just check out the header for the initializer you need to use.  It's very straightforward.

FIND THIS USEFUL?
-----------------

Why don't you buy me a beer with bitcoin?

My wallet address is: 1JtjkQFmJmbMumWquh5J2fuRuD6LkWr5QL

![Wallet QR Code](http://www.random-ideas.net/qrcode.png)


LICENSE
-------

Copyright (C) 2011-2014 by Random Ideas, LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
