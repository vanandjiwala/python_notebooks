import streamlit as st
from langchain.agents import create_csv_agent
from langchain.llms import OpenAI
from dotenv import load_dotenv
import os
def main():
    load_dotenv()

    st.set_page_config(page_title="CSV Agent Demo")
    st.header("Ask CSV Questions")
    csv_file = st.file_uploader("Upload your CSV file", type="csv")

    if csv_file is not None:
        question = st.text_input(label="Ask your question here")

        llm = OpenAI(temperature=0)
        agent = create_csv_agent(llm=llm, path=os.path.join(os.getcwd(),csv_file.name), verBose=True)

        if question is not None and question != "":
            response = agent.run(question)
            st.write(response)

if __name__ == '__main__':
    main()