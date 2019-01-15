//
//  ExerciseTableViewController.swift
//  6 Pack ABs
//
//  Created by Raymond Chau on 1/9/19.
//  Copyright © 2019 Egg Altar. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ExerciseTableViewController: UITableViewController {

    var exercises = ["Figure-8",
                     "Windshield Wipers",
                     "Twisting Pistons",
                     "Rest",
                     "Starfish Crunch",
                     "Tuck Planks",
                     "Upper Circle Crunches Right",
                     "Upper Circle Crunches Left"]
    var times = [60, 60, 60, 30, 30, 60, 60, 60]
    var players: [AVPlayerViewController?] = [nil, nil, nil, nil, nil, nil, nil, nil]
    var timer: Timer?
    var currentIndex = 0
    var sound: SystemSoundID = 1032
    let synth = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance()
    
    @IBAction func fastForward(_ sender: Any) {
        times[currentIndex] -= 10
        updateTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ExerciseTableViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        times[currentIndex] -= 1
        self.tableView.reloadData()
        if (times[currentIndex] == 4) {
            AudioServicesPlayAlertSound(sound)
        } else if (times[currentIndex] <= 0 && currentIndex < exercises.count - 1) {
            currentIndex += 1
            self.tableView.scrollToRow(at: IndexPath.init(row: self.currentIndex, section: 0), at: .top, animated: true)
            let utterance = AVSpeechUtterance(string: exercises[currentIndex])
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            
            synth.speak(utterance)
        } else if (times[times.count - 1] <= 0) {
            timer?.invalidate()
            updateDates()
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    func updateDates() {
        var dates: [Date]
        dates = UserDefaults.standard.array(forKey: "dates") as? [Date] ?? []
        dates.append(Date.init())
        UserDefaults.standard.set(dates, forKey: "dates")
    }
    
    func manageVideos(forIndex index: Int, withURL URL: URL?, forView view: UIView) {
        if (players[index] == nil) {
            let avpController = AVPlayerViewController()
            let player = AVPlayer(url: URL!)
            
            avpController.player = player
            avpController.showsPlaybackControls = false
            avpController.view.frame.size.height = view.frame.size.height
            
            avpController.view.frame.size.width = view.frame.size.width
            
            view.addSubview(avpController.view)
            
            player.isMuted = true
            player.play()
            
            players[index] = avpController
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                player.seek(to: CMTime.zero)
                player.play()
            }

        } else {
            view.addSubview(players[index]!.view)
        }
        //Pause players
        for (i, AVPlayer) in players.enumerated() {
            if (i != currentIndex) {
                AVPlayer?.player?.pause()
            } else if (AVPlayer?.player?.rate == Float("0.0") && i == currentIndex) {
                AVPlayer?.player?.play()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startTimer()
        let utterance = AVSpeechUtterance(string: exercises[currentIndex])
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        synth.speak(utterance)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        players = [nil, nil, nil, nil, nil, nil, nil, nil]
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exercises.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exercise", for: indexPath) as! ExerciseTableViewCell

        // Configure the cell...
        cell.nameLabel.text = exercises[indexPath.row]
        
        manageVideos(forIndex: indexPath.row, withURL: Bundle.main.url(forResource: exercises[indexPath.row], withExtension: "mp4")!, forView: cell.videoView)

        cell.timeLabel.text = "\(times[indexPath.row]) Seconds"
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
