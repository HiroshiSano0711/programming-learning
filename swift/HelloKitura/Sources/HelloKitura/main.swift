import Kitura

let router = Router()

router.all("/", middleware: StaticFileServer(path: "./public"))

Kitura.addHTTPServer(onPort: 8888, with: router)
Kitura.run()
