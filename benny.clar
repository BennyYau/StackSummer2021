;; NFT

;;  .(contract-name).(trait-name)
(impl-trait .sip009-nft-trait.nft-trait)

(define-constant contract-owner tx-sender)

(define-non-fungible-token benny-token uint)

(define-data-var last-token-id uint u0)

(define-public (mint)
	(let
		(
			(token-id (+ (var-get last-token-id) u1))
		)
		;; Check that the tx-sender is equal to the contract-owner.
		(asserts! (is-eq contract-owner tx-sender) (err u100))
		(var-set last-token-id token-id)
		(nft-mint? benny-token token-id tx-sender)
	)
)

(define-public (get-last-token-id)
	(ok (var-get last-token-id))
)

(define-read-only (get-token-uri (token-id uint))
	(ok none)
)

(define-read-only (get-owner (token-id uint))
	(ok (nft-get-owner? benny-token token-id))
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
	(begin
		;; Check that the tx-sender and sender are equal.
		;; The error we emit (err u101) has no special meaning.
		(asserts! (is-eq tx-sender sender) (err u101))
		(nft-transfer? benny-token token-id sender recipient)
	)
)