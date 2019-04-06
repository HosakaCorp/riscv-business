#!/bin/sh
qemu-system-riscv64 \
    -nographic \
    -machine virt \
    -smp 4 \
    -m 2G \
    -kernel bbl \
    -object rng-random,filename=/dev/urandom,id=rng0 \
    -device virtio-rng-device,rng=rng0 \
    -append "console=ttyS0 ro root=/dev/vda enforcing=0" \
    -device virtio-blk-device,drive=hd0 \
    -drive file=fedora.raw,format=raw,id=hd0 \
    -device virtio-net-device,netdev=usernet \
    -netdev user,id=usernet,hostfwd=tcp::10000-:22
