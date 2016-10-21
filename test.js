var path = require('path');
var Tesseract = require('tesseract.js');
var image = path.resolve(__dirname, 'pp4.jpg');

Tesseract.recognize(image, {'lang': 'dol'})
    .then(data => {
        console.log('then\n', data.text)
    })
    .catch(err => {
      console.log('catch\n', err);
    })
    .finally(e => {
      console.log('finally\n');
    });