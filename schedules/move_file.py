import os
import random
import shutil

def get_all_md_files(root_folder):
    md_files = []
    for dirpath, _, filenames in os.walk(root_folder):
        for filename in filenames:
            if filename.endswith('.md'):
                md_files.append(os.path.join(dirpath, filename))
    return md_files

def move_random_md_file(src_folder, dest_folder):
    md_files = get_all_md_files(src_folder)
    if not md_files:
        print("No .md files found in the source folder.")
        return

    random_md_file = random.choice(md_files)
    dest_path = os.path.join(dest_folder, os.path.basename(random_md_file))

    shutil.move(random_md_file, dest_path)
    print(f"Moved {random_md_file} to {dest_path}")

# 使用例
src_folder = 'stocks'
dest_folder = 'articles'
move_random_md_file(src_folder, dest_folder)
