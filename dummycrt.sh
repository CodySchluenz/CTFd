#!/bin/bash
openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out ./ssl/cert.pem -keyout ./ssl/privkey.pem
