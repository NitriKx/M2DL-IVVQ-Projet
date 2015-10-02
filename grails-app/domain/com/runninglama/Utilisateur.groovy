package com.runninglama

import javax.persistence.Transient

class Utilisateur {

    String nom
    String prenom
    String pseudo
    String passwordHash
    String passwordSalt
    Date dateInscription
    Date dateDerniereConnexion
    Date dateNaissance
    String email
    String telephone

    Date dateCreated
    Date lastUpdated

    @Transient
    String motDePasse

    @Transient
    String motDePasseConfirmation

    //static hasMany = [Voiture:lesVoitures]


    static constraints = {
        email email:true
        dateDerniereConnexion nullable: true
        telephone size: 10..10
    }


    @Override
    public String toString() {
        return "Utilisateur{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", pseudo='" + pseudo + '\'' +
                ", passwordHash='" + passwordHash + '\'' +
                ", passwordSalt='" + passwordSalt + '\'' +
                ", dateInscription=" + dateInscription +
                ", dateDerniereConnexion=" + dateDerniereConnexion +
                ", dateNaissance=" + dateNaissance +
                ", email='" + email + '\'' +
                ", telephone='" + telephone + '\'' +
                ", dateCreated=" + dateCreated +
                ", lastUpdated=" + lastUpdated +
                ", version=" + version +
                '}';
    }
}
