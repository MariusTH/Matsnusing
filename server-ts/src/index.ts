import * as dotenv from 'dotenv' // see https://github.com/motdotla/dotenv#how-do-i-use-dotenv-with-import
dotenv.config()

import openai from './openai';

const PORT = 3000;
openai.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});