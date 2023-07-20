import os
from http.server import HTTPServer, BaseHTTPRequestHandler

class MyHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/':
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            with open('webcode/webcode.html', 'rb') as file:
                self.wfile.write(file.read())
        else:
            self.send_response(404)
            self.send_header('Content-type', 'text/plain')
            self.end_headers()
            self.wfile.write(b'File not found')

port = 8080

with HTTPServer((os.environ['PUBLICIP'], port), MyHandler) as httpd:
    print("Server started at localhost:" + str(port))
    httpd.serve_forever()



