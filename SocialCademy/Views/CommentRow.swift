//
//  CommentRow.swift
//  SocialCademy
//
//  Created by Michał Gerlach on 06/11/2022.
//

import SwiftUI

struct CommentRow: View {
    // ------------- Variables ---------------------
    @ObservedObject var viewModel: CommentRowViewModel
    @State private var showConfirmationDialog = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text(viewModel.author.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(viewModel.timestamp.formatted())
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Text(viewModel.content)
                .font(.headline)
                .fontWeight(.regular)
        }
        .padding(5)
        .swipeActions {
            if viewModel.canDeleteComment {
                Button(role: .destructive) {
                    showConfirmationDialog = true
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        .confirmationDialog("Are you sure you want to delete this comment?",
                            isPresented: $showConfirmationDialog, titleVisibility: .visible) {
            Button("Delete", role: .destructive, action: {
                viewModel.deleteComment()
            })
        }
    }
        
}

struct CommentRow_Previews: PreviewProvider {
    static var previews: some View {
        CommentRow(viewModel: CommentRowViewModel(comment: Comment.testComment, deleteAction: {}))
            .previewLayout(.sizeThatFits)
    }
}
