
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64" # officially published image

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = 1024
  end

  config.vm.provision "shell", inline: "DEBIAN_FRONTEND=noninteractive apt-get -qq update"
  config.vm.provision "shell", inline: "DEBIAN_FRONTEND=noninteractive apt-get -qq install python3-pip >/dev/null"
  config.vm.provision "shell", inline: "pip3 -q install mnemonic"
  config.vm.provision "shell", inline: "curl -sfO https://gist.githubusercontent.com/EdwardPrentice/cc49c094bd324aa4156f14a25b0621cb/raw/encrypt.sh && chmod +x encrypt.sh"
  config.vm.provision "shell", inline: "curl -sfO https://gist.githubusercontent.com/EdwardPrentice/38e0f1d9875ca80805504c4c719d90c8/raw/decrypt.sh && chmod +x decrypt.sh"
  config.vm.provision "shell", inline: "python3 -c \"from mnemonic import Mnemonic; mnemo = Mnemonic('english'); print(mnemo.generate(strength=128));\""
end
