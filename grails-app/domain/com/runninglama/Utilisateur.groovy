package com.runninglama

class Utilisateur {

    String nom
    String prenon
    String pseudo
    String passwordHash
    String passwordSalt
    Date dateInscription
    Date dateDerniereConnexion
    Date dateNaissance
    String email
    String telephone


    static constraints = {
        email email:true
        dateDerniereConnexion nullable: true
        telephone size: 10..10
    }
}
