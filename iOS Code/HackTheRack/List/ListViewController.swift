//
//  ListViewController.swift
//  HackTheRack
//
//  Created by KL on 22/6/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import Material

class ListViewController: UIViewController {

    @IBOutlet var swipeableView: ZLSwipeableView!
    @IBOutlet var cardView: UIView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        swipeableViewDelegateInit()
        initNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        swipeableView.nextView = {
            print("nextView")
            return self.nextCardView()
        }
    }

    // MARK: Init
    private func initNavigation(){
        navigationItem.titleLabel.text = "Find Discouunt"
    }
    
    // MARK: - Method
    
    private func nextCardView() -> CardView? {
        let cardView = CardView(frame: swipeableView.bounds)
        cardView.delegate = self
        return cardView
    }
}

// MARK: - Swipeable View Delegate
extension ListViewController{
    private func swipeableViewDelegateInit(){
        swipeableView.numberOfActiveView = 3
        swipeableView.numberOfHistoryItem = 0
        
        swipeableView.didStart = {view, location in
            print("Did start swiping view at location: \(location)")
        }
        swipeableView.swiping = {view, location, translation in
            print("Swiping at view location: \(location) translation: \(translation)")
            let card = self.swipeableView.topView() as! CardView
            if translation.x > 0{
                card.likeButton.pulse()
            }else{
                card.dislikeButton.pulse()
            }
        }
        swipeableView.didEnd = {view, location in
            print("Did end swiping view at location: \(location)")
        }
        swipeableView.didSwipe = {view, direction, vector in
            print("Did swipe view in direction: \(direction), vector: \(vector)")
            
        }
        swipeableView.didCancel = {view in
            print("Did cancel swiping view")
        }
        swipeableView.didTap = {view, location in
            print("Did tap at location \(location)")
        }
        swipeableView.didDisappear = { view in
            print("Did disappear swiping view")
        }
    }
}

extension ListViewController: CardViewDelegate{
    func didLikePlant() {
        swipeableView.swipeTopView(inDirection: .Right)
    }
    
    func didDislikePlant() {
        swipeableView.swipeTopView(inDirection: .Left)
    }
}
