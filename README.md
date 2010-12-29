README

This is a quickie little category on UIAlertView which enables you to use blocks to handle the button selection instead of implementing a delegate.

HOW IT WORKS

Instead of calling the traditional `-initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:` initializer, you call the new initializer: `-initWithTitle:message:cancelButtonItem:otherButtonItems:`.  This works just like the traditional initializer, except instead of using strings for the buttons, it takes instances of UIAlertViewButtonItem's.  This is a class also defined as part of the category which simply encapsulates the button name and the action block to execute when that button is tapped.  The last argument is variadic, just like the traditional method, so it must be `nil` terminated.

The action blocks are of type AlertViewAction, which is typedef'd to be a block as follows:

	typedef void (^AlertViewAction)();

The UIAlertViewButtonItem class also provides a convenience method which returns an autoreleased item called, conveniently enough, `+item`.