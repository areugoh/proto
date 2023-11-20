// package: hoguera.platform.greenspace.api.v1
// file: greenspace/api/v1/mobile.proto

/* tslint:disable */
/* eslint-disable */

import * as grpc from "@grpc/grpc-js";
import * as greenspace_api_v1_mobile_pb from "../../../greenspace/api/v1/mobile_pb";
import * as google_protobuf_empty_pb from "google-protobuf/google/protobuf/empty_pb";

interface IGreenSpaceService extends grpc.ServiceDefinition<grpc.UntypedServiceImplementation> {
    getAnimals: IGreenSpaceService_IGetAnimals;
    getCoast: IGreenSpaceService_IGetCoast;
    getLocation: IGreenSpaceService_IGetLocation;
    getV1: IGreenSpaceService_IGetV1;
}

interface IGreenSpaceService_IGetAnimals extends grpc.MethodDefinition<greenspace_api_v1_mobile_pb.AnimalsRequest, greenspace_api_v1_mobile_pb.Animal> {
    path: "/hoguera.platform.greenspace.api.v1.GreenSpace/GetAnimals";
    requestStream: false;
    responseStream: true;
    requestSerialize: grpc.serialize<greenspace_api_v1_mobile_pb.AnimalsRequest>;
    requestDeserialize: grpc.deserialize<greenspace_api_v1_mobile_pb.AnimalsRequest>;
    responseSerialize: grpc.serialize<greenspace_api_v1_mobile_pb.Animal>;
    responseDeserialize: grpc.deserialize<greenspace_api_v1_mobile_pb.Animal>;
}
interface IGreenSpaceService_IGetCoast extends grpc.MethodDefinition<greenspace_api_v1_mobile_pb.CoastRequest, greenspace_api_v1_mobile_pb.CoastResponse> {
    path: "/hoguera.platform.greenspace.api.v1.GreenSpace/GetCoast";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<greenspace_api_v1_mobile_pb.CoastRequest>;
    requestDeserialize: grpc.deserialize<greenspace_api_v1_mobile_pb.CoastRequest>;
    responseSerialize: grpc.serialize<greenspace_api_v1_mobile_pb.CoastResponse>;
    responseDeserialize: grpc.deserialize<greenspace_api_v1_mobile_pb.CoastResponse>;
}
interface IGreenSpaceService_IGetLocation extends grpc.MethodDefinition<greenspace_api_v1_mobile_pb.LocationRequest, greenspace_api_v1_mobile_pb.LocationResponse> {
    path: "/hoguera.platform.greenspace.api.v1.GreenSpace/GetLocation";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<greenspace_api_v1_mobile_pb.LocationRequest>;
    requestDeserialize: grpc.deserialize<greenspace_api_v1_mobile_pb.LocationRequest>;
    responseSerialize: grpc.serialize<greenspace_api_v1_mobile_pb.LocationResponse>;
    responseDeserialize: grpc.deserialize<greenspace_api_v1_mobile_pb.LocationResponse>;
}
interface IGreenSpaceService_IGetV1 extends grpc.MethodDefinition<google_protobuf_empty_pb.Empty, greenspace_api_v1_mobile_pb.V1Response> {
    path: "/hoguera.platform.greenspace.api.v1.GreenSpace/GetV1";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<google_protobuf_empty_pb.Empty>;
    requestDeserialize: grpc.deserialize<google_protobuf_empty_pb.Empty>;
    responseSerialize: grpc.serialize<greenspace_api_v1_mobile_pb.V1Response>;
    responseDeserialize: grpc.deserialize<greenspace_api_v1_mobile_pb.V1Response>;
}

export const GreenSpaceService: IGreenSpaceService;

export interface IGreenSpaceServer extends grpc.UntypedServiceImplementation {
    getAnimals: grpc.handleServerStreamingCall<greenspace_api_v1_mobile_pb.AnimalsRequest, greenspace_api_v1_mobile_pb.Animal>;
    getCoast: grpc.handleUnaryCall<greenspace_api_v1_mobile_pb.CoastRequest, greenspace_api_v1_mobile_pb.CoastResponse>;
    getLocation: grpc.handleUnaryCall<greenspace_api_v1_mobile_pb.LocationRequest, greenspace_api_v1_mobile_pb.LocationResponse>;
    getV1: grpc.handleUnaryCall<google_protobuf_empty_pb.Empty, greenspace_api_v1_mobile_pb.V1Response>;
}

