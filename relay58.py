import pexpect
import sys  
import termios
import fcntl
import struct
#import time  
#import os  

#pexpect.spawn will reset the screen size.
s=struct.pack("HHHH",0,0,0,0)
a=struct.unpack('hhhh', fcntl.ioctl(sys.stdout.fileno(), termios.TIOCGWINSZ , s))

user=sys.argv[1]
host=sys.argv[2]
password=sys.argv[3]
machine=sys.argv[4]

def login_period(user,host,password):
	p1 = pexpect.spawn("ssh %s@%s"%(user,host))
	p1.setwinsize(a[0],a[1])
	r1 = p1.expect(["ECDSA host key for your.host.com has changed and you have requested strict checking.","password","yes/no"])
	if r1 ==0:
		p1.interact()
		p2 = pexpect.spawn("sed -i '' '/your.host.com/d' /Users/alen/.ssh/known_hosts")
		p2.setwinsize(a[0],a[1])
		p2.interact()
		return login_period(user,host,password)
	elif r1 ==1:
		p1.sendline(password)
	elif r1==2:
		p1.sendline("yes")
		p1.expect("password")
		p1.sendline(password)
	return p1
p1 = login_period(user,host,password)
p1.expect("Select number:")
p1.sendline("q")
p1.expect("bash")
p1.sendline("kinit")
p1.expect("Password")
p1.sendline(password)
p1.expect("bash")
p1.sendline("ssh work@%s"%machine)
p1.interact()
