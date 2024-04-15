//
//  DrumViewController.swift
//  DrumPad
//
//  Created by Denis Dareuskiy on 23.01.24.
//

import UIKit
import AVFoundation

class DrumViewController: UIViewController {
    // Текущий размер
    var currentSize: String = ""
    var currentIntSize: Int = 0
    // Отступ между кнопками
    let spacing: CGFloat = 20
    var setDefaultPlaylist: Bool = false
    var buttonsArray: [UIButton] = []
    // Аудиоплеер и массив аудиоплееров для каждой кнопки
    var audioPlayer: AVAudioPlayer?
    var audioPlayers: [AVAudioPlayer] = []
    // Задаем массив, котоfрый будет хранить все треки
    var playlist: [String] = []
    var currentPlaylist: [String] = []
    
    @IBAction func unwindToScreen (_sender: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentIntSize = convertSizeToInt()
        print(currentIntSize)
        generateButtons(currentSize: currentIntSize)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if setDefaultPlaylist == false {
            setPlaylist()
            setCurrentPlaylistDefault()
            setDefaultPlaylist = true
        } else {
            setTheMusic()
        }
    }
    
    func convertSizeToInt() -> Int {
        var finalNumber: Int = 0
        if let firstCharacter = currentSize.first {
            // Проверяем, является ли символ цифрой
            if let firstNumber = Int(String(firstCharacter)) {
                // Умножаем первый символ на 2
                let result = firstNumber * firstNumber
                // Создаем переменную типа Int с полученным результатом
                finalNumber = result
            }
        }
        return finalNumber
    }
    
    func generateButtons(currentSize: Int) {
        switch currentSize {
        case 4: generate4Buttons()
        case 9: generate9Buttons()
        case 16: generate16Buttons()
        default:
            break
        }
    }
    
