#!/bin/bash
#

haveLibreOffice="$(docker ps  -a | egrep libreoffice)"

if [[ -z "${haveLibreOffice}" ]]; then
	docker run  --rm \
		--memory="1g" \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v /etc/machine-id:/etc/machine-id:ro \
		-v /home/daniel:/home/daniel:z \
		-e DISPLAY=unix$DISPLAY \
		-h "$(hostname -s)" \
        --net "none" \
		--name libreoffice \
		<username>/f23_libreoffice:5042 $@ &
else
	docker exec libreoffice /usr/bin/libreoffice $@
fi

