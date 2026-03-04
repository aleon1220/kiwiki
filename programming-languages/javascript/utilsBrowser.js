function extractContentToTextarea(tdElementID) {
  // Select the specific <td> by its id
  let tdElement = document.getElementById(tdElementID);

  // Check if the element exists
  if (tdElement) {
      // Get the content from the <td> and remove unnecessary empty lines
      let contentString = tdElement.textContent.trim().replace(/\n\s*\n/g, '\n');

      // Create a container for the textarea and buttons
      let container = document.createElement('div');
      container.style.position = 'fixed';
      container.style.top = '0';
      container.style.left = '0';
      container.style.zIndex = '1000'; // Ensure it appears above other elements
      container.style.backgroundColor = '#f9f9f9';
      container.style.border = '1px solid #ccc';
      container.style.padding = '10px';

      // Create the textarea
      let textarea = document.createElement('textarea');
      textarea.value = contentString;
      textarea.rows = 10;
      textarea.cols = 50;
      container.appendChild(textarea);

      // Create the Minimize/Maximize button
      let minimizeMaximizeButton = document.createElement('button');
      minimizeMaximizeButton.textContent = 'Minimize';
      minimizeMaximizeButton.onclick = function() {
          if (textarea.style.display === 'none') {
              textarea.style.display = '';
              minimizeMaximizeButton.textContent = 'Minimize';
          } else {
              textarea.style.display = 'none';
              minimizeMaximizeButton.textContent = 'Maximize';
          }
      };
      container.appendChild(minimizeMaximizeButton);

      let closeButton = document.createElement('button');
      closeButton.textContent = 'Close';
      const icon = document.createElement('i');
      icon.classList.add('fas');
      icon.classList.add('fa-home');      
      closeButton.appendChild(icon);
      closeButton.onclick = function() {
          document.body.removeChild(container);
      };
      container.appendChild(closeButton);

      let copyButton = document.createElement('button');
      copyButton.textContent = 'Copy';
      copyButton.onclick = function() {
          textarea.select();
          document.execCommand('copy');
      };
      container.appendChild(copyButton);

      let clearButton = document.createElement('button');
      clearButton.textContent = 'Clear';
      clearButton.onclick = function() {
          textarea.value = '';
      };
      container.appendChild(clearButton);

      // Append the container to the body
      document.body.appendChild(container);
  } else {
      console.log('Element with the specified id not found.');
  }
}

// Example usage:
// extractContentToTextarea('m_4025445596395289134layout_table_128de493cc6ff3045c1dbb7fa5260e2d5240d8c6');