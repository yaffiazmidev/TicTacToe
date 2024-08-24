//
//  TicTacToeViewController.swift
//  TicTacToe
//
//  Created by DENAZMI on 25/08/24.
//

import UIKit

class TicTacToeViewController: UIViewController {
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
    
    private let game: Game
    private var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
        // Do any additional setup after loading the view.
    }
    
    init() {
        game = Game(currentPlayer: .nought, board: Board())
        super.init(nibName: "TicTacToeViewController", bundle: Bundle.main)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initBoard() {
        buttons = [a1, a2, a3, b1, b2, b3, c1, c2, c3]
    }
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        guard let index = buttonIndex(for: sender) else { return }
        if game.makeMove(at: index) == true {
            updateBoard(index: index)
            checkGameState()
        }
    }
    
    private func buttonIndex(for button: UIButton) -> Int? {
        return buttons.firstIndex(of: button)
    }
    
    private func updateBoard(index: Int) {
        // Update UI elements based on the game board
        buttons[index].setTitle(game.currentPlayer.symbol, for: .normal)
    }
    
    private func checkGameState() {
        if let winner = game.checkForWin() {
            print(winner)
            showResultAlert(title: winner.rawValue.uppercased())
//            resetBoard()
        } else if game.checkForDraw() == true {
            print("Draw")
            showResultAlert(title: "Draw")
//            resetBoard()
        } else {
            // Switch players and update UI
            if game.currentPlayer == .nought {
                game.currentPlayer = .cross
            } else {
                game.currentPlayer = .nought
            }
        }
    }
    
    private func showResultAlert(title: String) {
//        let message = "\nNoughts \(noughtsScore) \n\nCrosses \(crossesScore)"
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { [weak self] _ in
            self?.resetBoard()
        }))
        
        present(alertController, animated: true)
    }
    
    private func resetBoard() {
        game.board.resetBoard()
        a1.setTitle("", for: .normal)
        a2.setTitle("", for: .normal)
        a3.setTitle("", for: .normal)
        b1.setTitle("", for: .normal)
        b2.setTitle("", for: .normal)
        b3.setTitle("", for: .normal)
        c1.setTitle("", for: .normal)
        c2.setTitle("", for: .normal)
        c3.setTitle("", for: .normal)
    }
}
