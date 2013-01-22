HEAT_DISTRO=F17
HEAT_BIN=heat

HEAT_FLAVOR=m1.large


HEAT_TEMPLATE=mediawiki-swift.yaml
HEAT_CREATE_PARAMS=InstanceType=$(HEAT_FLAVOR);KeyName=heat_key;LinuxDistribution=$(HEAT_DISTRO)


heat-keypair:
	nova keypair-add heat_key > heat_key.priv
	chmod 600 heat_key.priv

heat-secomp:
	nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
	nova secgroup-create ssh "SSH server"
	nova secgroup-add-rule ssh tcp 22 22 0.0.0.0/0
	nova secgroup-create http "HTTP web server"
	nova secgroup-add-rule http tcp 80 80 0.0.0.0/0
	nova secgroup-create https "HTTPS secure web server"
	nova secgroup-add-rule https tcp 443 443 0.0.0.0/0

heat-create:
	$(HEAT_BIN) stack-create teststack --template-file=$(HEAT_TEMPLATE) \
	--parameters="$(HEAT_CREATE_PARAMS)"

heat-all: heat-flavor heat-keypair heat-create
