

* Why linux kernel use trap gate to handle divide_error exception ?
	*   DPL bit in IDT is looked at only when software interrupt is called with the int instruction. Division by zero is a software interrupt triggered by the CPU and thus has DPL has no effect in this case
