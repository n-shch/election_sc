import brownie

def test_vote(accounts, election_sc, Election, chain):
    owner = accounts[0]
    election_sc = Election.deploy("Alise", 1, {"from": accounts[0]})

    election_sc.vote({"from": accounts[1]})
    chain.sleep(86400 * 30)

    assert ("Alise", 1) == election_sc.getCandidate()
    assert election_sc.totalVotes() == 1


def test_get_candidate(accounts, election_sc, Election):
    owner = accounts[0]
    election_sc = Election.deploy("Alise", 1, {"from": accounts[0]})
    
    assert ("Alise", 0) == election_sc.getCandidate()