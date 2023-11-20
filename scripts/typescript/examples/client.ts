import { credentials } from '@grpc/grpc-js';
import { GreenSpaceClient } from './proto/typescript/greenspace/api/v1/mobile_grpc_pb';


const client = new GreenSpaceClient('localhost:50051', credentials.createInsecure());
console.log(client.getAnimals());
