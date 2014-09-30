# Mailbox
---
This is Hana Kim's submission for the assignment (Mailbox prototype) for Week 3 in the Codepath, September 2014 iOS for Designers class.


**Time Spent:** 9.5 Hours


### Completed User Stories

#### On dragging the message left...
* Initially, the background is gray.

* The reschedule icon should start semi-transparent and become fully opaque. __If released, the message should return to the initial position.__

* After 60 pts, the icon moves with the translation and the background should change to yellow. __If released, the message continues to reveal the yellow background. When done, reschedule is shown.__

* After 260 pts, the icon changes to the list icon and the background color changes to brown.
__If released, the message continues to reveal the brown background. When done, list options are shown.__

* User can tap to dismissing the reschedule or list options. then, the message finishes the hide animation.


#### On dragging the message right...
* Initially, the revealed background color should be gray.

* As the archive icon is revealed, it should start semi-transparent and become fully opaque. __If released at this point, the message should return to its initial position.__

* After 60 pts, the archive icon should start moving with the translation and the background should change to green. __Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.__

* After 260 pts, the icon should change to the delete icon and the background color should change to red.
__Upon release, the message should continue to reveal the red background. When the animation it complete, it should hide the message.__


#### Panning for Menu
* **Optional**: Panning from the edge should reveal the menu

* **Optional**:  If the menu is being revealed when the user lifts their finger, it should continue revealing.

* **Optional**: If the menu is being hidden when the user lifts their finger, it should continue hiding.

* **Optional**: Added Shake to undo, based on action taken, text is updated in the alert. Shaking when no action is on the queue (when the app starts, or the message has been reset), doesn't do anything. I could also have done an alert that says there is nothing to undo, but that made the case statement long and ugly so I just left it as is.

* **Optional**: I added the button to open and close the menu

### Notes
* I've added a button to "reset" the message by clicking on the area with the text "Help me get to zero". I only added it so that it would make the showing of the different options faster to get through.

#### Walkthrough of Stories
![alt text](https://github.com/hanakimis/HanaKimWeek3/blob/master/HanaKimWeek3.gif "Week 3 gif")

***

Gif created with [LiceCap](http://www.cockos.com/licecap/)
