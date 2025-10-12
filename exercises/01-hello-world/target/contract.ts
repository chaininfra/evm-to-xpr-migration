import * as _chain from "as-chain";
import { Contract } from "proton-tsc";

/**
 * HelloWorld Contract - Module 1 of Proton Smart Contract Development Course
 * 
 * This contract demonstrates the fundamentals of Proton smart contract development:
 * - Basic contract structure with decorators
 * - Action implementation with input validation
 * - Error handling and return values
 * - TypeScript integration with WebAssembly
 * 
 * @author Proton Development Team
 * @version 1.0.0
 * @since 2024
 */
@contract
export class HelloWorld extends Contract {
    
    /**
     * Simple greeting action without parameters
     * Demonstrates basic action structure and return values
     * 
     * @returns A welcome message for Proton users
     */
    @action("sayhello")
    sayHello(): string {
        return "Hello, Proton World!";
    }
    
    /**
     * Personalized greeting action with input validation
     * Demonstrates parameter handling, validation, and error management
     * 
     * @param name - User's name (1-50 characters, non-empty)
     * @returns Personalized greeting message
     * @throws Error if name is empty or exceeds 50 characters
     */
    @action("greet")
    greet(name: string): string {
        // Input validation - check for empty string
        if (name.length === 0) {
            throw new Error("Name cannot be empty");
        }
        
        // Input validation - enforce maximum length
        if (name.length > 50) {
            throw new Error("Name too long (max 50 characters)");
        }
        
        // Return formatted greeting with user's name
        return "Hello, " + name + "! Welcome to Proton Network!";
    }
    
    /**
     * Contract information action
     * Provides metadata about the contract for debugging and verification
     * 
     * @returns Contract version and build information
     */
    @action("getinfo")
    getInfo(): string {
        return "HelloWorld Contract v1.0 - Built with Proton-TSC";
    }
}


class sayHelloAction implements _chain.Packer {
    constructor (
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        return size;
    }
}

class greetAction implements _chain.Packer {
    constructor (
        public name: string = "",
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        enc.packString(this.name);
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        this.name = dec.unpackString();
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        size += _chain.Utils.calcPackedStringLength(this.name);
        return size;
    }
}

class getInfoAction implements _chain.Packer {
    constructor (
    ) {
    }

    pack(): u8[] {
        let enc = new _chain.Encoder(this.getSize());
        return enc.getBytes();
    }
    
    unpack(data: u8[]): usize {
        let dec = new _chain.Decoder(data);
        return dec.getPos();
    }

    getSize(): usize {
        let size: usize = 0;
        return size;
    }
}

export function apply(receiver: u64, firstReceiver: u64, action: u64): void {
	const _receiver = new _chain.Name(receiver);
	const _firstReceiver = new _chain.Name(firstReceiver);
	const _action = new _chain.Name(action);

	const mycontract = new HelloWorld(_receiver, _firstReceiver, _action);
	const actionData = _chain.readActionData();

	if (receiver == firstReceiver) {
		if (action == 0xC1BCD54634000000) {//sayhello
            const args = new sayHelloAction();
            args.unpack(actionData);
            const ret_value = mycontract.sayHello();
            let size = 0;
            size += _chain.Utils.calcPackedStringLength(ret_value);
            const enc = new _chain.Encoder(size);
            enc.packString(ret_value);
            _chain.setActionReturnValue(enc.getBytes());
        }
		if (action == 0x65D4AC8000000000) {//greet
            const args = new greetAction();
            args.unpack(actionData);
            const ret_value = mycontract.greet(args.name);
            let size = 0;
            size += _chain.Utils.calcPackedStringLength(ret_value);
            const enc = new _chain.Encoder(size);
            enc.packString(ret_value);
            _chain.setActionReturnValue(enc.getBytes());
        }
		if (action == 0x62B2E9AE80000000) {//getinfo
            const args = new getInfoAction();
            args.unpack(actionData);
            const ret_value = mycontract.getInfo();
            let size = 0;
            size += _chain.Utils.calcPackedStringLength(ret_value);
            const enc = new _chain.Encoder(size);
            enc.packString(ret_value);
            _chain.setActionReturnValue(enc.getBytes());
        }
	}
  
	if (receiver != firstReceiver) {
		
	}
	return;
}
