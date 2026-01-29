from pyliblo3 import ServerThread, send, make_method, Address
from rich.console import Console

console = Console()

_server = None
# the address the client is listening on
processing = Address("localhost", 12000)


# starts the server; intended to be run from the REPL with start_listening()
def start_listening(port=9000, verbose=True):
    global _server

    class InteractiveServer(ServerThread):
        @make_method("/complex/product", "ff")
        def status_callback(self, path, args):
            re, im = args
            console.print(f"\u2190 Product, re: {re}, im: {im}")

        @make_method(None, None)
        def fallback(self, path, args):
            console.print(f"\u2190 {path} {args}")

    _server = InteractiveServer(port)
    _server.start()
    console.print(f"Listening on port {port}")


def osc(address, *values):
    console.print(f"\u2192 {address} {values}")
    send(processing, address, *values)
