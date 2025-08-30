preset = 
{
    Channels = 
    {
    },
    Squelch = true,
    Step = 25000,
    OutputSD = 5,
    RegulationTime = 0.25,
    Ranges = 
    {
        [1] = 
        {
            minFreq = 118000000,
            maxFreq = 151975000,
            modulation = 0, -- AM
        },
    },
    Power = 
    {
        [1] = {value = 10},
    },
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
        [1] = {modulation = 0, freq = 121500000},
    },
    Name = "CNI VHF",
    ID = "CNI VHF",
    InputSLZ = 10,
    InnerNoise = 1.1561e-06,
    BandWidth = 1,
}