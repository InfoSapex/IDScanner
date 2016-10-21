var {app, BrowserWindow} = require('electron');
var http = require('http');
var server = http.createServer().listen(4000);
var io = require('socket.io').listen(server);

var startWindow;

app.on('ready', function () {

    var startWindow = new BrowserWindow({
        width: 650,
        height: 450
    }).on('closed', function(){
        startWindow = null;
    });

    startWindow.loadURL(`file://${__dirname}/index.html`);

});


app.on('window-all-closed', function () {
    app.quit();
    io.httpServer.close();
});

io.sockets.on('connection', function (socket) {
    /*
    socket.on('', function(hotel_key) {
        console.log('leaving room', hotel_key);
        socket.leave(hotel_key);
    });*/
    console.log(socket);

});