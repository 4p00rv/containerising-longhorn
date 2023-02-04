setup: clean
	docker run -d --rm --name k3s --privileged -p 127.0.0.1:6443:6443 \
		--cap-add=SYS_MODULE \
		-v /:/host \
		-v /home/apoorv/k3d/longhorn/temp:/tmp/longhorn-environment-check:shared \
		-v /home/apoorv/k3d/longhorn/:/var/lib/longhorn:shared \
		local/k3s:new server
	sleep 5
	docker exec -it k3s mount --make-rshared /
	docker exec -it k3s cat /etc/rancher/k3s/k3s.yaml > ~/.kube/config-k3s
	chmod 400 ~/.kube/config-k3s

clean:
	docker rm -f k3s
	rm -f ~/.kube/config-k3s

test:
	docker exec k3s sh -c 'nsenter --mount=/proc/1/ns/mnt --net=/proc/1/ns/net iscsiadm -m discovery -t sendtargets -p 10.42.0.20'
