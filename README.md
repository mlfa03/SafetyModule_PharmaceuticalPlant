# Safety Module for a Pharmaceutical Plant

Process control code for a pharmaceutical process plant. 

This code was developed in Fortran 90, during my masters course at COPPE - UFRJ (Federal University of Rio de Janeiro). 

###*The code present in this repository so far is the starter code for the simulations. Sample simulations and results will be added later*

### Description
The project was developed at a pharmaceutical pilot plant, the first one in Brazil for polymers. An advanced process control software was developed to improve process control of the reactions conducted on a 10 L reactor. This software comprised:
- A reconciliation of data module, extrating data from the instruments from the plant
- An MPC control module, for controlling the process using predictions
- A safety module, to predict all possibilities of failures and its outcomes , to define the safe parameters for the process. The code for this module is in this repository. 

The next step was scaling up the software for the 50L and 100L reactors in the plant. 

### Motivation 
The process plant subject to this project produces a polymer, PMMA, which is being used in research by FIOCRUZ and other prestigious institutions, on the treatment of different types of cancer. 

At the time of the development of this project, 2013-2014, the process plant was aplying for a Certificate of Good Manufacturing Practices by ANVISA. One of the several requirements for this certificate to be issued is that the process must ensure repeatability and reproducibility so that the final product meets a certain specification. This project focused on this requirement, as well as on producing the product with a certain distribution of diameters specific for the studies on pancreatic cancer. 


### Process control of polymerization processes
Polymerization reactions are very difficult to control with PLCs (programmable logical controllers), a very common control system in industrial plants. PLCs use algebraic equations to control industrial processes which you can translate into linear models. Instruments on the facilities measure several variables such as, pressure and temperature. The system also comprises actuators, which send signals to the instruments in the facility to perform an action, for example, close the valve which provides heating to a reactor. These actuators are triggered when a dangerous situation is detected - which means that a control variable deviates from the set point. An example of this is the pressure inside a reactor, which can be too high. 

In polymerization reactions, as they are irreversible reactions, process control must focus on preventing failures instead of tuning the PLC parameters to perform actions. It is unlikely that a tradiditional PLC can control a polymerization reaction safely, as this type of reaction, because of it irreversibility, can go out of control if process parameters deviate from a safe range. 

Therefore, predictive control is fundamental for the safety and success of this type of reaction. 
