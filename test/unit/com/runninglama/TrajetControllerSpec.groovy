package com.runninglama


import grails.test.mixin.*
import spock.lang.*

@TestFor(TrajetController)
@Mock(Trajet)
class TrajetControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        params["depart"] = 'Toulouse'
        params["departLat"] = '123.345'
        params["departLng"] = '1.4583'

        params["arrivee"] = 'Muret'
        params["arriveeLat"] = '123.563'
        params["arriveeLng"] = '2.456'

        params["dateAller"] = new Date()
        params["dateRetour"] = new Date()

        params["commentaire"] = 'Un commentaire'
        params["prix"] = 12.5
        params["nombrePlace"] = 4

        params["conducteur"] = Mock(Utilisateur)
        params["vehicule"] = Mock(Vehicule)

    }


    void "Test l'affichage du formulaire d'ajout de trajet"() {
        when: "une demande d'accès au formulaire d'ajout"
        controller.ajouterTrajet()
        then: "l'utilisateur est redirigé sur la page"
        view == '/trajet/ajouter'
        response.status == 200
    }

    void "test l'affichage de la liste des trajet"() {
        when: "une demande d'accès a la liste des trajet"
        controller.liste()
        then: "l'utilisateur est redirigé sur la page"
        view == '/trajet/liste'
        response.status == 200
    }

    void "test l'affichage du recapitulatif d'un trajet"() {
        given: "un trajet sauvegarder en base de données"
        Trajet trajet = Mock(Trajet)
        trajet.id >> 3
        when: "une demande d'accès au récapitulatif d'un trajet"
        controller.voirTrajet(trajet.id)
        then: "l'utilisateur est redirigé sur la page"
        view == '/trajet/voirTrajet/3'
        response.status == 200
    }

    void "test l'affichage du recapitulatif d'un trajet qui n'existe pas"() {
        given: "un trajet sauvegarder en base de données"
        Trajet trajet = Mock(Trajet)
        trajet.id >> null
        when: "une demande d'accès au récapitulatif d'un trajet"
        controller.voirTrajet(trajet.id)
        then: "Un code d'erreur 404 est renvoyé"
        response.status == 404
    }

    void "test la suppression d'un trajet existant"() {
        given: "un trajet sauvegarder en base de données"
        Trajet trajet = TestsHelper.creerTrajetValide();
        trajet.save()

        when: "une demande de suppression"
        controller.supprimer(trajet.id)
        then: "Le service est appelé"
        1*controller.trajetService.delete(_)
    }

    void "test la suppression d'un trajet inexistant"() {
        when: "une demande de suppression sur un trajet qui n'existe pas"
        controller.supprimer(65)
        then: "Le service est n'est pas appelé"
        0*controller.trajetService.delete(_)
    }
}
