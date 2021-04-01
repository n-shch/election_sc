#!/usr/bin/python3

from brownie import *


def main():
    return Election.deploy("Alise", 1, {'from': accounts[0]})
