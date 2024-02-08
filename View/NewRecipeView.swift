//
//  NewRecipeView.swift
//  FStationWorkshops
//
//  Created by Michael Cherniavsky on 21/07/2021.
//
//  TODO: add recipe notes field

import SwiftUI

struct NewRecipeView: View {
    @StateObject var newRecipeData = NewRecipeViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var updateId: String
    
    // Placeholders
    var ingredientsPlaceholder = "Write down ingredients each at new line\n ..."
    var cookingStepsPlaceholder = "1. Step 1 \n    ... ... ... \n    ... ... ...\n2. Step 2 \n    ... ... ... \n3. ........... \n4. ..........."
    var notesPlaceholder = "couple of words from author?"
    var warningsPlaceholder = "special preps or extended cooking time?"
    
    var body: some View {
        
        VStack {
            
            // MARK: - upper header of the file ☁️
            HStack(spacing: 15) {
                
                Button(action: {
                    self.updateId = ""
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("Cancel")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                Spacer(minLength: 0)
                
                if updateId == "" {
                    
                    // Only for New Posts....
                    Button(action: {newRecipeData.picker.toggle()}) {
                        Image(systemName: "photo")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
                
                Button(action: {newRecipeData.post(updateId: updateId, present: presentationMode)}) { // Post Button
                    Text("Post")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
            }
            .padding()
            .opacity(newRecipeData.isPosting ? 0.5 : 1)
            .disabled(newRecipeData.isPosting ? true : false)
            
            // MARK: - body of the file 🩱🧍🏋🏻‍♀️
            
            
//            TextEditor(text: $newRecipeData.postTxt)
//                .cornerRadius(15)
//                .padding()
//                .opacity(newRecipeData.isPosting ? 0.5 : 1)
//                .disabled(newRecipeData.isPosting ? true : false)
            
            Form {
                // MARK: Recipe Name
                Section {
                    TextField("Recipe Name", text: $newRecipeData.recipeName)
                }
                
                // MARK: Servings
                // Additionally, consider asking user to leave some notes on scaling the recipe
                // Either, build a data structure as follows [key: value], where `key is numberOfServings` and `value is number of ingredients for this number of servings`
                // checkout example of custom keyboard here: https://kavsoft.dev/Swift/EmojiKeyboard
                HStack {
                    Text("Servings")
                    Spacer()
                    // FIXME: think how to uplift `Servings Picker` a bit, now its height is too low and not convenient to type in
                    // NOTE: actually there's quite some magic when there a keyboard and picker above
                    // YES, it's seems clumsy, but some occasional user can choose to type in something like "it's great for family meeting of 5"/ that maybe kinda cool
                    PickerTextField(data: newRecipeData.dataForServingsPicker, placeholder: "Optional", selectedIndex: $newRecipeData.selectedServingsIndex)
                }
                

                // MARK: Ingredients section
                Section(header: Text("Ingredients")) {
                    ZStack(alignment: .topLeading) {
                        if newRecipeData.ingredients.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Text(ingredientsPlaceholder).foregroundColor(Color(UIColor.placeholderText)).padding(.top, 8)
                        }
                        
                        TextEditor(text: $newRecipeData.ingredients).padding(.leading, -3)
                    }
                }
                
                // MARK: Cooking steps section
                Section(header: Text("Cooking steps")) {
                    ZStack(alignment: .topLeading) {
                        if newRecipeData.cookingSteps.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Text(cookingStepsPlaceholder).foregroundColor(Color(UIColor.placeholderText)).padding(.top, 8)
                        }
                        
                        TextEditor(text: $newRecipeData.cookingSteps).padding(.leading, -3)
                    }
                }
                
                // MARK: Notes
                ZStack(alignment: .topLeading) {
                    if newRecipeData.notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text(notesPlaceholder).foregroundColor(Color(UIColor.placeholderText)).padding(.top, 8)
                    }
                    
                    TextEditor(text: $newRecipeData.notes).padding(.leading, -3)
                }
                
                // MARK: Warnings
                Section(header: Text("Warnings")) {
                    ZStack(alignment: .topLeading) {
                        if newRecipeData.warnings.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Text(warningsPlaceholder).foregroundColor(Color(UIColor.placeholderText)).padding(.top, 8)
                        }
                        
                        TextEditor(text: $newRecipeData.warnings).padding(.leading, -3)
                        
                    }
                }
                
                // MARK: TODO - ADD NOTES SECTION
            
            }
            // MARK: - Displaying Image if it's selected...
            // FIXME: fix image position into better place on the screen
            if newRecipeData.img_Data.count != 0 {
                
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    
                    Image(uiImage: UIImage(data: newRecipeData.img_Data)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width / 2, height: 150)
                        .cornerRadius(15)
                    
                    // Cancel Button...
                    
                    Button(action: {newRecipeData.img_Data = Data(count: 0)}) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .clipShape(Circle() )
                    }
                }
                .padding()
                .opacity(newRecipeData.isPosting ? 0.5 : 1)
                .disabled(newRecipeData.isPosting ? true : false)
            }
        }
        .background(Color.gray.opacity(0.25).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $newRecipeData.picker, content: {
            
            ImagePicker(picker: $newRecipeData.picker, img_Data: $newRecipeData.img_Data)
        })
    }
}

/*
struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
    }
}
*/
