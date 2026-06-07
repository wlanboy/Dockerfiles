#!/bin/bash
# Startet einen Memcached Container.
# Memcached ist ein leistungsstarkes, verteiltes In-Memory-Caching-System,
# das häufig zur Beschleunigung dynamischer Webanwendungen eingesetzt wird.
#
# Port:    11211 (Memcached-Binär- und Textprotokoll)
# Image:   memcached:1.6-trixie (Debian 13 Trixie, stabile 1.6-Reihe)
# Verbose: Der Container gibt Cache-Statistiken und Verbindungsinfos auf stdout aus.

docker run --name memcache \
  -d \
  -p 11211:11211 \
  memcached:1.6-trixie \
  memcached -v
