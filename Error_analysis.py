def split_text_file_into_list_of_integers(file_path):
    with open(file_path, 'r') as file:
        content = file.read()
        lines = content.splitlines()  
        integer_list = [int(line) for line in lines if line.strip().isdigit()]  
    return integer_list

# Example usage
file_path1 = '/home/tinu/project_7/project_7.sim/sim_1/behav/xsim/output.txt'  
file_path2 = '/home/tinu/project_6/project_6.sim/sim_1/behav/xsim/output.txt'

integer_list1 = split_text_file_into_list_of_integers(file_path1)
integer_list2 = split_text_file_into_list_of_integers(file_path2)
print(integer_list1[0],integer_list2[0])

if len(integer_list1) != len(integer_list2):
    print("Error: The lists are not of the same length.")
else:

    lister = [a - b for a, b in zip(integer_list1, integer_list2)]

    print("Length of integer_list1:", len(integer_list1))
    print("Length of integer_list2:", len(integer_list2))
    print("Result of subtraction:", lister)
print(integer_list1[0],integer_list2[0])

x=sum(lister)
nmed=x/len(integer_list1)
print (x,nmed)
