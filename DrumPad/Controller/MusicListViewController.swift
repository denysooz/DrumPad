//
//  MusicListViewController.swift
//  DrumPad
//
//  Created by Denis Dareuskiy on 24.01.24.
//

import UIKit
import AVFoundation

class MusicListViewController: UITableViewController, AVAudioPlayerDelegate {
    
    var selectedRowIndex: IndexPath?
    var selectedPlayer = 0
    var playlist: [String] = []
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as? MusicCell {
            cell.musicLabel.text = playlist[indexPath.row]
            cell.accessoryType = (selectedRowIndex == indexPath) ? .checkmark : .none
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Уберите галочку из предыдущей выбранной ячейки
        if let previousSelectedRowIndex = selectedRowIndex {
            let previousSelectedCell = tableView.cellForRow(at: previousSelectedRowIndex)
            previousSelectedCell?.accessoryType = .none
        }
        // Обновите индекс текущей выбранной ячейки
        selectedRowIndex = indexPath
        // Установите галочку для текущей выбранной ячейки
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.accessoryType = .checkmark
        // Задаем плееру выбранный трек
        if let soundFilePath = Bundle.main.path(forResource: playlist[indexPath.row], ofType: nil) {
            let soundFileURL = URL(fileURLWithPath: soundFilePath)
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL)
            } catch {
                print("Error loading sound: \(error)")
            }
        }
        // Вызываем плеер. Мы не пишем строку с остановкой плеера, ибо после выбора другого трека
        // изменяется трек в плеере и плеер останавливается сам
        self.audioPlayer?.play()
        // Вызовите этот метод, чтобы обновить интерфейс ячейки
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditView" {
            guard let destination = segue.destination as? EditViewController else { return }
            destination.currentPlaylist[selectedPlayer] = playlist[selectedRowIndex?.row ?? 0]
        }
    }
}
