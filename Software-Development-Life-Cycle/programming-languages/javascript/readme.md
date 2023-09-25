# Javascript
functions will be linked from this file. All the functions are the files with the `*.js` extension in this directory
## Debugging
[nice guide](https://www.techiedelight.com/print-contents-object-javascript/)

### Get content from table

### Extracting data from website
you want to extract some info from a website to save it somewhere, count it or ask ChatGPT to analyze it for you
in this example i filtered by glassdoor Australia reviews

- Select all elements with the specified class names
```javascript
const employeeElements = document.querySelectorAll('.review-details__review-details-module__employee');
const contentElements = document.querySelectorAll('.contentContainer');
// array to store the extracted data
const data = [];
```

#### Loop through elements and extract content
```javascript
for (let i = 0; i < employeeElements.length && i < contentElements.length; i++) {
    const employee = employeeElements[i].textContent;
    const content = contentElements[i].textContent;

    // Create an object for each pair of data
    const entry = {
        employee: employee,
        content: content
    };

    // Push the object to the data array
    data.push(entry);
}
```

#### Format data
```javascript
//  array to JSON
const jsonData = JSON.stringify(data, null, 2);
// Print JSON data
console.log(jsonData);
```


#### Printing objects in the console
MDN recommends using

``` javascript
console.log(JSON.parse(JSON.stringify(obj)))
```

## Resources

[Back to top](#)

[Kiwiki Home](/../../)
