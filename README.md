# RAG2 mobile

Flutter app providing remote steering for RAG2 Games (https://rutai.kia.prz.edu.pl)

# Prerequisities

- Android phone with RAG2 mobile app
- Wi-fi connection to the same LAN as computer with browser with RAG2 opened

# Instruction
1. Open http://rutai.kia.prz.edu.pl (not https)
2. Select desired game both in browser and in mobile app
3. In browser, select SOCKET steering method for desired player
4. In browser, in socket menu for player type in the websocket URL displayed in app, then press `Connect`
5. When connection is successfull, app will display a snackbar with unique remote device ID
6. In browser, in socket menu scroll down and press `Start data exchange`
7. Enjoy!
