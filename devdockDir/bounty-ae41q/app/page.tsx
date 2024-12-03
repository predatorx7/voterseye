"use client";
import { useState, useEffect } from 'react';
import { Reclaim } from '@reclaimprotocol/js-sdk';
import QRCode from 'react-qr-code';
import { useAccount, useContractWrite } from 'wagmi';
import { ethers } from 'ethers';
import VotingABI from '../contracts/VotingContract.json';

const CONTRACT_ADDRESS = '0x9d2ade18cb6bea1a';
const APP_ID = 'YOUR_APP_ID';
const APP_SECRET = 'YOUR_APP_SECRET';

export default function Home() {
  const [url, setUrl] = useState('');
  const [isVerified, setIsVerified] = useState(false);
  const [votingStatus, setVotingStatus] = useState('');
  const { address } = useAccount();

  const { write: vote } = useContractWrite({
    address: CONTRACT_ADDRESS as `0x${string}`,
    abi: VotingABI,
    functionName: 'vote',
  });

  const reclaimClient = new Reclaim.ProofRequest(APP_ID);

  async function startVerification() {
    try {
      const providerId = 'google-login';
      reclaimClient.addContext(
        'user verification',
        'Verify user for voting'
      );
      
      await reclaimClient.buildProofRequest(providerId);
      reclaimClient.setSignature(
        await reclaimClient.generateSignature(APP_SECRET)
      );
      
      const { proofUrl } = await reclaimClient.createVerificationRequest();
      setUrl(proofUrl);
      
      // Listen for proof submission
      reclaimClient.on('proof-received', async (proof) => {
        setIsVerified(true);
        setUrl('');
      });
    } catch (error) {
      console.error('Error:', error);
    }
  }

  async function submitVote(option: number) {
    try {
      await vote({ args: [option] });
      setVotingStatus('Vote submitted successfully!');
    } catch (error) {
      console.error('Error voting:', error);
      setVotingStatus('Error submitting vote');
    }
  }

  return (
    <main className="min-h-screen p-8">
      <h1 className="text-3xl font-bold mb-8">Secure Voting Platform</h1>
      
      {!isVerified ? (
        <div className="mb-8">
          <h2 className="text-xl mb-4">Step 1: Verify Your Identity</h2>
          {!url ? (
            <button
              onClick={startVerification}
              className="bg-blue-500 text-white px-4 py-2 rounded"
            >
              Start Verification
            </button>
          ) : (
            <div className="p-4 bg-white">
              <QRCode value={url} />
              <p className="mt-4">Scan QR code to verify</p>
            </div>
          )}
        </div>
      ) : (
        <div>
          <h2 className="text-xl mb-4">Step 2: Cast Your Vote</h2>
          <div className="space-x-4">
            <button
              onClick={() => submitVote(1)}
              className="bg-green-500 text-white px-4 py-2 rounded"
            >
              Vote Option A
            </button>
            <button
              onClick={() => submitVote(2)}
              className="bg-green-500 text-white px-4 py-2 rounded"
            >
              Vote Option B
            </button>
          </div>
          {votingStatus && (
            <p className="mt-4 text-green-600">{votingStatus}</p>
          )}
        </div>
      )}
    </main>
  );
}