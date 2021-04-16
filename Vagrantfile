Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64" # officially published image

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = 1024
  end

  config.vm.provision "shell", inline: "DEBIAN_FRONTEND=noninteractive apt-get -qq update"
  config.vm.provision "shell", inline: "DEBIAN_FRONTEND=noninteractive apt-get -qq install python3-pip >/dev/null"
  config.vm.provision "shell", inline: "pip3 install -q --require-hashes -r <(echo 'mnemonic==0.19 --hash=sha256:4e37eb02b2cbd56a0079cabe58a6da93e60e3e4d6e757a586d9f23d96abea931')"
  config.vm.provision "shell", inline: "echo 'To generate a new 12 word seed phrase run \"python3 -c \"from mnemonic import Mnemonic; mnemo = Mnemonic(\\\"english\\\"); print(mnemo.generate(strength=128));\"\"'"
  config.vm.provision "shell", inline: "python3 -c \"from mnemonic import Mnemonic; mnemo = Mnemonic('english'); print(mnemo.generate(strength=128));\""
end
