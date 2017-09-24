# Dummy PSP server
-------------------
This is a quick start UPI PSP server to test with UPI SANDBOX.

[Roda](http://roda.jeremyevans.net/)
[Sequel](http://sequel.jeremyevans.net/)

1. Place the project in your server(make sure your server has a static ip and registered with UPI Sandbox).
2. run following commands from within the project root directory
  1.  Install dependencies
      ```
        bundle install
      ```

  2.  Perform database migrations
      ```
        sequel -m migrations/ sqlite://db/dummy_psp.db
      ```
3. Start the Server
   ```
    thin -R config.ru start
   ```
4. visit psp config page at
   ```
    http://<your-static-ip>:3000/Config
   ```
   finish the configuration

5. start requesting UPI sandbox server
