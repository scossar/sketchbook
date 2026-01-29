from pyliblo3 import ServerThread, send, make_method, Address

_server = None
# the address the client is listening on
processing = Address("localhost", 12000)


# starts the server; intended to be run from the REPL with start_listening()
def start_listening(port=9000, verbose=True):
    global _server

    class InteractiveServer(ServerThread):
        @make_method("/complex/save/status", "s")
        def save_status_callback(self, path, args):
            filename = args
            print(f"\u2190 Image saved: {filename}")

        @make_method("/complex/status", "ff")
        def status_callback(self, path, args):
            re, im = args
            print(f"\u2190 Received status update, re: {re}, im: {im}")

        @make_method(None, None)
        def fallback(self, path, args):
            print(f"\u2190 {path} {args}")

    _server = InteractiveServer(port)
    _server.start()
    print(f"Listening on port {port}")


def osc(address, *values):
    print(f"\u2192 {address} {values}")
    send(processing, address, *values)
