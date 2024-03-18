# def printParents(node, adj, parent):

#     # current node -> root --> no parent
#     if (parent == 0):
#         print(node, "->Root")
#     else:
#         print(node, "->", parent)


#     for cur in adj[node]:
#         if (cur != parent):
#             printParents(cur, adj, node)

# # Driver Program
# N = 7       # number of nodes
# Root = 1    # root node

# # prepare the Adjacency list to store the tree..
# adj = []
# for i in range(0, N + 1):
#     adj.append([])


# # create a tree
# adj[1].append(2)
# adj[2].append(1)

# adj[1].append(3)
# adj[3].append(1)

# adj[1].append(4)
# adj[4].append(1)

# # parent of each node
# printParents(Root, adj, 0);

# Tree definition and Traversal
class Node:
    def __init__(self, key) -> None:
        self.left = None
        self.right = None
        self.val = key

    