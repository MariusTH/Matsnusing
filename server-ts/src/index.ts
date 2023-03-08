import openai from './openai';

const PORT = 3000;
openai.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});