//
//  EditableTextList.swift
//  PayoffCenterComponent
//
//  Created by Gabriel Sonkowsky on 10/24/23.
//

import Foundation
import SwiftUI

struct StoryBeat: Identifiable {
    var id = UUID()
    var text: String
    var isScene: Bool
    var tags: Set<String>
}

struct EditableTextList: View {
    @State public var storyBeats: [StoryBeat] = [StoryBeat(text: "", isScene: true, tags: [])]

    var body: some View {
        List {
            ForEach(storyBeats) { beat in
                EditableTextRow(beat: $storyBeats[getIndex(for: beat)])
                    .contextMenu {
                        Button(action: {
                            deleteBeat(beat)
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
            .onMove(perform: moveBeat)
        }
        .listStyle(PlainListStyle())
        .frame(minWidth: 200, idealWidth: 300, maxWidth: .infinity, minHeight: 200, idealHeight: 400, maxHeight: .infinity)
        .toolbar {
            Button(action: {
                addNewBeat()
            }) {
                Label("Add Beat", systemImage: "plus")
            }.keyboardShortcut(.defaultAction)
        }
    }

    func moveBeat(from source: IndexSet, to destination: Int) {
        storyBeats.move(fromOffsets: source, toOffset: destination)
    }

    func addNewBeat() {
        storyBeats.append(StoryBeat(text: "", isScene: true, tags: []))
    }

    func getIndex(for beat: StoryBeat) -> Int {
        if let index = storyBeats.firstIndex(where: { $0.id == beat.id }) {
            return index
        }
        return 0
    }

    func deleteBeat(_ beat: StoryBeat) {
        if let index = storyBeats.firstIndex(where: { $0.id == beat.id }) {
            storyBeats.remove(at: index)
        }
    }
}



struct EditableTextRow: View {
    @Binding var beat: StoryBeat
    enum FocusField: Hashable {
        case field
    }
    
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        TextField("Enter text", text: $beat.text)
            .focused($focusedField, equals: .field)
            .onAppear {self.focusedField = .field}
    }
}

#Preview {
    EditableTextList()
}
