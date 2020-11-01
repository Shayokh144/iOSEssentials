# EXC_BAD_ACCESS and KERN_INVALID_ADDRESS

## Cause: 
-> EXC_BAD_ACCESS errors occur when your application attempts to access an object that has already been released. If the issue happened after you converted the project to ARC, then somewhere there is a Zealous release call being made (on behalf of ARC).

### Solved Cases
- **Case 1**
- **Error :** try to access bytes from NSData array using negative index value
- **Solution :** set index validation before using it
