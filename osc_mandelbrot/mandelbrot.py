import numpy as np
from rich import print
from rich.panel import Panel
from rich import box


def mandelbrot_set(
    real_values: np.ndarray[np.float64],
    imag_values: np.ndarray[np.float64],
    max_iterations: int,
) -> list[int]:
    num_real = len(real_values)
    num_imag = len(imag_values)
    escape_counts = np.full((num_imag, num_real), max_iterations, dtype=int)
    for i, imag in enumerate(imag_values):
        for j, real in enumerate(real_values):
            z = complex(0, 0)
            c = complex(real, imag)

            for iter in range(max_iterations):
                if abs(z) > 2.0:
                    escape_counts[i][j] = iter
                    break
                else:
                    z = z * z + c
    return escape_counts


real = np.linspace(-2, 0.5, 51)
imag = np.linspace(1.25, -1.25, 51)

max_iterations = 220
result = mandelbrot_set(real, imag, max_iterations)


mandelbrot_repr = ""
for row in result:
    row_repr = ""

    for count in row:
        count_str = str(count)
        countstr_len = len(count_str)
        for char in range(3 - countstr_len):
            count_str += " "

        if count == max_iterations:  # allows for setting a specific color for the set
            color_code = count
            style = "bold"
        else:
            color_code = count
            style = "bold"

        # it's convenient that standard terminal color codes can be used:
        count_str = (
            f"[color({color_code}) {style}]{count_str}[/color({color_code}) {style}]"
        )
        row_repr += count_str

    mandelbrot_repr += f"{row_repr}\n"

print(Panel(mandelbrot_repr, title="Mandelbrot set", expand=False, box=box.DOUBLE_EDGE))
