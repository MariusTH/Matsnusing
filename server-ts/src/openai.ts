import express from 'express';
import bodyParser from 'body-parser';
import axios, { AxiosError } from 'axios';
import cors from 'cors';
import { Configuration, OpenAIApi } from "openai";

const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
});
const openai = new OpenAIApi(configuration);

const app = express();
app.use(cors());
app.use(bodyParser.json());

app.post('/api/completion', async (req, res) => {
    if (!configuration.apiKey) {
        res.status(500).json({
            error: {
                message: "OpenAI API key not configured, please follow instructions in README.md",
            }
        });
        return;
    }
    
    const days = req.body.days || ['mandag'];
    let time = '';
    for(let i = 0; i < days.length; i++) {
        console.log(days);
        time += days[i];
        if(i !== (days.length - 1)) time += ' og ';
    }
    // if (time.trim().length === 0) {
    //     res.status(400).json({
    //         error: {
    //             message: "Please enter a valid time",
    //         }
    //     });
    //     return;
    // }
    const food = req.body.food || 'fisk';
    // if (food.trim().length === 0) {
    //     res.status(400).json({
    //         error: {
    //             message: "Please enter a valid food",
    //         }
    //     });
    //     return;
    // }
    
    try {
        const completion = await openai.createCompletion({
            model: "text-davinci-003",
            prompt: generatePrompt(time, food),
            temperature: 0.5,
            max_tokens: 1000,
        });
        console.log(completion.data);
        res.status(200).json(completion.data.choices[0].text);
    } catch(error: any) {
        // Consider adjusting the error handling logic for your use case
        if (error.response) {
            console.error(error.response.status, error.response.data);
            res.status(error.response.status).json(error.response.data);
        } else {
            console.error(`Error with OpenAI API request: ${error.message}`);
            res.status(500).json({
                error: {
                    message: 'An error occurred during your request.',
                }
            });
        }
    }
});
    
function generatePrompt(time: string, food: string) {
    console.log(time);
    return `Jeg vil ha middager for disse dagene ${time}, og ingen andre dager, bare disse dagene. Jeg liker ting som ${food}, men vil ha andre ting enn bare dette. Har du linker til oppskrifter legg de med. Gi meg resultatet i json format. Ett gyldig json format jeg kunne forventet hadde vært { "days": [{"dag": "mandag", "middag": "stekt skrei med ratatouille" ,"link": "https://www.matprat.no/oppskrifter/kos/stekt-skrei-med-ratatouille/", "tid":"60min"}], "ingredients": ["2 skrei", "6 poteter", "oliven olje", "salt", "pepper"]}`;
}
    

export default app;
