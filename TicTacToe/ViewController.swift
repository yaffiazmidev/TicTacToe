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
    
    private var game: Game?
    private var buttons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(currentPlayer: .nought, board: Board())
        initBoard()
    }
    
    private func initBoard() {
        buttons = [a1, a2, a3, b1, b2, b3, c1, c2, c3]
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        guard let index = buttonIndex(for: sender) else { return }
        if game?.makeMove(at: index) == true {
            updateBoard(index: index)
            checkGameState()
        }
    }
    
    private func buttonIndex(for button: UIButton) -> Int? {
        return buttons.firstIndex(of: button)
    }
    
    private func updateBoard(index: Int) {
        // Update UI elements based on the game board
        buttons[index].setTitle(game?.currentPlayer.symbol, for: .normal)
    }
    
    private func checkGameState() {
        if let winner = game?.checkForWin() {
            print(winner)
            showResultAlert(title: winner.rawValue.uppercased())
        } else if game?.checkForDraw() == true {
            print("Draw")
            showResultAlert(title: "Draw")
        } else {
            // Switch players and update UI
            if game?.currentPlayer == .nought {
                game?.currentPlayer = .cross
            } else {
                game?.currentPlayer = .nought
            }
        }
    }
    
    private func showResultAlert(title: String) {
//        let message = "\nNoughts \(noughtsScore) \n\nCrosses \(crossesScore)"
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { [weak self] _ in
            self?.resetBoard()
        }))
        
        present(alertController, animated: true)
    }
    
    private func resetBoard() {
        game?.board.resetBoard()
        buttons.forEach { button in
            button.setTitle("", for: .normal)
        }
    }
}

class Board {
    var cells: [String] = Array(repeating: "", count: 9)

    func isFull() -> Bool {
        return !cells.contains("")
    }

    func makeMove(at index: Int, symbol: String) -> Bool {
        guard cells[index].isEmpty else { return false }
        cells[index] = symbol
        return true
    }

    func checkForWin(symbol: String) -> Bool {
        let winningCombinations: [(Int, Int, Int)] = [
            // Horizontal
            (0, 1, 2), (3, 4, 5), (6, 7, 8),
            // Vertical
            (0, 3, 6), (1, 4, 7), (2, 5, 8),
            // Diagonal
            (0, 4, 8), (2, 4, 6)
        ]

        return winningCombinations.contains { combination in
            let (i, j, k) = combination
            return cells[i] == symbol && cells[j] == symbol && cells[k] == symbol
        }
    }
    
    func resetBoard() {
        cells = Array(repeating: "", count: 9)
    }
}

class Game {
    enum Player: String {
        case nought, cross

        var symbol: String {
            switch self {
            case .nought:
                return "O"
            case .cross:
                return "X"
            }
        }
    }

    var currentPlayer: Player
    var board: Board
    
    init(currentPlayer: Player, board: Board) {
        self.currentPlayer = currentPlayer
        self.board = board
    }

    func makeMove(at index: Int) -> Bool {
        return board.makeMove(at: index, symbol: currentPlayer.symbol)
    }

    func checkForWin() -> Player? {
        if board.checkForWin(symbol: Player.nought.symbol) {
            return .nought
        } else if board.checkForWin(symbol: Player.cross.symbol) {
            return .cross
        } else {
            return nil
        }
    }

    func checkForDraw() -> Bool {
        return board.isFull() && checkForWin() == nil
    }
}
