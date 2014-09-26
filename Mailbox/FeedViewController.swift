//
//  FeedViewController.swift
//  Mailbox
//
//  Created by Hana Kim on 9/24/14.
//  Copyright (c) 2014 Hana. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var archiveIconImage: UIImageView!
    @IBOutlet weak var laterIconImage: UIImageView!
    @IBOutlet weak var rescheduleImage: UIImageView!
    
    var laterIconOriginalOriginX: CGFloat!
    var archiveIconOriginalOriginX: CGFloat!
    var translationX: CGFloat!
    let gray   = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1)
    let yellow = UIColor(red: 0.97, green: 0.91, blue: 0.04, alpha: 1)
    let brown  = UIColor(red: 0.59, green: 0.52, blue: 0.09, alpha: 1)
    let green  = UIColor(red: 0.27, green: 0.75, blue: 0.17, alpha: 1)
    let red    = UIColor(red: 0.91, green: 0.12, blue: 0.12, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rescheduleImage.alpha = 0
        archiveIconImage.alpha = 0
        laterIconImage.alpha = 0
        
        var height = feedImage.frame.height + messageImage.frame.height
        scrollView.contentSize = CGSize(width: 320, height: height)
        messageView.backgroundColor = gray

    }

    func translateToAlpha(translation: CGFloat) -> CGFloat {
        return min(abs(translation / 60), 1)
    }
    
    
    @IBAction func onPanMessage(panGesture: UIPanGestureRecognizer) {
        if (panGesture.state == UIGestureRecognizerState.Began) {
            laterIconOriginalOriginX = laterIconImage.frame.origin.x
            archiveIconOriginalOriginX = archiveIconImage.frame.origin.x
        } else if (panGesture.state == UIGestureRecognizerState.Changed) {
            
            messageImage.frame.origin.x = panGesture.translationInView(messageView).x
            translationX = messageImage.frame.origin.x
            
            laterIconImage.alpha = translateToAlpha(translationX)
            archiveIconImage.alpha = translateToAlpha(translationX)
            
            if (translationX < 60) && (translationX > -60) {
                self.messageView.backgroundColor = self.gray
                
            } else if (translationX < -60) {
                messageView.backgroundColor = yellow
                laterIconImage.image = UIImage(named: "later_icon")
                
                if (translationX < -260) {
                    messageView.backgroundColor = brown
                    laterIconImage.image = UIImage(named: "list_icon")
                    
                } else {
                    laterIconImage.frame.origin.x = laterIconOriginalOriginX + translationX + 60
                }
                
            } else if (translationX > 60) {
                self.messageView.backgroundColor = self.green
                
                if (translationX > 260) {
                    messageView.backgroundColor = red
                    archiveIconImage.image = UIImage(named: "delete_icon")
                    
                } else {
                    archiveIconImage.frame.origin.x = archiveIconOriginalOriginX + translationX - 60
                }
            }
        } else if (panGesture.state == UIGestureRecognizerState.Ended) {

            if (translationX < -260) {
                rescheduleImage.alpha = 1
            } else if (translationX > 260) {
                // delete icon
            } else {
                UIView.animateWithDuration(0.8, animations: { () -> Void in
                    self.messageImage.frame.origin.x = 0
                    self.laterIconImage.frame.origin.x = self.laterIconOriginalOriginX
                    self.archiveIconImage.frame.origin.x = self.archiveIconOriginalOriginX
                    
                    }) {(finished: Bool) -> Void in
                }
            
            }
        }
        
    }
    
    
    
    
    
    @IBAction func onTapReschedule(sender: UITapGestureRecognizer) {
        rescheduleImage.alpha = 0
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
