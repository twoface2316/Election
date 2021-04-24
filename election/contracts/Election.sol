pragma solidity ^0.5.16;

contract Election{
	//Model a Candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}
//store accounts that have voted
mapping(address => bool) public voters;

	//Store Candidate
	//Fetch Candidate
	mapping(uint => Candidate) public candidates;
	//Store Candidates count
	uint public candidatesCount;

	//voted event
	event votedEvent (
		uint indexed _candidateID
	);

	constructor () public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}

	function addCandidate (string memory _name) private {
		candidatesCount ++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);

	}

	function vote (uint _candidateID) public {
		//require that they have not voted before
		require(!voters[msg.sender]);

		//require that they are voting for a valid candidate
		require(_candidateID > 0 && _candidateID <= candidatesCount);

		//record the voter as voted
		voters[msg.sender] = true;


		//update candidate vote count
		candidates[_candidateID].voteCount ++;

		//trigger voted event
		emit votedEvent(_candidateID);
	}
}