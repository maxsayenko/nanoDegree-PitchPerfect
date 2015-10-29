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
        player?.playSnailSound()
    }
    
    @IBAction func rabbitButtonTouch(sender: UIButton) {
        enableStopButton()
        player?.playRabbitSound()
    }
    
    @IBAction func squirellButtonTouch(sender: UIButton) {
        enableStopButton()
        player?.playChipmunkSound()
    }
    
    @IBAction func darthVaderButtonTouch(sender: UIButton) {
        enableStopButton()
        player?.playDarthVaderSound()
    }
    
    @IBAction func echoButtonTouch(sender: UIButton) {
        enableStopButton()
        player?.playEcho()
    }
    
    @IBAction func reverbButtonTouch(sender: UIButton) {
        enableStopButton()
        player?.playReverb()
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
        player = AudioEngineHelper(model: pitchPerfectModel!, finishPlayingCallback: callback)
        disableStopButton()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension PlaySoundsViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let minGapBetweenCells : CGFloat = 10.0
        let totalSpaceBetweenCells : CGFloat = ((cellsPerRow - 1) * minGapBetweenCells) + 40
        let cellWidth : CGFloat = (collectionView.frame.size.width - totalSpaceBetweenCells) / cellsPerRow
        return CGSize(width: cellWidth, height: 90)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "cell\(indexPath.item)"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if (traitCollection.verticalSizeClass == .Compact) {
            cellsPerRow = 3
        }
        else {
            cellsPerRow = 2
        }
        tableForButtons.frame.size.height = 100
        tableForButtons.reloadData()
    }
}
