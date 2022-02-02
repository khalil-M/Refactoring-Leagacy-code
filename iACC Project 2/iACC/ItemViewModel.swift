//	
// Copyright © 2022 Essential Developer. All rights reserved.
//

import Foundation

struct ItemViewModel {
    let title: String
    let subtitle: String
    
    init(_ item: Any, longDateStyle: Bool) {
        if let friend = item as? Friend {
            title = friend.name
            subtitle = friend.phone
        } else if let card = item as? Card {
            title = card.number
            subtitle = card.holder
        } else if let transfer = item as? Transfer {
            let numberFormatter = Formatters.number
            numberFormatter.numberStyle = .currency
            numberFormatter.currencyCode = transfer.currencyCode
            
            let amount = numberFormatter.string(from: transfer.amount as NSNumber)!
            title = "\(amount) • \(transfer.description)"
            
            let dateFormatter = Formatters.date
            if longDateStyle {
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .short
                subtitle = "Sent to: \(transfer.recipient) on \(dateFormatter.string(from: transfer.date))"
            } else {
                dateFormatter.dateStyle = .short
                dateFormatter.timeStyle = .short
                subtitle = "Received from: \(transfer.sender) on \(dateFormatter.string(from: transfer.date))"
            }
        } else {
            fatalError("unknown item: \(item)")
        }
    }
}

extension ItemViewModel {
    init(friend: Friend) {
            title = friend.name
            subtitle = friend.phone
    }
}

extension ItemViewModel {
    init(card: Card) {
        title = card.number
        subtitle = card.holder
    }
}

extension ItemViewModel {
init(transfer: Transfer, longDateStyle: Bool) {
        let numberFormatter = Formatters.number
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = transfer.currencyCode
        
        let amount = numberFormatter.string(from: transfer.amount as NSNumber)!
        title = "\(amount) • \(transfer.description)"
        
        let dateFormatter = Formatters.date
        if longDateStyle {
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .short
            subtitle = "Sent to: \(transfer.recipient) on \(dateFormatter.string(from: transfer.date))"
        } else {
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            subtitle = "Received from: \(transfer.sender) on \(dateFormatter.string(from: transfer.date))"
        }
    
    }
}
