Return-Path: <linux-fpga+bounces-1094-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87742A4D639
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Mar 2025 09:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A366D169D6A
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Mar 2025 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A3D1FBCA1;
	Tue,  4 Mar 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NUq8Bkte";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xl53Kcz7"
X-Original-To: linux-fpga@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5A1F7580;
	Tue,  4 Mar 2025 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076701; cv=none; b=GW/JBEnYu/76g5hSWIxsP0RVC4SOVEruSlOVihPQqZB/Dq2UUHsZWGG0bGtJHl8r1XJpj3MQewtdzsQsOO4dEv1UpoojYR8HEl3ZpWAa5+nOfQ34VeXE45+ze1H9O/9L7SMyGbz+XkP/5iL2IvSmTs0426Z6xk8e2ahbw+Bh2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076701; c=relaxed/simple;
	bh=Y27aUZUPxKEH7unyFscw2X5BcFy8avKpTq7I1tRtmds=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EHy1ay+x3+qGHY8obkU41y7UJFZl/aAhwnjOGRZd6p18yB76Azw8K7LFqTa1gioZL7th2JC3yxfN1fpsOnnQBLK/tDA0eMX9Xnxp3JKrA1pTvMBqffJaV0T8FKaI8TL8unNl2X5FhXBi1UTR56a+IUdXxsNk3laD9ffZH9pGEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NUq8Bkte; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xl53Kcz7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3755A138271B;
	Tue,  4 Mar 2025 03:24:57 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Tue, 04 Mar 2025 03:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741076697;
	 x=1741163097; bh=zM8W7tdbTUdh4T3yYERRBHG5NlNdx6XcKTrnIct3zRg=; b=
	NUq8BkteQO6SDuLIORjsSkvajlvhU0vmiYacEBWhSW03bgh650C3v0bWKr5s46Td
	riWSiSr0oA8W18I3RoDBz8CPAHAkyUy7yEMDGasexuzv+Ycky3MnIBGB+k33c1nw
	nmkQ01VFlBTOfAlWhJh1IkurVsumBzOLe9LnvC/tIqix95bQBamre4ja7OdKnq9N
	mIqKikbutblaiAgDLTuPNF2dAKHScNfnbLaa1or3d9xnbhc8ZSUoVvcbiLlo7kIb
	mnHXXJDYdaRhl83XYWEpHjLaLTTOZj7be4UzShhBuHYlrk6PSbJXGkQBS9sB+VQv
	FQABJrie9F0CutJk+bTR0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741076697; x=
	1741163097; bh=zM8W7tdbTUdh4T3yYERRBHG5NlNdx6XcKTrnIct3zRg=; b=x
	l53Kcz7eoJFaWQ3J80H/MML1fxGTcZZVNXX6xkWLLDQc4Lmaw3N/mxQiO5vG2xRQ
	AbF3v6GkKXcrfDs07L9QY0QfXUS86yTwVu1iy7Vvj3co519RCBsudtCAMG7xfDS1
	yesQIgiG8Al68a3NzBAgB+1doLcgKSEv9c4wPesA5Eq7xP2bTr2iFY7NUEyz4rJt
	iq1tp4C6z9uOiAz3DVYvdjMaAc91lceHrhRVnrHq8kRICJ2RONPEns4d8j1nlj1G
	1dzhrvF0+U1RqlIaDU2klIdiTpFKpmE/YrgcWrpNQ12evxJ27xAZ3bD+IJRJJgKC
	a9QtpDfwr7r6LSlqU1TVA==
X-ME-Sender: <xms:2LjGZ2lX9OfR4lGZuLLRFZg7KDUv9_hRnViHfTziVrX3m07gNPsP3w>
    <xme:2LjGZ92pUzSj-Ya5NUmKCsML3ldN90dsm3icq5Enp85JAb8Dgo4O-K726OPeQ6jtq
    3R6P0iV0_XP-4Pexr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdduheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    udelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtohepjhhonhgrthhhrghnrdhlvghmohhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprhhitghhrghruggtohgthhhrrghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehtihgrnhhfvghirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghrnh
    gusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhnih
    igrdguvgdprhgtphhtthhopehvrgguihhmrdhfvgguohhrvghnkhhosehlihhnuhigrdgu
    vghv
X-ME-Proxy: <xmx:2LjGZ0o5WKeDUjYeoVcADYBT1YDKDZrZMuwPclwev2XUMqDqG5_C7Q>
    <xmx:2LjGZ6lMJMUzvr9YtGi3OE6Aoen1JeNiEGUZ6pWqfW6_9uNCsWxcHA>
    <xmx:2LjGZ00-ZAOpXYzNNzMAdFkk56eWG7NSDp5nwVwHwh6ujX7mxIxZNw>
    <xmx:2LjGZxtRijeuEEYADWPTTa007tr36CMAFgbpXtJ4ipsNvinR8QLJwg>
    <xmx:2bjGZ7uvsRHe2_21oQ-V2KHV9q2qGTbCMXAvb9jx2m2DyDUA8JruI20p>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 29A7C2220072; Tue,  4 Mar 2025 03:24:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 04 Mar 2025 09:24:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Richard Cochran" <richardcochran@gmail.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Tianfei Zhang" <tianfei.zhang@intel.com>,
 "Jonathan Lemon" <jonathan.lemon@gmail.com>,
 "Vadim Fedorenko" <vadim.fedorenko@linux.dev>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Calvin Owens" <calvin@wbinvd.org>, "Philipp Stanner" <pstanner@redhat.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org
Message-Id: <7fd3c712-4c31-435c-80c1-1e042c9b5999@app.fastmail.com>
In-Reply-To: <Z8Z87mkuRqE6VOTy@hoboy.vegasvil.org>
References: <20250227141749.3767032-1-arnd@kernel.org>
 <Z8CDhIN5vhcSm1ge@smile.fi.intel.com> <Z8TFrPv1oajA3H4V@hoboy.vegasvil.org>
 <Z8VfKYMGEKhvluJV@smile.fi.intel.com> <Z8Z87mkuRqE6VOTy@hoboy.vegasvil.org>
Subject: Re: [PATCH] RFC: ptp: add comment about register access race
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 4, 2025, at 05:09, Richard Cochran wrote:
> On Mon, Mar 03, 2025 at 09:50:01AM +0200, Andy Shevchenko wrote:
>> Perhaps it's still good to have a comment, but rephrase it that the code is
>> questionable depending on the HW behaviour that needs to be checked.
>
> IIRC both ixp4xx and the PCH are the same design and latch high reg on
> read of low.

Ok, if that's a common thing, let's assume that the drivers are
all correct for the respective hardware and discard my patch.

With the patch I have queued up in the asm-generic tree, the
behavior changes so ioread64_lo_hi() no longer gets turned
into a single 64-bit access, and that is then more likely to
be correct for both 32-bit and 64-bit architectures in case the
device doesn't actually implement 64-bit transactions but does
correctly latch the contents.

      Arnd

