preset = 
{
    Channels = 
    {
    },
    Squelch = false,
    Step = 5000,
    OutputSD = 5,
    RegulationTime = 0.25,
    Ranges = 
    {
        [1] = 
        {
            minFreq = 190000,
            maxFreq = 1750000,
            modulation = 0, -- AM
        },
    },
    Power = 
    {
        [1] = {value = 5},
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
    Name = "CNI ADF/NDB",
    ID = "CNI ADF/NDB",
    InputSLZ = 10,
    InnerNoise = 1.1561e-06,
    BandWidth = 1,
}