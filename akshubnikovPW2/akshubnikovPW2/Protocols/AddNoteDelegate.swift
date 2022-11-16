//
// Created by Андрей Шубников on 17.11.2022.
//

import Foundation

protocol AddNoteDelegate: AnyObject {
    func newNoteAdded(note: ShortNote)
}
