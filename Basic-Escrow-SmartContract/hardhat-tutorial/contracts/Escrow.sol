// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Escrow {
    struct EscrowAgreement {
        uint256 AgreementId;
        address payable buyer;
        address payable seller;
        address payable arbitrator;
        // amount of funds held in escrow
        uint256 amount;
        // whether the funds have been released or not
        bool Fundreleased;
        // whether the agreement has been cancelled or not
        bool cancelled;
    }

    mapping(uint256 => EscrowAgreement) public agreements;
    uint256 public numOfAgreement;

    function createEscrowAgreement(
        uint256 _agreementId,
        address payable _buyer,
        address payable _seller,
        address payable _arbitrator
    ) public payable {
        require(
            _buyer != address(0) &&
                _seller != address(0) &&
                _arbitrator != address(0),
            "Invalid client or services or arbitrator."
        );

        EscrowAgreement storage escrowAgreement = agreements[numOfAgreement];
        escrowAgreement.AgreementId = _agreementId;
        escrowAgreement.buyer = _buyer;
        escrowAgreement.seller = _seller;
        escrowAgreement.arbitrator = _arbitrator;
        escrowAgreement.amount = msg.sender;
        escrowAgreement.Fundreleased = false;
        escrowAgreement.cancelled = false;

        numOfAgreement++;
    }


// -------------above  did till here-------



    // function for the buyer to release the funds to the seller
    function releaseFunds() public {
        require(
            !released && !cancelled,
            "Agreement has already been completed or cancelled"
        );
        seller.transfer(amount);
        released = true;
    }

    // function for the buyer to cancel the agreement and retrieve their funds
    function cancelAgreement() public {
        require(
            !released && !cancelled,
            "Agreement has already been completed or cancelled"
        );
        buyer.transfer(amount);
        cancelled = true;
    }

    // function for the arbitrator to resolve any disputes and release the funds to the appropriate party
    function resolveDispute() public {
        require(
            !released && !cancelled,
            "Agreement has already been completed or cancelled"
        );
        // code to resolve dispute goes here
        // ...
        // once dispute is resolved, release funds to appropriate party
        address partyToReceiveFunds = partyToReceiveFunds.transfer(amount); // determine party to receive funds based on dispute resolution;
        released = true;
    }
}
