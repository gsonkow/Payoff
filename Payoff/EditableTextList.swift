//
//  EditableTextList.swift
//  PayoffCenterComponent
//
//  Created by Gabriel Sonkowsky on 10/24/23.
//
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

struct TagsSidebar: View {
  @Binding var tags: [String]
  @State private var newTag: String = ""
  @Binding var selectedTag: String?
  
  var body: some View {
    VStack {
      // New Tag Input Field with Plus Button
      HStack {
        TextField("New Tag", text: $newTag)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        
        Button(action: {
          if !newTag.isEmpty && !tags.contains(newTag) {
            tags.append(newTag)
            newTag = ""
          }
        }) {
          Image(systemName: "plus.circle.fill")
            .foregroundColor(.blue)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(newTag.isEmpty)
      }
      .padding()
      
      // List of Tags with Bullet Indicators
      List {
        HStack {
          Circle()
            .fill(selectedTag == nil ? Color.blue : Color.clear)
            .frame(width: 10, height: 10)
          Text("All Tags")
        }
        .onTapGesture {
          selectedTag = nil
        }
        
        ForEach(tags, id: \.self) { tag in
          HStack {
            Circle()
              .fill(selectedTag == tag ? Color.blue : Color.clear)
              .frame(width: 10, height: 10)
            Text(tag)
          }
          .onTapGesture {
            selectedTag = tag
          }
        }
      }
    }
  }
}






struct EditableTextList: View {
  @State public var storyBeats: [StoryBeat] = [StoryBeat(text: "", isScene: true, tags: [])]
  @State public var tags: [String] = ["Love Plot", "Action"]
  @State private var selectedTag: String?
  
  
  var body: some View {
    HStack{
      TagsSidebar(tags: $tags, selectedTag: $selectedTag)
        .frame(width: 200)
      List {
        ForEach(filteredStoryBeats) { beat in
          EditableTextRow(beat: $storyBeats[getIndex(for: beat)])
            .contextMenu {
              Button(action: {
                deleteBeat(beat)
              }) {
                Label("Delete", systemImage: "trash")
              }
              Menu("Add Tag") {
                ForEach(tags, id: \.self) { tag in
                  Button(tag) {
                    assignTag(tag, to: beat)
                  }
                }
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
  }
  
  var filteredStoryBeats: [StoryBeat] {
    if let selectedTag = selectedTag {
      return storyBeats.filter { $0.tags.contains(selectedTag) }
    } else {
      return storyBeats
    }
  }
  
  //  METHODS
  
  func assignTag(_ tag: String, to beat: StoryBeat) {
    if let index = storyBeats.firstIndex(where: { $0.id == beat.id }) {
      storyBeats[index].tags.insert(tag)
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
