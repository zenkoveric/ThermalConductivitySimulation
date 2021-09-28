struct ComputeData
{
    float energy;
};

RWStructuredBuffer<ComputeData> data : register(u0);

void TransferEnergy(uint id1, uint id2)
{
    float dTemperature = data[id2].energy - data[id1].energy;
    float dTime = 0.1f;
    float Q = dTemperature * dTime;
    data[id1].energy += Q;
    data[id2].energy -= Q;
}

[numthreads(1, 1, 1)]
void CSMain(uint3 groupID : SV_GroupID)
{
    //int multiplier = 1f;
    for(int i = 0; i < 500-1; i++)
    {
        uint id = 500 * groupID.y + i;
        TransferEnergy(id, id+1);
    }
    // data[groupID].energy += 20.0f;
}