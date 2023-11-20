// package: hoguera.platform.greenspace.api.v1
// file: greenspace/api/v1/mobile.proto

/* tslint:disable */
/* eslint-disable */

import * as jspb from "google-protobuf";
import * as google_protobuf_empty_pb from "google-protobuf/google/protobuf/empty_pb";

export class LocationResponse extends jspb.Message { 
    getLongitude(): number;
    setLongitude(value: number): LocationResponse;
    getLatitude(): number;
    setLatitude(value: number): LocationResponse;
    getName(): string;
    setName(value: string): LocationResponse;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): LocationResponse.AsObject;
    static toObject(includeInstance: boolean, msg: LocationResponse): LocationResponse.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: LocationResponse, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): LocationResponse;
    static deserializeBinaryFromReader(message: LocationResponse, reader: jspb.BinaryReader): LocationResponse;
}

export namespace LocationResponse {
    export type AsObject = {
        longitude: number,
        latitude: number,
        name: string,
    }
}

export class LocationRequest extends jspb.Message { 
    getIp(): string;
    setIp(value: string): LocationRequest;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): LocationRequest.AsObject;
    static toObject(includeInstance: boolean, msg: LocationRequest): LocationRequest.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: LocationRequest, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): LocationRequest;
    static deserializeBinaryFromReader(message: LocationRequest, reader: jspb.BinaryReader): LocationRequest;
}

export namespace LocationRequest {
    export type AsObject = {
        ip: string,
    }
}

export class CoastRequest extends jspb.Message { 

    hasLocation(): boolean;
    clearLocation(): void;
    getLocation(): LocationResponse | undefined;
    setLocation(value?: LocationResponse): CoastRequest;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): CoastRequest.AsObject;
    static toObject(includeInstance: boolean, msg: CoastRequest): CoastRequest.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: CoastRequest, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): CoastRequest;
    static deserializeBinaryFromReader(message: CoastRequest, reader: jspb.BinaryReader): CoastRequest;
}

export namespace CoastRequest {
    export type AsObject = {
        location?: LocationResponse.AsObject,
    }
}

export class CoastResponse extends jspb.Message { 
    getName(): string;
    setName(value: string): CoastResponse;
    getCondition(): Condition;
    setCondition(value: Condition): CoastResponse;
    getTemperature(): number;
    setTemperature(value: number): CoastResponse;
    getDistance(): number;
    setDistance(value: number): CoastResponse;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): CoastResponse.AsObject;
    static toObject(includeInstance: boolean, msg: CoastResponse): CoastResponse.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: CoastResponse, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): CoastResponse;
    static deserializeBinaryFromReader(message: CoastResponse, reader: jspb.BinaryReader): CoastResponse;
}

export namespace CoastResponse {
    export type AsObject = {
        name: string,
        condition: Condition,
        temperature: number,
        distance: number,
    }
}

export class Animal extends jspb.Message { 
    getName(): string;
    setName(value: string): Animal;
    getInDanger(): boolean;
    setInDanger(value: boolean): Animal;
    getDescription(): string;
    setDescription(value: string): Animal;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): Animal.AsObject;
    static toObject(includeInstance: boolean, msg: Animal): Animal.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: Animal, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): Animal;
    static deserializeBinaryFromReader(message: Animal, reader: jspb.BinaryReader): Animal;
}

export namespace Animal {
    export type AsObject = {
        name: string,
        inDanger: boolean,
        description: string,
    }
}

export class AnimalsRequest extends jspb.Message { 

    hasLocation(): boolean;
    clearLocation(): void;
    getLocation(): LocationResponse | undefined;
    setLocation(value?: LocationResponse): AnimalsRequest;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): AnimalsRequest.AsObject;
    static toObject(includeInstance: boolean, msg: AnimalsRequest): AnimalsRequest.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: AnimalsRequest, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): AnimalsRequest;
    static deserializeBinaryFromReader(message: AnimalsRequest, reader: jspb.BinaryReader): AnimalsRequest;
}

export namespace AnimalsRequest {
    export type AsObject = {
        location?: LocationResponse.AsObject,
    }
}

export class V1Response extends jspb.Message { 

    hasLocation(): boolean;
    clearLocation(): void;
    getLocation(): LocationResponse | undefined;
    setLocation(value?: LocationResponse): V1Response;

    hasNearestAquaticLocation(): boolean;
    clearNearestAquaticLocation(): void;
    getNearestAquaticLocation(): CoastResponse | undefined;
    setNearestAquaticLocation(value?: CoastResponse): V1Response;
    clearAnimalsList(): void;
    getAnimalsList(): Array<Animal>;
    setAnimalsList(value: Array<Animal>): V1Response;
    addAnimals(value?: Animal, index?: number): Animal;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): V1Response.AsObject;
    static toObject(includeInstance: boolean, msg: V1Response): V1Response.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: V1Response, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): V1Response;
    static deserializeBinaryFromReader(message: V1Response, reader: jspb.BinaryReader): V1Response;
}

export namespace V1Response {
    export type AsObject = {
        location?: LocationResponse.AsObject,
        nearestAquaticLocation?: CoastResponse.AsObject,
        animalsList: Array<Animal.AsObject>,
    }
}

export enum Condition {
    GOOD = 0,
    MODERATE = 1,
    CONTAMINATED = 2,
    UNKNOWN = 3,
    RADIATION = 4,
    DANGER = 5,
    PROTECTED = 6,
}
