from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from postal.parser import parse_address

app = FastAPI()

class AddressRequest(BaseModel):
    addresses: list[str]

@app.post("/parse")
def parse_addresses(req: AddressRequest):
    results = []
    for addr in req.addresses:
        parsed = parse_address(addr)
        result = {label: value for value, label in parsed}
        result['original'] = addr
        results.append(result)
    return results