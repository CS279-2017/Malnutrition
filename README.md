#Malnutrition app

##TODO:
* Mohaimin
    * 
* Bowen
    * Add backend that edits JSON and sends it to the app on request
    * Add References and Assessment screens to app
    * Add ability to add additional comments to each of items



#COMPLETED: 
* ~Make a cell for Notes~
* ~make sure images can be loaded from http:// urls in addition to https://~
* ~Be able to view and edit these notes~


##Description:
The app accepts JSON as input and is able to dynamically generate content based on that input.

1. The structue of the Json should be a bunch of nested objects where each object represents an Item, an Item as of now will take the form of a clickable entry in the table.

2. The Items should be of the form {"type": "", "title": "", "description": " ", images [], "nextItems": [], options: []}, where text is the a string, and nextItems is an array of Items
  * type can have the values "Root", "Symptom", "Body Part", "Action", "Question", "Body Diagram",
  * title is the title of the item
  * description is a description of what the item is
  * images is an array of strings, each string being the filename of an image
  * nextItems is an array of other Items

3. This JSON input can come from a file stored with the app or it can come from a web server. In the second case, we would be able to update the contents of the app.

4. Ideally the webserver would allow someone to enter data in the form of a list, and then translate that to JSON to be outputted to the server, that way the user doesn't have to enter information in JSON format.

  2.   4. Save these notes on the phone and have to ability to upload them online

Current JSON: {“title”: “HEENT”, “type”: “Body Region”, “description”: “null”, “nextItems”:
[{“title”: “Hair brittleness”, “description”: “hair could be brittle or breaks off easily”, “images”: [], "nextItems": }]
