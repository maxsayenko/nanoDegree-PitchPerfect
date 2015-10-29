//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Max Saienko on 10/20/15.
//  Copyright © 2015 Max Saienko. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    var cellsPerRow: CGFloat = 2
    let cellPadding: CGFloat = 5
    
    @IBOutlet var collectionView: UICollectionView!
    
    let textRecording = "Recording!"
    let textRecord = "Tap to record!"
    let textResume = "Resume!"
    var recordState: RecordState = .Stopped
    
    let recorder = RecordAudioHelper()
    let pitchPerfectModel = PitchPerfectModel()
    
    @IBOutlet var recordLabel: UILabel!
    @IBOutlet var stopButton: UIButton!
    
    @IBAction func recordButtonTouch(sender: UIButton) {
        switch recordState {
        // Start recording
        case .Stopped:
            recorder.recordWithPermission(setup: true, doneRecordingCallback: doneRecordingCallback)
            recordLabel.text = textRecording
            stopButton.hidden = false
            recordState = .Recording
        // Pause recording
        case .Recording:
            recorder.pause()
            recordLabel.text = textResume
            recordState = .Paused
        // Resume from Pause
        case .Paused:
            recorder.resume()
            recordLabel.text = textRecording
            recordState = .Recording
        }
    }
    
    func doneRecordingCallback(url: NSURL) -> Void {
        print("doneRecordingCallback = \(url)")
        pitchPerfectModel.audioUrl = url
        self.performSegueWithIdentifier("showPlaySoundsView", sender: self)
    }
    
    @IBAction func stopButtonTouch(sender: UIButton) {
        recordState = .Stopped
        recorder.stop()
    }
    
    override func viewWillAppear(animated: Bool) {
        // initial state of the view
        recordLabel.text = textRecord
        stopButton.hidden = true
        recordState = .Stopped
        super.viewWillAppear(animated)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepareForSegue")
        if(segue.identifier == "showPlaySoundsView") {
            let playSoundsViewController = (segue.destinationViewController as! PlaySoundsViewController)
            playSoundsViewController.pitchPerfectModel = pitchPerfectModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension RecordSoundsViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        
//        let widthMinusPadding = UIScreen.mainScreen().bounds.width - (cellPadding + cellPadding * cellsPerRow)
//        let eachSide = widthMinusPadding / cellsPerRow
//        print("Size. Width =  \(eachSide)")
//        
//        return CGSize(width: eachSide, height: eachSide)
        
        //let numberOfCellsPerRow : CGFloat = 2.0
        let minGapBetweenCells : CGFloat = 10.0
        let totalSpaceBetweenCells : CGFloat = (cellsPerRow - 1) * minGapBetweenCells
        let cellWidth : CGFloat = (collectionView.frame.size.width - totalSpaceBetweenCells) / cellsPerRow
        
        return CGSize(width: cellWidth, height: 20)
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
        print("Rotating \(traitCollection.verticalSizeClass)")
        super.traitCollectionDidChange(previousTraitCollection)
        cellsPerRow = (traitCollection.verticalSizeClass == .Compact) ? 3 : 2
        collectionView.reloadData()
    }
}