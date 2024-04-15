//
//  EditViewController.swift
//  DrumPad
//
//  Created by Denis Dareuskiy on 25.01.24.
//

import UIKit
import AVFoundation

class EditViewController: UITableViewController {

    var playlist = [String]()
    var audioPlayers = [AVAudioPlayer]()
    var currentPlaylist = [String]()
    var updatedPlayer = 0
    
    @IBAction func unwindToScreen (_sender: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellTypeNib = UINib(nibName: "EditCustomCell", bundle: nil)
        // 2. регистрация кастомной ячейки в табличном представлении
        tableView.register(cellTypeNib, forCellReuseIdentifier: "EditCustomCell")
        tableView.rowHeight = UITableView.automaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return audioPlayers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EditCustomCell", for: indexPath) as? EditCustomCell {
            cell.numberLabel.text = String(indexPath.row + 1)
            cell.musicLabel.text = currentPlaylist[indexPath.row]
            return cell
            
        }
        return UITableViewCell()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMusicList" {
            guard let destination = segue.destination as? MusicListViewController else { return }
            destination.playlist = self.playlist
            destination.selectedPlayer = self.updatedPlayer
        }
        if segue.identifier == "toDrumView" {
            guard let destination = segue.destination as? DrumViewController else { return }
            destination.currentPlaylist = self.currentPlaylist
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.updatedPlayer = indexPath.row
        performSegue(withIdentifier: "toMusicList", sender: self)
    }
}
