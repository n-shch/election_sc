#!/usr/bin/python3

from brownie import *


def main():
    return accounts[0].deploy(Election)
