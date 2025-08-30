preset = 
{
    Channels = 
    {
    },
    Squelch = false,
    Step = 25000,
    OutputSD = 5,
    RegulationTime = 0.25,
    Ranges = 
    {
        [1] = 
        {
            minFreq = 108100000,
            maxFreq = 111950000,
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
    Guards = {},
    Name = "CNI ILS",
    ID = "CNI ILS",
    InputSLZ = 10,
    InnerNoise = 1.1561e-06,
    BandWidth = 1,
}