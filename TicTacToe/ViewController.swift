//
//  ViewController.swift
//  TicTacToe
//
//  Created by DENAZMI on 24/08/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    private enum Turn {
        case NOUGHT
        case CROSS
    }
    
    private var firstTurn: Turn = .NOUGHT
    private var currentTurn: Turn = .CROSS
    
    private let NOUGHT: String = "O"
    private let CROSS: String = "X"
    
    private var board: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    
    private func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    
    
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if fullBoard() {
            resultAlert(title: "Draw")
        } else {
            
        }
    }
    
    private func resultAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { [weak self] _ in
            self?.resetBoard()
        }))
        self.present(alertController, animated: true)
    }
    
    func resetBoard() {
        board.forEach { button in
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        if firstTurn == .NOUGHT {
            firstTurn = .CROSS
            turnLabel.text = CROSS
        }
        
        if firstTurn == .CROSS {
            firstTurn = .NOUGHT
            turnLabel.text = NOUGHT
        }
        
        currentTurn = firstTurn
    }
    
    private func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    private func addToBoard(_ sender: UIButton) {
        
        if sender.title(for: .normal) == nil {
            
            if currentTurn == .NOUGHT {
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = .CROSS
                turnLabel.text = CROSS
                
            } else if currentTurn == .CROSS {
                sender.setTitle(CROSS, for: .normal)
                currentTurn = .NOUGHT
                turnLabel.text = NOUGHT
            }
            
            sender.isEnabled = false
        }
    }
}

