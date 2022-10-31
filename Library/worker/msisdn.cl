#ifndef NULL
#define NULL 0L
#endif

/*
 * Calculate the hash value for the input string.
 */
void single_hash(uchar *w, int len, unsigned int *hash)
{
    // initialize the input buffer
    unsigned int input_buffer[32];
    for (int i = 0; i < 32; i++) {
        input_buffer[i] = 0;
    }

    // convert the char array to an unsigned integer array
    for (int i = 0; i < len; i += 4) {
        uchar w_3 = ( (i + 3) < len) ? w[i + 3] : 0;
        uchar w_2 = ( (i + 2) < len) ? w[i + 2] : 0;
        uchar w_1 = ( (i + 1) < len) ? w[i + 1] : 0;
        uchar w_0 = ( (i + 0) < len) ? w[i + 0] : 0;

        input_buffer[i / 4] = (w_3 << 24) | (w_2 << 16) | (w_1 << 8) | w_0;
    }

    __private unsigned int hash_priv[8];
    hash_private(input_buffer, len, hash_priv);

    for (int i = 0; i < 8; i++) {
        hash[i] = hash_priv[i];
    }
}

/*
 * Tis kernel calculates the hash value for the input string and outputs
 * the hash value.
 */
kernel void get_single_hash(global uchar *w, global int *len,
global unsigned int *hash)
{
    unsigned int loc_hash[8];
    uchar loc_w[512];

    for (int i = 0; i < *len; i++) {
        loc_w[i] = w[i];
    }

    // get the single hash
    single_hash(loc_w, *len, loc_hash);

    // assign the output
    for (int i=0; i<8; i++) {
        hash[i] = loc_hash[i];
    }
}

/*
 * Convert a number represented as an integer to a array of characters.
 */
void get_msisdn(
    unsigned int msisdn_int,
    uchar * msisdn)
{
    // initialize the output buffer
    uchar msisdn_reverse[10];
    for (int i = 0; i < 10; i++) {
        msisdn_reverse[i] = 48;
    }

    // convert the msisdn_int to a string
    int current_index = 0;
    while (msisdn_int > 0) {
        current_index += 1;
        msisdn_reverse[current_index-1] = (msisdn_int % 10) + 48;
        msisdn_int = msisdn_int / 10;
    }

    // reverse the numbers
    for (int i = 0; i < 10; i++) {
        msisdn[10 - 1 -i]  = msisdn_reverse[i];
    }
}

/*
 * Find a number that matches the hash value
 */
 kernel void find_msisdn(
    global unsigned int *hash,
    global unsigned int *output_candiates_len,
    global unsigned int *output_candiates)
{
    unsigned int current_msisdn = 722252318;
    
    // get the msisdn string representation to hash
    uchar msisdn_str[10];
    get_msisdn(current_msisdn, msisdn_str);

    // get the hash value
    unsigned int loc_hash[8];
    single_hash(msisdn_str, 10, loc_hash);

    // assign the output
    for (int i=0; i<8; i++) {
        hash[i] = loc_hash[i];
    }

    // convert the number to string

    //*output_candiates_len += 1;
    //output_candiates[*output_candiates_len-1] = current_msisdn;
    //output_candiates[get_global_id(0)] = get_global_size(0);
}
