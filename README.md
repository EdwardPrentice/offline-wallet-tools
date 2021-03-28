# Goals
Make non-hardware wallets safer. Where you can, use a hardware wallet. However, when a hardware wallet isn't what you want, you still need to be as secure as you can be. This tool helps to teach and provide a way for people to be as safe as possible when not using hardware wallets and provides a way to backup hardware wallet seed phrases. Even with a hardware wallet it's important that the seed phrase is kept safe.


## A tool for generating and encrypting 12 word seed phrases offline

Requires [Virtual Box](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/). This will act as a 'clean room' which will be the only place we handle our key material.

This Vagrant box is built to be used offline to perform a couple of very simple functions. Things this machine can do:

* Generate a new 12 or 24 word seed phrase
* Encrypt a file with AES256 symmetric encryption
* Decrypt a file that is AES256 encrypted

### Usage
This virtual machine is good for generating a new 12 word seed phrase offline and encrypting it before storing it on the host. It's really very simple, but let's see exactly the commands to use:

```
  vagrant up
  
  # At this point, you should disable your connection to the internet
  
  vagrant ssh
  python3 -c "from mnemonic import Mnemonic; mnemo = Mnemonic('english'); words = mnemo.generate(strength=128); print(words);" > new-wallet.txt
  /vagrant/encrypt.sh new-wallet.txt
  # always test you can decrypt it again
  /vagrant/decrypt.sh new-wallet.txt.gpg > decrypted.txt
  # This is when to make a paper copy. So very very carefully transcribe the words to a piece of paper.
  rm decrypted.txt
  md5sum new-wallet.txt.gpg # shows us the md5 hash of the file
  cp new-wallet.txt.gpg /vagrant/
  exit # leave vagrant machine
  
  # you've now produced new-wallet.txt.gpg in the local directory, let's check by looking at the hash again
  md5 new-wallet.txt.gpg
  # At this point if everything has worked, you've created a 'safe room' environment, in which you've carefully crafted a new seed phrase, encrypted it and exported it out to the outside world, in two forms, a plain text paper copy and an encrypted file.
  vagrant destroy -f # before reconnecting to the internet, destroy the virtual machine. If any nefarious software inside the virtual machine captured the seed you generated we need to destroy it before it has the ability to send it anywhere.
  
  # Reconnect to the internet. We're done 🍻
```

You can now store the encrypted file in Dropbox, Google Drive or similar. Ensure it is stored on multiple devices and multiple locations.

### Why is this useful?

Firstly, nothing is better than a hardware wallet. However, even with a hardware wallet, you need to backup your 12 word seed phrase. There are several approachs to this ranging from [memory techniques](https://blog.trezor.io/how-to-memorize-a-seed-phrase-building-narratives-from-nonsense-a306e48dfb39) to the [3 2 1 rule](https://en.wikipedia.org/wiki/Backup#Storage) and likely all kinds of other approaches.

The approach I use to secure my seed phrase is to maintain at least 1 paper copy of the seed phrase and many encrypted, digital copies of the seed phrase. This provides me with the level of security and redundancy I feel most comfortable with. 


#### Scenarios this accommodates for

* The paper copy is destroyed through fire, flooding, etc
* I unknowingly corrupt my digital copy
* I forget my password to decrypt my digital copy
* Any software package inside the Virtual Machine starts being naughty and attempts to send information "home" over the internet

#### Scenarios this does not accommodate

* The host laptop is compromised. In that case, it's game over. Only do this on a machine you trust. If you have the budget, buy a whole separate 'clean' piece of hardware and keep it offline as much as possible with a minimal amount of software on it.
* [Wrenches](https://xkcd.com/538/)
* A catastrophe that involves the paper copy(ies) being destroyed and an inability to access the digital copy.

I like to know that I have at least one level of redundancy and duplicating the paper copy to other locations is simple enough. If the paper copy is destroyed and I'm unable to decrypt the digital copy then my funds are lost.

Therefore, after setting up a new hardware wallet I want to **very meticulously** encrypt the seed phrase so that I can safely store it in my cloud storage.


#### How safe is the encryption?

If the encryption has been done properly and the password is strong then the mathematics tells us that no matter how many people have a copy of the encrypted file, it will take [trillions of years to brute force](https://scrambox.com/article/brute-force-aes/). Pretty cool, huh?


Happy hacking!

