def centered_linspace(center: float, width: float, num: int) -> list[int]:
    result: list[float] = []
    halfWidth: float = width * 0.5
    start: float = center - halfWidth
    print("start: ", start)
    print("end: ", start + width)
    step: float = width / (num - 1)
    for i in range(num):
        result.append(start + i * step)
    return result


def linspace(start: float, end: float, num: int) -> list[float]:
    result: list[float] = []
    if num == 1:
        result.append(start)
        return result
    step = (end - start) / (num - 1)
    for i in range(num):
        result.append(start + i * step)
    return result
