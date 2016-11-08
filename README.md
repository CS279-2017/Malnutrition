#Malnutrition app

The app accepts JSON as input and is able to dynamically generate content based on that input.

1. The structue of the Json should be a bunch of nested objects where each object represents an Item, an Item as of now will take the form of a clickable entry in the table.
  *The text is the text that will be displayed on the table entry
  *The next entry is an array of objects, each one representing another Item, i,e clickable table entry


2. The Items should be of the form {text: "", nextItems: []}, where text is the a string, and nextItems is an array of Items

3. This JSON input can come from a file stored with the app or it can come from a web server. In the second case, we would be able to update the contents of the app.

4. Ideally the webserver would allow someone to enter data in the form of a list, and then translate that to JSON to be outputted to the server, that way the user doesn't have to enter information in JSON format.

Next Steps:
1. Add ability to make notes from all of the items that have been switched on
2. Add ability to add additional comments to each of items
3. Be able to view and edit these notes
4. Save these notes on the phone and have to ability to upload them online

