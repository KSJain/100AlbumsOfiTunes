# Nike Spin

This file explains the Nike Spin app and how it  works

<img src="100AlbumsOfiTunes/Images%20for%20GitHub/Spin.GIF" width="400">

## As  per the instructions in the K-Force Task. The app has following key qualities
* It uses Auto Layout - Adaptable to screen sizes on iPhone 11 to iPhone SE in Portrait mode
* It uses proper threading - fetching album art and Album data in background
* Displays good architecture around parsing the API response into model objects to populate UI - using MVVM - unit testable with happy path and edge and corner cases.
* Uses modern Swift Patterns - Diffable Data for example

## As per instructions. The App does NOT
* use story board or nib
* use third party libraries
* use forced unwrap or implicit unrapped optionals

### Expected Behaviour
* On Launch the user sees UITableView with a Large Title **(Screen A)**
* List has *large title and a search bar* to search through the List of Albums
* While the data is being fetched, *spinner* blocks the screen **(Screen B)**
* when the data is acquired, the list shows ONE album per cell
* Tapping on an Album shows the details in a card format with additional information **(Screen C)**
* The detail card featuers a button that takes the user to the Apple Music App for the displayed Album Title **(Screen D)**
* If No albums are present for USA, then a screen displays a message letting user know abou the same **(Screen E)**
* In case some error prevents normal behaviour, a custom alert lets the user know with a friendly message **(Screen F)**

## Key Features
* Reusable **custom components** - label, image, view, button, alert
* **MVVM** - seperating Model from views using View Model
* Continous Integration (**CI**) Unsing Git support in XCode and GitHub for remote
* Album Detail on Navigation Stack, opens as a card with more details
* **Unit Testing** - happy path and oytherwise
* *deep link* album detail to Apple Music App (or in app safari browser view)
* *functional programming* used - filter, map
* **diffable data and snapshot**
* search controller - dynamic animating UI
* empty state UI in case of no response data
* support for *dark mode*
* constants store string constants to avoid stringly errors
* app suppors different country album fetch and number of albums with very less code addition in future
* UI developed in *UI Layout style of apple store* and music app and follows *Apples Human Interface Guidelines*

## Development Style
The app was  developed using a simulation of multi iteration *Scrum development*, with Features split into stories, with unit testing.

* Design Mocks were based on user requirememnts (Screen G and H)
* Architecture was made around API response - Data Modeling - Parsing response into model - Finally using model with MVVM to show info in UI
* List Screen was made with Diffable Data Source (wrt WWDC 2019) - following task guideline requirements of single album per cell with name image and artist info
* Detailed Album View was made in the image of mobile web view of apple music album  - following task guideline requirements with image, album name, artist, genre, release date, copyright and fast app switch (deep link) to music app, 20 point recess from leading, trailing and bottom (assuming, safe area layout guide)

## Image For Reference
### Screen A - Album List
<img src="100AlbumsOfiTunes/Images%20for%20GitHub/ListView.jpeg" width="400">

### Screen B - Loading Screen
<img src="100AlbumsOfiTunes/Images%20for%20GitHub/LoadingSpinner.jpeg" width="400">

### Screen C - Album Details Card
<img src="100AlbumsOfiTunes/Images%20for%20GitHub/AlbumDetailView.jpeg" width="400">

### Screen D - Apple Music App
<img src="100AlbumsOfiTunes/Images%20for%20GitHub/MusicApp.png" width="400">

### Screen E - Empty Album List
<img src="100AlbumsOfiTunes/Images%20for%20GitHub/EmptyScr.PNG" width="400">

### Screen F - Custom Alert
<img src="100AlbumsOfiTunes/Images%20for%20GitHub/Alert.PNG" width="400">

### Screen G - Mock List
<img src="100AlbumsOfiTunes/Images%20for%20GitHub/Scr1.png" width="500">

### Screen H - Mock Detail
<img src="100AlbumsOfiTunes/Images%20for%20GitHub/Scr2.png" width="500">
