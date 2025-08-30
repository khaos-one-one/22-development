preset = 
{
    Channels = 
    {
    }, -- end of Channels
    Squelch = true,
    Step = 25000,
    OutputSD = 5,
    RegulationTime = 0.25,
    Ranges = 
    {
        [1] = 
        {
            minFreq = 30000000,
            maxFreq = 87975000,
			modulation = 1, -- 1 = FM, 0 = AM
        },
    }, -- end of Ranges
    Power = 
    {
        [1] = {value = 10},
    }, -- end of Power
    InputSD = 50,
    Encryption = 
    {
        enable = false,
        key = 1,
        present = false,
    },
    MaxSearchTime = 0,
    FrequencyAccuracy = 1,
    MinSearchTime = 0,
    Guards = 
    {
        [1] = {modulation = 1, freq = 30000000},
    },
    Name = "CNI FM",
    ID = "CNI FM",
    InputSLZ = 10,
    InnerNoise = 1.1561e-06,
    BandWidth = 1,
}