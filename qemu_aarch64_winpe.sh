#!/bin/bash

qemu-system-aarch64 \
        -M virt \
        -accel tcg,thread=multi \
        -m 4096 \
        -smp 8 \
        -cpu cortex-a710 \
        -serial stdio \
        -device ramfb \
        -device qemu-xhci \
        -device usb-kbd \
        -device usb-tablet \
        -drive file=win11_arm64.qcow2,if=none,id=NVME1 \
        -device nvme,drive=NVME1,serial=nvme-1 \
        -drive file=winpe_arm64.iso,media=cdrom,if=none,id=cdrom -device usb-storage,drive=cdrom \
        -drive file=AAVMF_CODE.ms.fd,format=raw,if=pflash,index=0,readonly=on \
        -drive file=AAVMF_VARS.ms.fd,format=raw,if=pflash,index=1 \
        -net nic,model=virtio \
        -net user,hostfwd=tcp::2222-:22 \
        "$@"
