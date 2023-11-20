// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('@grpc/grpc-js');
var greenspace_api_v1_mobile_pb = require('../../../greenspace/api/v1/mobile_pb.js');
var google_api_annotations_pb = require('../../../google/api/annotations_pb.js');
var google_protobuf_empty_pb = require('google-protobuf/google/protobuf/empty_pb.js');

function serialize_google_protobuf_Empty(arg) {
  if (!(arg instanceof google_protobuf_empty_pb.Empty)) {
    throw new Error('Expected argument of type google.protobuf.Empty');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_google_protobuf_Empty(buffer_arg) {
  return google_protobuf_empty_pb.Empty.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_hoguera_platform_greenspace_api_v1_Animal(arg) {
  if (!(arg instanceof greenspace_api_v1_mobile_pb.Animal)) {
    throw new Error('Expected argument of type hoguera.platform.greenspace.api.v1.Animal');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_hoguera_platform_greenspace_api_v1_Animal(buffer_arg) {
  return greenspace_api_v1_mobile_pb.Animal.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_hoguera_platform_greenspace_api_v1_AnimalsRequest(arg) {
  if (!(arg instanceof greenspace_api_v1_mobile_pb.AnimalsRequest)) {
    throw new Error('Expected argument of type hoguera.platform.greenspace.api.v1.AnimalsRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_hoguera_platform_greenspace_api_v1_AnimalsRequest(buffer_arg) {
  return greenspace_api_v1_mobile_pb.AnimalsRequest.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_hoguera_platform_greenspace_api_v1_CoastRequest(arg) {
  if (!(arg instanceof greenspace_api_v1_mobile_pb.CoastRequest)) {
    throw new Error('Expected argument of type hoguera.platform.greenspace.api.v1.CoastRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_hoguera_platform_greenspace_api_v1_CoastRequest(buffer_arg) {
  return greenspace_api_v1_mobile_pb.CoastRequest.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_hoguera_platform_greenspace_api_v1_CoastResponse(arg) {
  if (!(arg instanceof greenspace_api_v1_mobile_pb.CoastResponse)) {
    throw new Error('Expected argument of type hoguera.platform.greenspace.api.v1.CoastResponse');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_hoguera_platform_greenspace_api_v1_CoastResponse(buffer_arg) {
  return greenspace_api_v1_mobile_pb.CoastResponse.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_hoguera_platform_greenspace_api_v1_LocationRequest(arg) {
  if (!(arg instanceof greenspace_api_v1_mobile_pb.LocationRequest)) {
    throw new Error('Expected argument of type hoguera.platform.greenspace.api.v1.LocationRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_hoguera_platform_greenspace_api_v1_LocationRequest(buffer_arg) {
  return greenspace_api_v1_mobile_pb.LocationRequest.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_hoguera_platform_greenspace_api_v1_LocationResponse(arg) {
  if (!(arg instanceof greenspace_api_v1_mobile_pb.LocationResponse)) {
    throw new Error('Expected argument of type hoguera.platform.greenspace.api.v1.LocationResponse');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_hoguera_platform_greenspace_api_v1_LocationResponse(buffer_arg) {
  return greenspace_api_v1_mobile_pb.LocationResponse.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_hoguera_platform_greenspace_api_v1_V1Response(arg) {
  if (!(arg instanceof greenspace_api_v1_mobile_pb.V1Response)) {
    throw new Error('Expected argument of type hoguera.platform.greenspace.api.v1.V1Response');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_hoguera_platform_greenspace_api_v1_V1Response(buffer_arg) {
  return greenspace_api_v1_mobile_pb.V1Response.deserializeBinary(new Uint8Array(buffer_arg));
}


// GreenSpace is the service that provides all the information for NASA's GreenSpace app.
var GreenSpaceService = exports.GreenSpaceService = {
  // GetAnimals returns the animals that are in danger in the coast as a stream.
getAnimals: {
    path: '/hoguera.platform.greenspace.api.v1.GreenSpace/GetAnimals',
    requestStream: false,
    responseStream: true,
    requestType: greenspace_api_v1_mobile_pb.AnimalsRequest,
    responseType: greenspace_api_v1_mobile_pb.Animal,
    requestSerialize: serialize_hoguera_platform_greenspace_api_v1_AnimalsRequest,
    requestDeserialize: deserialize_hoguera_platform_greenspace_api_v1_AnimalsRequest,
    responseSerialize: serialize_hoguera_platform_greenspace_api_v1_Animal,
    responseDeserialize: deserialize_hoguera_platform_greenspace_api_v1_Animal,
  },
  // GetCoast returns the nearest coast to the user location.
getCoast: {
    path: '/hoguera.platform.greenspace.api.v1.GreenSpace/GetCoast',
    requestStream: false,
    responseStream: false,
    requestType: greenspace_api_v1_mobile_pb.CoastRequest,
    responseType: greenspace_api_v1_mobile_pb.CoastResponse,
    requestSerialize: serialize_hoguera_platform_greenspace_api_v1_CoastRequest,
    requestDeserialize: deserialize_hoguera_platform_greenspace_api_v1_CoastRequest,
    responseSerialize: serialize_hoguera_platform_greenspace_api_v1_CoastResponse,
    responseDeserialize: deserialize_hoguera_platform_greenspace_api_v1_CoastResponse,
  },
  // GetLocation returns the location of the user.
getLocation: {
    path: '/hoguera.platform.greenspace.api.v1.GreenSpace/GetLocation',
    requestStream: false,
    responseStream: false,
    requestType: greenspace_api_v1_mobile_pb.LocationRequest,
    responseType: greenspace_api_v1_mobile_pb.LocationResponse,
    requestSerialize: serialize_hoguera_platform_greenspace_api_v1_LocationRequest,
    requestDeserialize: deserialize_hoguera_platform_greenspace_api_v1_LocationRequest,
    responseSerialize: serialize_hoguera_platform_greenspace_api_v1_LocationResponse,
    responseDeserialize: deserialize_hoguera_platform_greenspace_api_v1_LocationResponse,
  },
  // GetV1 is the BFF endpoint. It returns the location of the user, the nearest coast and the animals in danger.
getV1: {
    path: '/hoguera.platform.greenspace.api.v1.GreenSpace/GetV1',
    requestStream: false,
    responseStream: false,
    requestType: google_protobuf_empty_pb.Empty,
    responseType: greenspace_api_v1_mobile_pb.V1Response,
    requestSerialize: serialize_google_protobuf_Empty,
    requestDeserialize: deserialize_google_protobuf_Empty,
    responseSerialize: serialize_hoguera_platform_greenspace_api_v1_V1Response,
    responseDeserialize: deserialize_hoguera_platform_greenspace_api_v1_V1Response,
  },
};

exports.GreenSpaceClient = grpc.makeGenericClientConstructor(GreenSpaceService);
