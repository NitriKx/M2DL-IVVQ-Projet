<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>
<body>

<div id="myCarousel" class="carousel slide" data-ride="carousel" style="margin-top:20px;">
    <!-- Carousel indicators -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <!-- Wrapper for carousel items -->
    <div class="carousel-inner">
        <div class="item active">
            <img src="http://placehold.it/1200x400?text=Slide+1" alt="slide1">
        </div>
        <div class="item">
            <img src="http://placehold.it/1200x400?text=Slide+2" alt="slide2">
        </div>
        <div class="item">
            <img src="http://placehold.it/1200x400?text=Slide+3" alt="slide3">
        </div>
    </div>
    <!-- Carousel controls -->
    <a class="carousel-control left" href="#myCarousel" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left"></span>
    </a>
    <a class="carousel-control right" href="#myCarousel" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right"></span>
    </a>
</div>

<div class="row" style="margin-top: 20px;">
    <div class="col-md-3">
        <div class="panel panel-default">
            <div class="panel-heading">Les derniers utilisateurs</div>
            <div class="panel-body">
                <ul>
                    <g:each in="${lesDerniersUtilisateurs}">
                        <li>${it.nom} ${it.prenom}</li>
                    </g:each>
                </ul>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">Les derniers trajets</div>
                <div class="panel-body">
                    <ul>
                        <g:each var="trajet" in="${lesTrajets}">
                            <li><g:link controller="trajet" action="voirTrajet" params="[id: trajet.id]">${trajet.depart} -> ${trajet.arrivee}</g:link></li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-9">
        <div class="panel panel-default">
            <div class="panel-heading">Rechercher un trajet</div>
            <div class="row">
                <div class="col-xs-12">
                    <g:form name="formRechercherTrajet" url="[controller:'trajet',action:'rechercherTrajet']">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="panel panel-default" style="min-height: 380px;">
                                    <div class="panel-heading">Informations trajet</div>
                                    <div class="panel-body">
                                        <input type="hidden" name="depart_lat" id="depart_lat">
                                        <input type="hidden" name="depart_lon" id="depart_lon">
                                        <input type="hidden" name="arrive_lat" id="arrive_lat">
                                        <input type="hidden" name="arrive_lon" id="arrive_lon">
                                        <input type="hidden" name="methode" id="methode" value="perso">

                                        <div class="form-group">
                                            <label for="start">Départ</label>
                                            <input class="form-control input-lg" id="start" name="depart_google" type="text" placeholder="">
                                        </div>

                                        <div class="form-group">
                                            <label for="end">Arrivée</label>
                                            <input class="form-control input-lg" id="end" name="arrivee_google" type="text" placeholder="">
                                        </div>

                                        <div class="form-group">
                                            <label>Date aller</label>
                                            <g:datePicker name="dateAller" value="${new Date()}" precision="day"/>
                                        </div>

                                        %{--<div class="form-group">--}%
                                            %{--<label for="boolDateRetour">Retour?</label>--}%
                                            %{--<input class="form-control input-lg" type="checkbox" id="boolDateRetour" name="boolDateRetour" value='false'>--}%
                                        %{--</div>--}%

                                        <div class="form-group">
                                            <label>Date retour</label>
                                            <g:datePicker id="dateRetour" name="dateRetour" value="${new Date()}" precision="day" disabled="true"/>
                                        </div>

                                        <center><button class="btn btn-success btn-lg" id="submitGoogle">Calculer trajet</button></center>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class='map-wrapper' style="height:380px; width: 100%; margin:0; padding:0;">
                                    <div id="map" style="height:100%; width: 100%;">
                                        <p>Veuillez patienter pendant le chargement de la carte...</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="panel panel-default">
                                    <div class="panel-heading">Informations complementaires</div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <label for="prixMax">Prix Max</label>
                                            <input class="form-control input-lg" id="prixMax" name="prixMax" type="number" placeholder="2">
                                        </div>

                                        <div class="form-group">
                                            <label>Note moyenne du conducteur</label>
                                            <input type="checkbox" name="note" value="5"> 5<br>
                                            <input type="checkbox" name="note" value="4"> 4<br>
                                            <input type="checkbox" name="note" value="3"> 3<br>
                                            <input type="checkbox" name="note" value="2"> 2<br>
                                            <input type="checkbox" name="note" value="1"> 1<br>
                                            <input type="checkbox" name="note" value="0"> 0<br>
                                            <input type="checkbox" name="note" value="-1"> Nouveau conducteur<br>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <input type="submit" value="Rechercher le trajet" class="btn btn-primary btn-lg pull-right">
                    </g:form>
                </div>
            </div>

            <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>


            <script type="text/javascript">

                $(document).ready(function() {

//                    $('#boolDateRetour').click(function(e){
//                        if($(this).is(':checked'))
//                        {
//                            $(this).val('true');
//                            $('#dateRetour_day').prop('disabled', false);
//                            $('#dateRetour_month').prop('disabled', false);
//                            $('#dateRetour_year').prop('disabled', false);
//                        }
//                        else
//                        {
//                            $(this).val('false');
//                            $('#dateRetour_day').prop('disabled', true);
//                            $('#dateRetour_month').prop('disabled', true);
//                            $('#dateRetour_year').prop('disabled', true);
//                        }
//                    });

                    var lastResponse;

                    $('#btn_form-trajet').click(function(e) {
                        e.preventDefault();
                        waypts = lastResponse.Tb.waypoints;
                        if(typeof(waypts)!='undefined') {
                            waypts.forEach(lesWaypts);
                        }
                        function lesWaypts(element, index, array) {
                            $('#lesWaypts').append('<input type="hidden" name="lat'+index+'" value="'+element.location.k+'" /> ');
                            $('#lesWaypts').append('<input type="hidden" name="lon'+index+'" value="'+element.location.A+'" /> ');
                            $('#nb_waypts').attr('value', index+1);
                        }

                        $( "#form-trajet" ).submit();

                    });


                    // Auto complete des champs pour la localisation Google maps
                    var options = {
                        types: ['(cities)']
                    };
                    var inputStart = document.getElementById('start');
                    autocompleteStart = new google.maps.places.Autocomplete(inputStart, options);

                    var inputEnd = document.getElementById('end');
                    autocompleteEnd = new google.maps.places.Autocomplete(inputEnd, options);




                    var rendererOptions = {
                        draggable: true
                    };
                    var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);;
                    var directionsService = new google.maps.DirectionsService();
                    var map;

                    var australia = new google.maps.LatLng(-25.274398, 133.775136);

                    function initialize() {

                        var france = new google.maps.LatLng(46.227638, 2.213749);
                        var mapOptions = {
                            zoom:5,
                            center: france
                        }
                        map = new google.maps.Map(document.getElementById('map'), mapOptions);
                        directionsDisplay.setMap(map);

                        google.maps.event.addListener(directionsDisplay, 'directions_changed', function() {
                            computeTotalDistance(directionsDisplay.getDirections());
                        });


                    }


                    $('#selectArrivee').change(calcSelect);
                    $('#selectDepart').change(calcSelect);

                    $('#submitGoogle').click(calcSelectGoogle);

                    function calcSelectGoogle(e) {
                        e.preventDefault();

                        var start = document.getElementById('start').value;
                        var end = document.getElementById('end').value;

                        if(start != "" && end != "") {
                            var request = {
                                origin:start,
                                destination:end,
                                optimizeWaypoints: true,
                                travelMode: google.maps.TravelMode.DRIVING,
                            };

                            directionsService.route(request, function(response, status) {
                                if (status == google.maps.DirectionsStatus.OK) {
                                    directionsDisplay.setDirections(response);
                                }
                            });
                            $('#methode').attr('value', 'google');
                        }

                    }

                    function calcSelect(e) {
                        e.preventDefault();

                        var start = document.getElementById('selectDepart').value;
                        var end = document.getElementById('selectArrivee').value;

                        console.log(start);
                        console.log(end);


                        if(start != 0 && end != 0) {
                            var request = {
                                origin:start,
                                destination:end,
                                optimizeWaypoints: true,
                                travelMode: google.maps.TravelMode.DRIVING,
                            };

                            directionsService.route(request, function(response, status) {
                                if (status == google.maps.DirectionsStatus.OK) {
                                    directionsDisplay.setDirections(response);
                                }
                            });
                            $('#methode').attr('value', 'adresse');
                        }
                    }

                    function computeTotalDistance(response) {
                        console.log(response);
                        dureeSeconde = response.routes[0].legs[0].duration.value;
                        var d = new Date(dureeSeconde * 1000); // js fonctionne en milisecondes
                        var t = [];
                        t.push(d.getHours()-1);
                        t.push(d.getMinutes());
                        duree =  t.join(':');
                        distanceKilometre = response.routes[0].legs[0].distance.value;
                        distance = distanceKilometre / 1000;
                        depart_lat = response.routes[0].legs[0].start_location.k;
                        depart_lon = response.routes[0].legs[0].start_location.A;
                        arrive_lat = response.routes[0].legs[0].end_location.k;
                        arrive_lon = response.routes[0].legs[0].end_location.A;

//                            $('#duree').timepicker('setTime', duree);
                        $('#distance').val(Math.round(distance));
                        $('#depart_lat').attr('value', depart_lat);
                        $('#depart_lon').attr('value', depart_lon);
                        $('#arrive_lat').attr('value', arrive_lat);
                        $('#arrive_lon').attr('value', arrive_lon);

                        lastResponse = response;
                    }

                    google.maps.event.addDomListener(window, 'load', initialize);




                    // Gestion de la MAP
                    var directionsDisplay;

                    var optionsService = {
                        draggable: true
                    };
                    var directionsService = new google.maps.DirectionsService(optionsService);
                    var map;

                    function computeTotalDistance(result) {
                        var total = 0;
                        var myroute = result.routes[0];
                        for (var i = 0; i < myroute.legs.length; i++) {
                            total += myroute.legs[i].distance.value;
                        }
                        total = total / 1000.0;
                        // document.getElementById('total').innerHTML = total + ' km';
                    }



                    function initialize() {
                        directionsDisplay = new google.maps.DirectionsRenderer();
                        var france = new google.maps.LatLng(46.227638, 2.213749);
                        var mapOptions = {
                            zoom:5,
                            center: france
                        }
                        map = new google.maps.Map(document.getElementById('map'), mapOptions);
                        directionsDisplay.setMap(map);

                        google.maps.event.addListener(directionsDisplay, 'directions_changed', function() {
                            computeTotalDistance(directionsDisplay.getDirections());
                        });
                    }

                    //chemin du tracé du futur polyline


                    $('#submitGoogle').click(function(e) {
                        e.preventDefault();
                        var start = document.getElementById('start').value;
                        var end = document.getElementById('end').value;
                        var request = {
                            origin:start,
                            destination:end,
                            optimizeWaypoints: true,
                            travelMode: google.maps.TravelMode.DRIVING,
                        };

                        directionsService.route(request, function(response, status) {
                            if (status == google.maps.DirectionsStatus.OK) {
                                directionsDisplay.setDirections(response);
                                console.log(response);
                                dureeSeconde = response.routes[0].legs[0].duration.value;
                                var d = new Date(dureeSeconde * 1000); // js fonctionne en milisecondes
                                var t = [];
                                t.push(d.getHours()-1);
                                t.push(d.getMinutes());
                                duree =  t.join(':');
                                distanceKilometre = response.routes[0].legs[0].distance.value;
                                distance = distanceKilometre / 1000;
                                depart_lat = response.routes[0].legs[0].start_location.k;
                                depart_lon = response.routes[0].legs[0].start_location.A;
                                arrive_lat = response.routes[0].legs[0].end_location.k;
                                arrive_lon = response.routes[0].legs[0].end_location.A;

                                //$('#duree').timepicker('setTime', duree);
                                $('#distance').val(Math.round(distance));
                                $('#depart_lat').attr('value', depart_lat);
                                $('#depart_lon').attr('value', depart_lon);
                                $('#arrive_lat').attr('value', arrive_lat);
                                $('#arrive_lon').attr('value', arrive_lon);
                                $('#methode').attr('value', 'google');
                            }
                        });
                    });

                    function calcSelect() {
                        var start = document.getElementById('selectDepart').value;
                        var end = document.getElementById('selectArrivee').value;

                        if(start != '0' && end != '0') {
                            var request = {
                                origin:start,
                                destination:end,
                                travelMode: google.maps.TravelMode.DRIVING
                            };

                            directionsService.route(request, function(response, status) {
                                if (status == google.maps.DirectionsStatus.OK) {
                                    directionsDisplay.setDirections(response);
                                    console.log(response);
                                    dureeSeconde = response.routes[0].legs[0].duration.value;
                                    var d = new Date(dureeSeconde * 1000); // js fonctionne en milisecondes
                                    var t = [];
                                    t.push(d.getHours()-1);
                                    t.push(d.getMinutes());
                                    duree =  t.join(':');
                                    distanceKilometre = response.routes[0].legs[0].distance.value;
                                    distance = distanceKilometre / 1000;
                                    depart_lat = response.routes[0].legs[0].start_location.k;
                                    depart_lon = response.routes[0].legs[0].start_location.A;
                                    arrive_lat = response.routes[0].legs[0].end_location.k;
                                    arrive_lon = response.routes[0].legs[0].end_location.A;

                                    //$('#duree').timepicker('setTime', duree);
                                    $('#distance').val(Math.round(distance));
                                    $('#depart_lat').attr('value', depart_lat);
                                    $('#depart_lon').attr('value', depart_lon);
                                    $('#arrive_lat').attr('value', arrive_lat);
                                    $('#arrive_lon').attr('value', arrive_lon);
                                    $('#methode').attr('value', 'adresse');
                                }
                            });
                        }
                    }

                    $('#selectArrivee').change(calcSelect);
                    $('#selectDepart').change(calcSelect);

                    google.maps.event.addDomListener(window, 'load', initialize);

                });
            </script>
        </div>
    </div>
</div>
<script>
    $('.carousel').carousel()
</script>
</body>
</html>