    func generate4Buttons() {
        // Обновление массива кнопок после каждой генерации
        self.buttonsArray = []
        // Объявление стеков
        let mainStack = UIStackView()
        let stackHorizontal1 = UIStackView()
        let stackHorizontal2 = UIStackView()
        // Добавление стеков на экран
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(stackHorizontal1)
        mainStack.addArrangedSubview(stackHorizontal2)
        // Задаем направление стека
        mainStack.axis = .vertical
        stackHorizontal1.axis = .horizontal
        stackHorizontal2.axis = .horizontal
        // Задаем отступы
        let spacing: CGFloat = 20
        mainStack.spacing = spacing
        stackHorizontal1.spacing = spacing
        stackHorizontal2.spacing = spacing
        // Задаем размер отступа от левого и правого краев
        let marginWidth: CGFloat = 40
        // Задаем размер кнопок
        let buttonSize: CGFloat = 160
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontal1.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontal2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            mainStack.widthAnchor.constraint(equalTo: mainStack.heightAnchor),
            mainStack.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: marginWidth),
            //mainStack.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -marginWidth),
        ])
        
        // Задаем все возможные параметры в цикле
        for i in 0..<currentIntSize {
            let button = UIButton()
            button.addTarget(self, action: #selector(playAudio(_:)), for: .touchUpInside)
            button.backgroundColor = .black
            // Установите желаемый размер кнопки
                // button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.tag = i
            view.addSubview(button)
            self.buttonsArray.append(button)
            
        }
        stackHorizontal1.addArrangedSubview(buttonsArray[0])
        stackHorizontal1.addArrangedSubview(buttonsArray[1])
        stackHorizontal2.addArrangedSubview(buttonsArray[2])
        stackHorizontal2.addArrangedSubview(buttonsArray[3])
        
        stackHorizontal1.distribution = .fillEqually
        stackHorizontal2.distribution = .fillEqually
        stackHorizontal1.alignment = .center
        stackHorizontal2.alignment = .center
        mainStack.distribution = .fillEqually
    }
    
    func generate9Buttons() {
        // Обновление массива кнопок после каждой генерации
        self.buttonsArray = []
        // Объявление стеков
        let mainStack = UIStackView()
        let stackHorizontal1 = UIStackView()
        let stackHorizontal2 = UIStackView()
        let stackHorizontal3 = UIStackView()
        // Добавление стеков на экран
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(stackHorizontal1)
        mainStack.addArrangedSubview(stackHorizontal2)
        mainStack.addArrangedSubview(stackHorizontal3)
        // Задаем направление стека
        mainStack.axis = .vertical
        stackHorizontal1.axis = .horizontal
        stackHorizontal2.axis = .horizontal
        stackHorizontal3.axis = .horizontal
        // Задаем отступы
        let spacing: CGFloat = 20
        mainStack.spacing = spacing
        stackHorizontal1.spacing = spacing
        stackHorizontal2.spacing = spacing
        stackHorizontal3.spacing = spacing
        // Задаем размер отступа от левого и правого краев
        let marginWidth: CGFloat = 40
        // Задаем размер кнопок
        let buttonSize: CGFloat = 100
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontal1.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontal2.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontal3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            mainStack.widthAnchor.constraint(equalTo: mainStack.heightAnchor),
            mainStack.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: marginWidth),
            //mainStack.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -marginWidth),
        ])
        
        // Задаем все возможные параметры в цикле
        for i in 0..<currentIntSize {
            let button = UIButton()
            button.addTarget(self, action: #selector(playAudio(_:)), for: .touchUpInside)
            button.backgroundColor = .black
            // Установите желаемый размер кнопки
                // button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.tag = i
            view.addSubview(button)
            self.buttonsArray.append(button)
            
        }
        stackHorizontal1.addArrangedSubview(buttonsArray[0])
        stackHorizontal1.addArrangedSubview(buttonsArray[1])
        stackHorizontal1.addArrangedSubview(buttonsArray[2])
        stackHorizontal2.addArrangedSubview(buttonsArray[3])
        stackHorizontal2.addArrangedSubview(buttonsArray[4])
        stackHorizontal2.addArrangedSubview(buttonsArray[5])
        stackHorizontal3.addArrangedSubview(buttonsArray[6])
        stackHorizontal3.addArrangedSubview(buttonsArray[7])
        stackHorizontal3.addArrangedSubview(buttonsArray[8])
        
        stackHorizontal1.distribution = .fillEqually
        stackHorizontal2.distribution = .fillEqually
        stackHorizontal3.distribution = .fillEqually
        
        stackHorizontal1.alignment = .center
        stackHorizontal2.alignment = .center
        stackHorizontal3.alignment = .center
        mainStack.distribution = .fillEqually
    }
    
    func generate16Buttons() {
        // Обновление массива кнопок после каждой генерации
        self.buttonsArray = []
        // Объявление стеков
        let mainStack = UIStackView()
        let stackHorizontal1 = UIStackView()
        let stackHorizontal2 = UIStackView()
        let stackHorizontal3 = UIStackView()
        let stackHorizontal4 = UIStackView()
        // Добавление стеков на экран
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(stackHorizontal1)
        mainStack.addArrangedSubview(stackHorizontal2)
        mainStack.addArrangedSubview(stackHorizontal3)
        mainStack.addArrangedSubview(stackHorizontal4)
        // Задаем направление стека
        mainStack.axis = .vertical
        stackHorizontal1.axis = .horizontal
        stackHorizontal2.axis = .horizontal
        stackHorizontal3.axis = .horizontal
        stackHorizontal4.axis = .horizontal
        // Задаем отступы
        let spacing: CGFloat = 20
        mainStack.spacing = spacing
        stackHorizontal1.spacing = spacing
        stackHorizontal2.spacing = spacing
        stackHorizontal3.spacing = spacing
        stackHorizontal4.spacing = spacing
        // Задаем размер отступа от левого и правого краев
        let marginWidth: CGFloat = 40
        // Задаем размер кнопок
        let buttonSize: CGFloat = 100
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontal1.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontal2.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontal3.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontal4.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            mainStack.widthAnchor.constraint(equalTo: mainStack.heightAnchor),
            mainStack.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: marginWidth),
            //mainStack.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -marginWidth),
        ])
        
        // Задаем все возможные параметры в цикле
        for i in 0..<currentIntSize {
            let button = UIButton()
            button.addTarget(self, action: #selector(playAudio(_:)), for: .touchUpInside)
            button.backgroundColor = .black
            // Установите желаемый размер кнопки
                // button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.tag = i
            view.addSubview(button)
            self.buttonsArray.append(button)
            
        }
        stackHorizontal1.addArrangedSubview(buttonsArray[0])
        stackHorizontal1.addArrangedSubview(buttonsArray[1])
        stackHorizontal1.addArrangedSubview(buttonsArray[2])
        stackHorizontal1.addArrangedSubview(buttonsArray[3])

        stackHorizontal2.addArrangedSubview(buttonsArray[4])
        stackHorizontal2.addArrangedSubview(buttonsArray[5])
        stackHorizontal2.addArrangedSubview(buttonsArray[6])
        stackHorizontal2.addArrangedSubview(buttonsArray[7])
        
        stackHorizontal3.addArrangedSubview(buttonsArray[8])
        stackHorizontal3.addArrangedSubview(buttonsArray[9])
        stackHorizontal3.addArrangedSubview(buttonsArray[10])
        stackHorizontal3.addArrangedSubview(buttonsArray[11])
        
        stackHorizontal4.addArrangedSubview(buttonsArray[12])
        stackHorizontal4.addArrangedSubview(buttonsArray[13])
        stackHorizontal4.addArrangedSubview(buttonsArray[14])
        stackHorizontal4.addArrangedSubview(buttonsArray[15])
        
        stackHorizontal1.distribution = .fillEqually
        stackHorizontal2.distribution = .fillEqually
        stackHorizontal3.distribution = .fillEqually
        stackHorizontal4.distribution = .fillEqually
        
        stackHorizontal1.alignment = .center
        stackHorizontal2.alignment = .center
        stackHorizontal3.alignment = .center
        stackHorizontal4.alignment = .center
        mainStack.distribution = .fillEqually
    }
    
    func setPlaylist() {
        // Заполняем массив аудиофайлами из папки проекта с расширением wav
        if let musicFolderPath = Bundle.main.resourcePath {
            do {
                let files = try FileManager.default.contentsOfDirectory(atPath: musicFolderPath)
                for file in files {
                    if file.lowercased().hasSuffix(".mp3") || file.lowercased().hasSuffix(".wav") {
                        // Добавление аудиофайла в плейлист
                        playlist.append(file)
                    }
                }
            } catch {
                print("Ошибка при обнаружении аудиофайлов: \(error)")
            }
        }
    }
    
    func setCurrentPlaylistDefault() {
        for i in 0..<currentIntSize {
            currentPlaylist.append(playlist[i])
        }
        for i in 0..<currentIntSize {
            if let soundFilePath = Bundle.main.path(forResource: currentPlaylist[i], ofType: nil) {
                let soundFileURL = URL(fileURLWithPath: soundFilePath)
                do {
                    let audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL)
                    audioPlayer.delegate = self
                    audioPlayers.append(audioPlayer)
                } catch {
                    print("Error loading sound: \(error)")
                }
            }
        }
    }
    
    func setTheMusic() {
        for i in 0..<currentIntSize {
            if let soundFilePath = Bundle.main.path(forResource: currentPlaylist[i], ofType: nil) {
                let soundFileURL = URL(fileURLWithPath: soundFilePath)
                do {
                    audioPlayers[i] = try AVAudioPlayer(contentsOf: soundFileURL)
                    audioPlayers[i].delegate = self
                } catch {
                    print("Error loading sound: \(error)")
                }
            }
        }
    }
    
    @objc func playAudio(_ sender: UIButton) {
        let audioPlayer = audioPlayers[sender.tag]
        
        if audioPlayer.isPlaying {
            // Если аудио играет, останавливаем его и меняем цвет кнопки
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            sender.backgroundColor = .black
        } else {
            // Воспроизводим аудио и меняем цвет кнопки
            audioPlayer.play()
            sender.backgroundColor = .red
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        for i in 0..<currentIntSize {
            audioPlayers[i].stop()
            buttonsArray[i].backgroundColor = .black
        }
        if segue.identifier == "toEditView" {
            guard let destination = segue.destination as? EditViewController else { return }
            destination.audioPlayers = self.audioPlayers
            destination.playlist = self.playlist
            destination.currentPlaylist = self.currentPlaylist
        }
    }
}

extension DrumViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Обработка завершения воспроизведения
        for i in 0..<audioPlayers.count {
            if player == audioPlayers[i] {
                buttonsArray[i].backgroundColor = .black
                // Воспроизводим трек заново
                player.currentTime = 0
                player.play()
                buttonsArray[i].backgroundColor = .red
            }
        }
    }
}
