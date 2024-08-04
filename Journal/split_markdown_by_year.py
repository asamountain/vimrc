import os
import re

def split_markdown_by_year(file_path):
    # Read the content of the markdown file
    with open(file_path, 'r') as file:
        content = file.readlines()

    # Variables to track the current year and content for each year
    current_year = None
    yearly_content = []

    # Create output directory if it doesn't exist
    output_dir = "yearly_files"
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    # Regular expression to match date format '9 Dec 2017'
    date_pattern = re.compile(r'\b\d{1,2}\s+\w+\s+(\d{4})\b')

    for line in content:
        match = date_pattern.match(line)
        if match:
            year = match.group(1)
            if current_year != year:
                # New year section found
                if current_year is not None:
                    # Write the previous year's content to a new file
                    with open(os.path.join(output_dir, f"{current_year}.md"), 'w') as year_file:
                        year_file.writelines(yearly_content)
                    yearly_content = []

                current_year = year
            yearly_content.append(line)
        else:
            if current_year is not None:
                yearly_content.append(line)

    # Write the last year's content to a new file
    if current_year is not None:
        with open(os.path.join(output_dir, f"{current_year}.md"), 'w') as year_file:
            year_file.writelines(yearly_content)

# Specify the path to your markdown file
file_path = 'akilah-garden-analysis.md'
split_markdown_by_year(file_path)

