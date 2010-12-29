README
======

This is a quickie little category on UIAlertView which enables you to use blocks to handle the button selection instead of implementing a delegate.

HOW IT WORKS
------------

Instead of calling the traditional `-initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:` initializer, you call the new initializer: `-initWithTitle:message:cancelButtonItem:otherButtonItems:`.  This works just like the traditional initializer, except instead of using strings for the buttons, it takes instances of UIAlertViewButtonItem's.  This is a class also defined as part of the category which simply encapsulates the button name and the action block to execute when that button is tapped.  The last argument is variadic, just like the traditional method, so it must be `nil` terminated.

The action blocks are of type AlertViewAction, which is typedef'd to be a block as follows:

	typedef void (^AlertViewAction)();

The UIAlertViewButtonItem class also provides a convenience method which returns an autoreleased item called, conveniently enough, `+item`.

Under the covers, the category takes the button items you pass in, and it stores them as an associated object with the UIAlertView itself.  It then initializes a traditional UIAlertView, setting itself as the delegate.  When the UIAlertView gets the `-alertView:didDismissWithButtonIndex:` delegate method called, it pulls out the button items, looks up the one associated with the tapped button, and executes the block associated with that button.

One little bit of weirdness you may be curious about is this:  In the initializer, it retains itself.  The reason it does this is because the expectation is that you'll basically fire and forget this.  I didn't want to have to hold onto an instance variable for this guy or anything, and I wasn't sure if the didDismiss method was called before or after the alertview was removed from the view hierarchy and thus, possibly deallocated.  Since the UIAlertView itself is it's own delegate, if it gets deallocated before the didDismiss method is called, it would crash, and we don't want that.  By retaining self, we don't need to worry about it.  The only concern then is that we have to remember to release self in the delegate method, which we do.  If anyone can confirm or deny that this code is required, I'd welcome the discussion.  Does retaining self make me feel dirty?  Yes.  And naughty... oh yeah... and naughty... ;)

HOW TO USE IT
-------------

Typically, you'll create items that represent the buttons and the actions to take when they are tapped.  For example imagine a dialog box confirming deletion of an item:

	UIAlertViewButtonItem *cancelItem = [UIAlertViewButtonItem item];
	cancelItem.name = @"No";
	cancelItem.action = ^
	{
		// this is the code that will be executed when the user taps "No"
		// this is optional... if you leave the action as nil, it won't do anything
		// but here, I'm showing a block just to show that you can use one if you want to.
	};

	UIAlertViewButtonItem *deleteItem = [UIAlertViewButtonItem item];
	deleteItem.name = @"Yes";
	deleteItem.action = ^
	{
		// this is the code that will be executed when the user taps "Yes"
		// delete the object in question...
		[context deleteObject:theObject];
	};

Once you've created these, you simply initialize your UIAlertView using the initializer, passing your button items accordingly:

	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Delete This Item?" message:@"Are you sure you want to delete this really important thing?" cancelButtonItem:cancelItem otherButtonItems:deleteItem, nil];
	[alertView show];
	[alertView release];

Again, this is designed to be fire and forget, so you initialize it, show it, and release it.  It'll take care of cleaning up after itself.

That's it!