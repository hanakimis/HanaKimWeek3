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
    @IBOutlet weak var helpTextImage: UIImageView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var archiveIconImage: UIImageView!
    @IBOutlet weak var laterIconImage: UIImageView!
    
    @IBOutlet weak var rescheduleImage: UIImageView!
    
    
    
    var laterIconOriginalOriginX: CGFloat!
    var translationX: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rescheduleImage.alpha = 0
        
        var height = feedImage.frame.height + messageImage.frame.height
        scrollView.contentSize = CGSize(width: 320, height: height)
        
    }

    
    
    @IBAction func onPanMessage(panGesture: UIPanGestureRecognizer) {
        if (panGesture.state == UIGestureRecognizerState.Began) {
            laterIconOriginalOriginX = laterIconImage.frame.origin.x
            
        } else if (panGesture.state == UIGestureRecognizerState.Changed) {
            
            translationX = panGesture.translationInView(messageView).x
            messageImage.frame.origin.x = translationX
            
            if (translationX < -60) {
                laterIconImage.frame.origin.x = laterIconOriginalOriginX + translationX + 60

                
                
                //println("-----------------------------")
                //println("+      original:   \(laterIconOriginalOriginX)")
                //println("+   translation:   \(translationX)")
                //println("= Icon location: \(laterIconImage.frame.origin.x)")

                // change background-color
                
                println("+   translation:   \(translationX)")

            } else if (translationX > 60) {
                // do the check thing
            }
            
            
            
        } else if (panGesture.state == UIGestureRecognizerState.Ended) {
            // scrollback
            println("after pan:   \(translationX)")

            if (translationX < -160) {
                rescheduleImage.alpha = 1
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
