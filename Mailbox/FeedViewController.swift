//
//  FeedViewController.swift
//  Mailbox
//
//  Created by Hana Kim on 9/24/14.
//  Copyright (c) 2014 Hana. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet var parentContainerView: UIView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messagesView: UIView!
    @IBOutlet weak var helpLabelImage: UIImageView!
    @IBOutlet weak var searchBarImage: UIImageView!
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var archiveIconImage: UIImageView!
    @IBOutlet weak var laterIconImage: UIImageView!
    @IBOutlet weak var rescheduleImage: UIImageView!
    @IBOutlet weak var listImage: UIImageView!
    
    var lastAction: Int!
    var diff: CGFloat!

    
    var laterIconOriginalOriginX: CGFloat!
    var archiveIconOriginalOriginX: CGFloat!
    var translationX: CGFloat!
    let gray   = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1)
    let yellow = UIColor(red: 0.97, green: 0.91, blue: 0.04, alpha: 1)
    let brown  = UIColor(red: 0.59, green: 0.52, blue: 0.09, alpha: 1)
    let green  = UIColor(red: 0.27, green: 0.75, blue: 0.17, alpha: 1)
    let red    = UIColor(red: 0.91, green: 0.12, blue: 0.12, alpha: 1)
    var openMenuX: CGFloat!
    var edgeGesture: UIScreenEdgePanGestureRecognizer!
    
    var menuOpen = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1 = archive
        // 2 = delete
        // 3 = later
        // 4 = list
        lastAction = 0
        
        
        rescheduleImage.alpha = 0
        listImage.alpha = 0
        archiveIconImage.alpha = 0
        laterIconImage.alpha = 0
        openMenuX = 280
        
        var height = feedImage.frame.height + messageImage.frame.height + searchBarImage.frame.height + helpLabelImage.frame.height
        scrollView.contentSize = CGSize(width: 320, height: height)
        messageView.backgroundColor = gray

        edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        messagesView.addGestureRecognizer(edgeGesture)
    }
    
    
    @IBAction func onPanMessage(panGesture: UIPanGestureRecognizer) {
        if (panGesture.state == UIGestureRecognizerState.Began) {
            laterIconOriginalOriginX = laterIconImage.frame.origin.x
            archiveIconOriginalOriginX = archiveIconImage.frame.origin.x
            
        } else if (panGesture.state == UIGestureRecognizerState.Changed) {
            translationX = panGesture.translationInView(messageView).x
            messageImage.frame.origin.x = translationX
            
            if (-320 <= translationX) && (translationX < -260) {
                messageView.backgroundColor = brown
                laterIconImage.image = UIImage(named: "list_icon")
                laterIconImage.frame.origin.x = laterIconOriginalOriginX + translationX + 60

            } else if (-260 <= translationX) && (translationX < -60) {
                messageView.backgroundColor = yellow
                laterIconImage.image = UIImage(named: "later_icon")
                laterIconImage.frame.origin.x = laterIconOriginalOriginX + translationX + 60
                
            } else if (-60 <= translationX) && (translationX < 0) {
                self.messageView.backgroundColor = gray
                laterIconImage.alpha = translateToAlpha(translationX)
                
            } else if (0 <= translationX) && (translationX < 60) {
                self.messageView.backgroundColor = gray
                archiveIconImage.alpha = translateToAlpha(translationX)
                
            } else if (60 <= translationX) && (translationX < 260) {
                self.messageView.backgroundColor = green
                archiveIconImage.image = UIImage(named: "archive_icon")
                archiveIconImage.frame.origin.x = archiveIconOriginalOriginX + translationX - 60

            } else if (260 <= translationX) && (translationX < 320) {
                messageView.backgroundColor = red
                archiveIconImage.image = UIImage(named: "delete_icon")
                archiveIconImage.frame.origin.x = archiveIconOriginalOriginX + translationX - 60

            } else {
                println("WTF... Shouldn't get here... need to throw exception")
            }

        } else if (panGesture.state == UIGestureRecognizerState.Ended) {
            if (-320 <= translationX) && (translationX < -260) {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImage.frame.origin.x = -320
                    }) {(finished: Bool) -> Void in
                        self.listImage.alpha = 1
                }
            } else if (-260 <= translationX) && (translationX < -60) {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImage.frame.origin.x = -320
                    self.laterIconImage.frame.origin.x = -320
                    }) {(finished: Bool) -> Void in
                        self.rescheduleImage.alpha = 1
                }
            } else if (-60 <= translationX) && (translationX < 0) {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImage.frame.origin.x = 0
                    self.laterIconImage.frame.origin.x = self.laterIconOriginalOriginX
                    })
            } else if (0 <= translationX) && (translationX < 60) {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImage.frame.origin.x = 0
                    self.archiveIconImage.frame.origin.x = self.archiveIconOriginalOriginX
                })
                
            } else if (60 <= translationX) && (translationX < 260) {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImage.frame.origin.x = 320
                    self.archiveIconImage.frame.origin.x = 320
                    }) {(finished: Bool) -> Void in
                        self.collapseMessage()
                }
            } else if (260 <= translationX) && (translationX < 320) {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageImage.frame.origin.x = 320
                    self.archiveIconImage.frame.origin.x = 320
                    }) {(finished: Bool) -> Void in
                        self.collapseMessage()
                }
            } else {
                println("WTF... Shouldn't get here... need to throw exception")
            }
        }
    }
    
    
    func translateToAlpha(translation: CGFloat) -> CGFloat {
        /// need to clean this up
        return min(abs(translation / 60), 1)
    }
    
    func collapseMessage() {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.feedImage.frame.origin.y = 79
            }) {(finished: Bool) -> Void in
                self.messageView.alpha = 0
                self.scrollView.contentSize.height -= self.messageImage.frame.height
        }
    }
    
    
    @IBAction func onTapReschedule(sender: UITapGestureRecognizer) {
        rescheduleImage.alpha = 0
        collapseMessage()
    }
    
    @IBAction func onTapList(sender: UITapGestureRecognizer) {
        listImage.alpha = 0
        collapseMessage()
    }
    
    
    @IBAction func showMenu(sender: AnyObject) {
        if menuOpen {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.messagesView.frame.origin.x = 0
                }) {(finished: Bool) -> Void in
                    self.menuOpen = false
                    self.edgeGesture.edges = UIRectEdge.Left
            }
        } else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.messagesView.frame.origin.x = self.openMenuX
                }) {(finished: Bool) -> Void in
                    self.menuOpen = true
                    self.edgeGesture.edges = UIRectEdge.Right
            }
        }
    }
    
    
    @IBAction func onEdgePan(edgePan: UIScreenEdgePanGestureRecognizer) {
        var translatedX = edgePan.translationInView(parentContainerView).x
        var locationX = edgePan.locationInView(parentContainerView).x
        
        if (edgePan.state == UIGestureRecognizerState.Began) {
            diff = edgePan.locationInView(parentContainerView).x - openMenuX

        } else if (edgePan.state == UIGestureRecognizerState.Changed) {
            
            if (!menuOpen) {
                messagesView.frame.origin.x = translatedX
            } else {
               // println("--------------")
               // println("origin    :         \(messagesView.frame.origin.x)")
                println("diff:         \(diff)")
               // println("translated updated: \(translatedX)")
                locationX = edgePan.locationInView(parentContainerView).x - diff
                
               // println("location: \(locationX)")
                
                messagesView.frame.origin.x = locationX

                
            }
            
            
        } else if (edgePan.state == UIGestureRecognizerState.Ended) {
            menuOpen = !(edgePan.velocityInView(parentContainerView).x >= 0)
            showMenu(UIScreenEdgePanGestureRecognizer)
            
            println("done edge panning")
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: (UIEvent!)) {
        
        var undoMessage = "Are you sure you want ot undo that, and move 1 item from X to Y?"
        
        if(event.subtype == UIEventSubtype.MotionShake) {
            
            var alertView = UIAlertView(title: "Undo last action", message: undoMessage, delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Undo")
            
            alertView.show()
        }
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        // 0 is cancel
        // 1 is Undo
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
