from pysat.solvers import Solver
import time

for j in range(50,250,50):
   num_vars = j 
   var_map = {f'a({i})': i+1 for i in range(num_vars)}  
   clauses = [[-var_map[f'a({i})'], var_map['a(0)']] for i in range(1, j)]  
   clauses.append([-var_map['a(0)'], var_map['a(1)']]) 
   negated_query = [[var_map['a(0)']], [-var_map['a(1)']]] 
   for solver_type in ['g3', 'lgl','mcm', 'cd' ]:
      solver = Solver(name=solver_type)  
      for clause in clauses + negated_query:
         solver.add_clause(clause)
      start_time = time.perf_counter()
      result = solver.solve()
      end_time = time.perf_counter()
      with open('results','+a') as file:
         file.writelines(f'{solver_type}\n')
         file.writelines(f'Knowledge base size:{j}\n')
         file.writelines(f'Time taken:{end_time - start_time}\n')
      solver.delete()
