[![Packagist](https://img.shields.io/badge/license-MIT-blue.svg)]()
[![Build Status](https://travis-ci.org/UltraDark/ultradark_core.svg?branch=master)](https://travis-ci.org/UltraDark/ultradark_core)
[![Join the chat](https://img.shields.io/badge/chat-on%20gitter-%23ed1965.svg)](https://gitter.im/ultradark/Lobby)

# Elixium
Elixium is a peer-to-peer network and blockchain written in Elixir, aiming to excel where many other blockchains fall short. Elixium provides privacy and anonymity, smart contracting, and high transaction speeds. We're looking for contributors, so pull requests and issues are welcome! If you have any trouble getting set up or just want to join in with
our development discussion, join our [Discord Channel](https://discord.gg/B3fu3Tu). Check out the [Elixium Development Wiki](https://github.com/ElixiumNetwork/elixium_core/wiki) if
you need a reference/starting point for the project.

## Features
Although Elixium is still in early development, we have a rough roadmap of features that are intended to be included. The following list describes features that may or may not be
implemented as of right now:

### 1. Anonymity
  * The Elixium Core Wallet automatically performs a key rotation every 720 blocks (roughly 24 hours) _or_ whenever you receive a transaction, meaning that you are not trackable by public key
  * Using zkSNARKS technology, Elixium is able to ensure that you cannot be identified based on transaction patterns, addresses, or contents.
### 2. Smart Contracts
  * Easily create and deploy smart contracts to facilitate intelligent exchanges of funds
  * Deploy decentralized applications with low fees, running on the Elixium network
### 3. Speed
  * With node response times of roughly 50 microseconds, transaction speeds are **4000x** the speed of Bitcoin
  * Process roughly 20,000 transactions per second
  * 2 minute average blocktime

## Why Elixir?
Blockchain technology in it's current state is written mostly in C or C-like languages, leaving development communities outside of this umbrella of languages
lacking in their support for the technology. By writing a blockchain in Elixir we hope to accomplish a few things:

1. Expand the blockchain development community into new languages and provide a reference to those who are more comfortable in Elixir
2. Take advantages of the insane speed of Elixir to allow for a faster peer-to-peer network.
3. Once again taking advantage of the performance of Elixir, allow for the development of decentralized apps within the Elixir community.

This code is licensed under the MIT License, which means _anyone_ can use it to do _anything_ they want.

## Prerequisites
1. Elixir

## Setup
Run `mix deps.get` to fetch any dependencies needed to run Elixium. After downloading all dependencies, run `mix compile` to compile the Elixir code. Currently,
Elixium is only under development and is unavailable to be used as a network or currency. In order to play around with Elixium and it's methods, run `iex -S mix`. This
will pop open an iex session with Elixium loaded. To start mining Elixium, just run `mix miner` !
