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
