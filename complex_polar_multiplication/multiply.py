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
            r, theta = args
            console.print(f"\u2190 Product, r: {r}, theta: {theta}")

        @make_method("/complex/warning", "s")
        def warning_callback(self, path, args):
            warning = args
            console.print(f"\u2190 [red italic]{warning}[/red italic]")

        @make_method(None, None)
        def fallback(self, path, args):
            console.print(f"\u2190 {path} {args}")

    _server = InteractiveServer(port)
    _server.start()
    console.print(f"Listening on port {port}")


def osc(address, *values):
    console.print(f"\u2192 {address} {values}")
    send(processing, address, *values)
