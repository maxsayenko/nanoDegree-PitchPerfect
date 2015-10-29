//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Max Saienko on 10/20/15.
//  Copyright © 2015 Max Saienko. All rights reserved.
//

import UIKit

class PlaySoundsViewController: UIViewController {
    // UICellView variables
    var cellsPerRow: CGFloat = 2
    let cellPadding: CGFloat = 5
    
    var pitchPerfectModel: PitchPerfectModel?
    var player: AudioEngineHelper?
    
    @IBOutlet var tableForButtons: UICollectionView!
    
    @IBOutlet var stopButton: UIButton!
    
    @IBAction func snailButtonTouch(sender: UIButton) {
        enableStopButton()
        player!.playSnailSound()
    }
    
    @IBAction func rabbitButtonTouch(sender: UIButton) {
        enableStopButton()
        player!.playRabbitSound()
    }
    
    @IBAction func squirellButtonTouch(sender: UIButton) {
        enableStopButton()
        player!.playChipmunkSound()
    }
    
    @IBAction func darthVaderButtonTouch(sender: UIButton) {
        enableStopButton()
        player!.playDarthVaderSound()
    }
    
    @IBAction func echoButtonTouch(sender: UIButton) {
    }
    
    @IBAction func reverbButtonTouch(sender: UIButton) {
    }
    
    
    @IBAction func stopButtonTouch(sender: UIButton) {
        player?.stop()
    }
    
    func callback() {
        dispatch_async(dispatch_get_main_queue()) {
            self.disableStopButton()
        }
    }
    
    func disableStopButton() {
        stopButton.enabled = false
    }
    
    func enableStopButton() {
        stopButton.enabled = true
    }
    
    override func viewDidLoad() {
        print("View did load \(pitchPerfectModel == nil)")
        //player = AudioEngineHelper(model: pitchPerfectModel!, finishPlayingCallback: callback)
        stopButton.enabled = false
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}




extension PlaySoundsViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
//        let cellIdentifier = "cell\(indexPath.item)"
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)

        
//        print(collectionView.cellForItemAtIndexPath(indexPath)?.frame.height)
//        print(indexPath)
        //        let widthMinusPadding = UIScreen.mainScreen().bounds.width - (cellPadding + cellPadding * cellsPerRow)
        //        let eachSide = widthMinusPadding / cellsPerRow
        //        print("Size. Width =  \(eachSide)")
        //
        //        return CGSize(width: eachSide, height: eachSide)
        
        //let numberOfCellsPerRow : CGFloat = 2.0
        let minGapBetweenCells : CGFloat = 10.0
        let totalSpaceBetweenCells : CGFloat = ((cellsPerRow - 1) * minGapBetweenCells) + 40
        print("total space = \(totalSpaceBetweenCells)")
        let cellWidth : CGFloat = (collectionView.frame.size.width - totalSpaceBetweenCells) / cellsPerRow
        print("Collection width =\(collectionView.frame.size.width)  & cellWidth = \(cellWidth) & cellsPerRow = \(cellsPerRow)")
        return CGSize(width: cellWidth, height: 90)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "cell\(indexPath.item)"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.blackColor()
        
        // Configure the cell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    @IBAction func secondButton(sender: AnyObject) {
        print("2")
    }
    @IBAction func first(sender: AnyObject) {
        print("1")
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        print("Rotating \(traitCollection.verticalSizeClass.rawValue)")
        super.traitCollectionDidChange(previousTraitCollection)
        cellsPerRow = (traitCollection.verticalSizeClass == .Compact) ? 3 : 2
        print("cells per row = \(cellsPerRow)")
        tableForButtons.reloadData()
    }
}
