# msisdn-sha256-brute

## Assumptions

To reduce the potential search space the following assumptions are based the [Telephone numbers in South Africa](https://en.wikipedia.org/wiki/Telephone_numbers_in_South_Africa) Wikipedia article.

- MSISDN numbers are 10 digits long
- The first digit is always 0
- Cellular numbers are prefixed with 06 - 08.

These assumptions may be to restrictive if traditional land line numbers has been ported to cellular numbers, but this will be a good starting point which can always be extended to 01 - 09 prefixes if required.

## New Virtual Environment

```bash
brew install python3

# create the environment
mkdir $HOME/.venv
python3 -m venv $HOME/.venv/msisdn-sha256-brute

# activate the new environment
source $HOME/.venv/msisdn-sha256-brute/bin/activate

# install the requirements
pip install -r requirements.txt
```
