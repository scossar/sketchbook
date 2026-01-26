from pyliblo3 import ServerThread, send, make_method, Address
import numpy as np

# Global server instance
_server = None
processing = Address("localhost", 12000)


def start_listening(port=9000, verbose=False):
    global _server

    class InteractiveServer(ServerThread):
        @make_method("/multiply", "ff")
        def multiply_callback(self, path, args):
            f1, f2 = args
            result = f1 * f2
            if verbose:
                print(f"← Received message {path} with args: {f1}, {f2}")
            send(processing, "/product", result)

        @make_method("/mandelbrot", "ff")  # pyright: ignore
        def mandelbrot_callback(self, path, args):
            centerReal, centerImag = args
            if verbose:
                print(f"← Received message {path}")
            iterations = mandelbrot(centerReal, centerImag)
            # blob = struct.pack(f"{len(iterations)}i", *iterations)
            chunk_size = 100
            for i in range(0, len(iterations), chunk_size):
                chunk = iterations[i : i + chunk_size]
                send(processing, "/iterations/chunk", i, chunk)
            send(processing, "/iterations/complete", len(iterations))

        @make_method(None, None)  # pyright: ignore
        def fallback(self, path, args):
            print(f"← {path} {args}")

    _server = InteractiveServer(port)
    _server.start()
    print(f"Listening on port {port}")


def osc(address, *values):
    print(f"→ {address} {values}")
    send(processing, address, *values)


def mandelbrot(centerReal, centerImag):
    realDomain = np.linspace(centerReal - 0.1, centerReal + 0.1, 50)
    # this is upside down
    imaginaryDomain = np.linspace(centerImag - 0.1, centerImag + 0.1, 50)
    iterations = np.zeros((50, 50), dtype=int)
    for i, imag in enumerate(imaginaryDomain):
        for j, real in enumerate(realDomain):
            z = complex(0, 0)
            c = complex(real, imag)

            for iter in range(50):
                if abs(z) > 2.0:
                    iterations[i][j] = iter
                    break
                else:
                    z = z * z + c

    return iterations.flatten().tolist()
