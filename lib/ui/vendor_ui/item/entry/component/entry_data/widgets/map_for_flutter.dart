import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/config/route/route_paths.dart';
import 'package:psxmpc/core/vendor/constant/ps_constants.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/intent_holder/map_pin_call_back_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/intent_holder/map_pin_intent_holder.dart';

class MapForFlutter extends StatefulWidget {
  const MapForFlutter(
      {required this.flutterMapController,
      required this.latLng,
      required this.zoom,
      required this.updateFlutterMap,
      required this.currentPosition,
      required this.addressCurrentLocation,
    //  required this.itemEntryProvider
      });
  final MapController flutterMapController;
  final LatLng latLng;
  final double zoom;
  final Function updateFlutterMap;
  final Position? currentPosition;
  final String? addressCurrentLocation;
 // final ItemEntryProvider? itemEntryProvider;

  @override
  State<MapForFlutter> createState() => _MapForFlutterState();
}

class _MapForFlutterState extends State<MapForFlutter> {
   LatLng? _defaultLatLng;

  @override
  Widget build(BuildContext context) {
     final PsValueHolder valueHolder =Provider.of<PsValueHolder>(context, listen: false);
    _defaultLatLng  = LatLng( double.parse(valueHolder.locationLat!), double.parse( valueHolder.locationLng!));
   
    
    return FlutterMap(
      mapController: widget.flutterMapController,
      options: MapOptions(
          center: _defaultLatLng == LatLng(0.000000,0.000000)
                  ?   LatLng( double.parse(valueHolder.defaultlocationLat!), double.parse( valueHolder.defaultlocationLng!))
                  // :  widget.currentPosition!.latitude.toString() != ''
                  // ?  LatLng( widget.currentPosition!.latitude, widget.currentPosition!.longitude)
                  :   widget.latLng,//LatLng(51.5, -0.09), //LatLng(45.5231, -122.6765),
          zoom: widget.zoom, //10.0,
          onTap: (dynamic tapPosition, LatLng latLngr) async {
                onhandleTap();
          }),
      children: <Widget>[
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        MarkerLayer(markers: <Marker>[
          Marker(
            width: 80.0,
            height: 80.0,
            point:    _defaultLatLng == LatLng(0.000000,0.000000)
                  ?   LatLng( double.parse(valueHolder.defaultlocationLat!), double.parse( valueHolder.defaultlocationLng!))
                  :   widget.latLng,
            builder: (BuildContext ctx) => Container(
              child: IconButton(
                icon: Icon(
                  Icons.location_on,
                  color: PsColors.mainColor,
                ),
                iconSize: 45,
                onPressed: () {
                  onhandleTap();
                },
              ),
            ),
          )
        ])
      ],
    );
  }

  Future<void> onhandleTap()async{
     final PsValueHolder valueHolder =Provider.of<PsValueHolder>(context, listen: false);
                FocusScope.of(context).requestFocus(FocusNode());
            final dynamic result = await Navigator.pushNamed(
                context, RoutePaths.mapPin,
                arguments: MapPinIntentHolder(
                    //itemEntryProvider: widget.itemEntryProvider,
                    flag: PsConst.PIN_MAP,
                    mapLat:  widget.addressCurrentLocation == ''  
                       ?  widget.latLng.latitude.toString() 
                       : valueHolder.isPickUpOnMap!
                       ? widget.latLng.latitude.toString() 
                       :  widget.currentPosition!.latitude.toString(),
                    mapLng: widget.addressCurrentLocation == ''  
                       ? widget.latLng.longitude.toString() 
                       : valueHolder.isPickUpOnMap!
                       ? widget.latLng.longitude.toString()
                      : widget.currentPosition!.longitude.toString(), ));
            if (result != null && result is MapPinCallBackHolder) {
               widget.flutterMapController.move(widget.latLng, widget.zoom);
              widget.updateFlutterMap(result.latLng!.latitude,
                  result.latLng!.longitude, result.address,);
            }
  }
}
