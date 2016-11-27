# RefreshabrailleTest

### Overview
This is a small XCode iOS project to isolate an issue with VoiceOver and a refreshable Braille display.

As it turns out, it appears to have identified a bug in iOS9 (9.3.5) that is fixed in iOS10.

### The Scenario
The scenario is this: A UILabel with:

> accessibilityTraits = UIAccessibilityTraitPlaysSound | UIAccessibilityTraitKeyboardKey | **UIAccessibilityTraitUpdatesFrequently**

When it has focus, its accessibilityLabel property should be spoken by VoiceOver _and_ displayed on a connected refreshable Braille display, even if the value is updated in the background.

In this demonstration, a timer is used to update the value every 6 seconds.

### Bug Details
The following happens on iOS9, not iOS10.

As the background timer changes the text, VoiceOver speaks the changes, and the refreshable Braille display  is updated, however not all characters of the Braille are displayed.

It seems that the limit of the number characters displayed is set by the length of first value, and then subsequent changes might reduce this character count, but never increase it. 

So if the accessibilityLabel is set to "1" and then changed to "200", VoiceOver will say "Two hundred", but the Braille display will show only "2".

When you move the VoiceOver selection away then back again, it temporarily fixes itself.

###Workaround
I found that I could workaround this problem by suffixing space characters to ensure that I was always outputing a long string. This worked in Swift. Surprising, it didn't work in Objective-C. (Although that just seems too wierd, so I'm not standing by this. Once I solved the problem in Swift, I moved on.)

###Braille Settings
I used 6-dot output, uncontracted.

(I also used 8-dot input, uncontracted, as this works best in my calculator app.)

Both status code and nemeth codes are off.

Device: A Refreshabraille18 by APH.
