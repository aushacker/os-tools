var http = require('http');

http.createServer(function (req, res) {
    console.log(JSON.stringify(req.headers, null, 2));
    var body = "";
    req.on('readable', function() {
        var chunk = req.read();
        if (chunk != null)
            body += chunk;
    });
    req.on('end', function() {
        console.log(JSON.stringify(JSON.parse(body), null, 2));
        res.writeHead(202);
        res.end();
    });
}).listen(8080);
