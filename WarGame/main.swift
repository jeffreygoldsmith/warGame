//
//  main.swift
//  WarGame
//
//  Created by Jeffrey on 2016-12-12.
//  Copyright © 2016 Jeffrey. All rights reserved.
//

import Cocoa

// Create an enumeration for the suits of a deck of cards
enum Suit : String {
    
    case hearts     = "❤️"
    case diamonds   = "♦️"
    case spades     = "♠️"
    case clubs      = "♣️"
    
    // Given a value, returns the suit
    static func glyph(forHashValue : Int) -> String {
        switch forHashValue {
        case 0 :
            return Suit.hearts.rawValue
        case 1 :
            return Suit.diamonds.rawValue
        case 2 :
            return Suit.spades.rawValue
        case 3 :
            return Suit.clubs.rawValue
        default:
            return Suit.hearts.rawValue
        }
    }
    
}

// Play with the enumeration a bit to see what it gives us
Suit.hearts.hashValue
Suit.hearts.rawValue

// Create a new datatype to represent a playing card
struct Card {
    
    var value : Int
    var suit : Int
    
    // Initializer accepts arguments to set up this instance of the struct
    init(value : Int, suit : Int) {
        self.value = value
        self.suit = suit
    }
    
}

// Initalize a deck of cards
var deck : [Card] = []
for suit in 0...3 {
    for value in 2...14 {
        var card = Card(value: value, suit: suit)
        deck.append(card)
    }
}

// Iterate over the deck of cards
for card in deck {
    print("Suit is \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
}

// Initialize hands
var playerHand : [Card] = []
var computerHand : [Card] = []

// "Shuffle" the deck and give half the cards to the player
while deck.count != 0
{
    // Generate a random number between 0 and the count of cards still left in the deck
    var position = Int(arc4random_uniform(UInt32(deck.count)))
    
    if deck.count > 26
    {
        // Copy the card in this position to the player's hand
        playerHand.append(deck[position])
    } else {
        // Copy the card in this position to the computer's hand
        computerHand.append(deck[position])
    }
    
    deck.remove(at: position)
}

func draw (startingIndex : Int)
{
    if (playerHand.count < 5)
    {
        playerHand = []
    } else {
        if (computerHand.count < 5)
        {
            computerHand = []
        } else {
            let topPlayerCard = playerHand[startingIndex + 3]
            let topComputerCard = computerHand[startingIndex + 3]
            
            if (topPlayerCard.value > topComputerCard.value)
            {
                for i in 0...3
                {
                    playerHand.append(computerHand[0])
                    computerHand.remove(at: 0)
                }
            } else {
                if (topPlayerCard.value < topComputerCard.value)
                {
                    for i in 0...3
                    {
                        computerHand.append(playerHand[0])
                        playerHand.remove(at: 0)
                    }
                } else {
                    draw(startingIndex: startingIndex + 3)
                }
            }
        }
    }
}


repeat {
    if readLine() != nil && playerHand.count != 0 && computerHand.count != 0
    {
        let topCard = 0
        
        let playerCard = playerHand[topCard]
        let computerCard = computerHand[topCard]
        
        if (playerCard.value > computerCard.value)
        {
            print(playerCard.value)
            print(computerCard.value)
            
            playerHand.append(computerCard)
            computerHand.remove(at: topCard)
            
            playerHand.append(playerCard)
            playerHand.remove(at: topCard)
            
            print("player won this hand")
        } else {
            if (playerCard.value < computerCard.value)
            {
                print(playerCard.value)
                print(computerCard.value)
                
                computerHand.append(computerCard)
                playerHand.remove(at: topCard)
                
                computerHand.append(computerCard)
                computerHand.remove(at: topCard)
                
                print("computer won this hand")
            } else {
                print("equal")
                
                var startingCard = 0
                
                draw(startingIndex: startingCard)
            }
        }
        
        if (computerHand.count == 0)
        {
            print("Player won!")
        } else {
            if (playerHand.count == 0)
            {
                print("Computer won!")
            }
        }
    } else {
        print(playerHand)
        print(computerHand)
    }
} while playerHand.count != 0 && computerHand.count != 0


// Iterate over the player's hand
//print("=====================================")
//print("All cards in the player's hand are...")
//for (value, card) in playerHand.enumerated() {
//    print("Card \(value) in player's hand is a suit of \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
//}
