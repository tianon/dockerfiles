# tianon/qemu

    touch /home/jsmith/hda.qcow2
    docker run -it --rm --device /dev/kvm --name qemu-container -v /home/jsmith/hda.qcow2:/tmp/hda.qcow2 -e QEMU_HDA=/tmp/hda.qcow2 -e QEMU_HDA_SIZE=100G -e QEMU_CPU=4 -e QEMU_RAM=4096 -v /home/jsmith/downloads/debian.iso:/tmp/debian.iso:ro -e QEMU_CDROM=/tmp/debian.iso tianon/qemu
