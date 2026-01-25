import subprocess


def osc(address, *values):
    args = ["oscsend", "localhost", "12000", address]

    types = ""
    vals = []
    for v in values:
        if isinstance(v, int):
            types += "i"
        elif isinstance(v, float):
            types += "f"
        elif isinstance(v, str):
            types += "s"
        vals.append(str(v))

    args.extend([types] + vals)
    subprocess.run(args)
