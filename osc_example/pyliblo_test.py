from pyliblo3 import send, Address

processing = Address("localhost", 12000)


def osc(address, *values):
    send(processing, address, *values)