export interface IGreenSpaceClient {
    getAnimals(request: greenspace_api_v1_mobile_pb.AnimalsRequest, options?: Partial<grpc.CallOptions>): grpc.ClientReadableStream<greenspace_api_v1_mobile_pb.Animal>;
    getAnimals(request: greenspace_api_v1_mobile_pb.AnimalsRequest, metadata?: grpc.Metadata, options?: Partial<grpc.CallOptions>): grpc.ClientReadableStream<greenspace_api_v1_mobile_pb.Animal>;
    getCoast(request: greenspace_api_v1_mobile_pb.CoastRequest, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.CoastResponse) => void): grpc.ClientUnaryCall;
    getCoast(request: greenspace_api_v1_mobile_pb.CoastRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.CoastResponse) => void): grpc.ClientUnaryCall;
    getCoast(request: greenspace_api_v1_mobile_pb.CoastRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.CoastResponse) => void): grpc.ClientUnaryCall;
    getLocation(request: greenspace_api_v1_mobile_pb.LocationRequest, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.LocationResponse) => void): grpc.ClientUnaryCall;
    getLocation(request: greenspace_api_v1_mobile_pb.LocationRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.LocationResponse) => void): grpc.ClientUnaryCall;
    getLocation(request: greenspace_api_v1_mobile_pb.LocationRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.LocationResponse) => void): grpc.ClientUnaryCall;
    getV1(request: google_protobuf_empty_pb.Empty, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.V1Response) => void): grpc.ClientUnaryCall;
    getV1(request: google_protobuf_empty_pb.Empty, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.V1Response) => void): grpc.ClientUnaryCall;
    getV1(request: google_protobuf_empty_pb.Empty, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.V1Response) => void): grpc.ClientUnaryCall;
}

export class GreenSpaceClient extends grpc.Client implements IGreenSpaceClient {
    constructor(address: string, credentials: grpc.ChannelCredentials, options?: Partial<grpc.ClientOptions>);
    public getAnimals(request: greenspace_api_v1_mobile_pb.AnimalsRequest, options?: Partial<grpc.CallOptions>): grpc.ClientReadableStream<greenspace_api_v1_mobile_pb.Animal>;
    public getAnimals(request: greenspace_api_v1_mobile_pb.AnimalsRequest, metadata?: grpc.Metadata, options?: Partial<grpc.CallOptions>): grpc.ClientReadableStream<greenspace_api_v1_mobile_pb.Animal>;
    public getCoast(request: greenspace_api_v1_mobile_pb.CoastRequest, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.CoastResponse) => void): grpc.ClientUnaryCall;
    public getCoast(request: greenspace_api_v1_mobile_pb.CoastRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.CoastResponse) => void): grpc.ClientUnaryCall;
    public getCoast(request: greenspace_api_v1_mobile_pb.CoastRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.CoastResponse) => void): grpc.ClientUnaryCall;
    public getLocation(request: greenspace_api_v1_mobile_pb.LocationRequest, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.LocationResponse) => void): grpc.ClientUnaryCall;
    public getLocation(request: greenspace_api_v1_mobile_pb.LocationRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.LocationResponse) => void): grpc.ClientUnaryCall;
    public getLocation(request: greenspace_api_v1_mobile_pb.LocationRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.LocationResponse) => void): grpc.ClientUnaryCall;
    public getV1(request: google_protobuf_empty_pb.Empty, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.V1Response) => void): grpc.ClientUnaryCall;
    public getV1(request: google_protobuf_empty_pb.Empty, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.V1Response) => void): grpc.ClientUnaryCall;
    public getV1(request: google_protobuf_empty_pb.Empty, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: greenspace_api_v1_mobile_pb.V1Response) => void): grpc.ClientUnaryCall;
}
