Return-Path: <linux-fpga+bounces-1122-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A061A66046
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Mar 2025 22:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96BE18965DE
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Mar 2025 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A941F7916;
	Mon, 17 Mar 2025 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YvBgPm8a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VC3oWJl8"
X-Original-To: linux-fpga@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A223AD;
	Mon, 17 Mar 2025 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246012; cv=none; b=KAw+9CvpV/h0z+d0RsGgf9QtsBKW91kBPjmAxtts1SJ07BuqA5m0Tz9jtvVS3P+2p5dg3fluosx7m+8wR7GIC/hBZEMNkIuIg1urKmqf7QPUb3p9BIdXB+sv0kXzaPzy3utrwXofq45kSf4McH6pArHYEy5r0kTAYTlK+SZIUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246012; c=relaxed/simple;
	bh=yYOd3jMreLhh96SHlZjP/An9FJpVwIyNal1m2L4/Dsw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XAgRgasuUW9Iq7D4LknIuUgWVDW3fuIGUqk5cEfdnHgjuRedlA34zCi6cPBDBAASxOGIicMsY5a1g+iY5ZCW3d4jFiR5xMqI6TAb1cFgEJrCu565AjvcvSBoBtwkPnX2vMBNqViB/Wj93Tuh5IHPiY5SK7KSIp8pwK4pzwcOLk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YvBgPm8a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VC3oWJl8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6139114013B;
	Mon, 17 Mar 2025 17:13:28 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 17 Mar 2025 17:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742246008;
	 x=1742332408; bh=csQL3jgaHqAa0cerUaY+ms6uzsjDBQaO5zpY9KxUV1k=; b=
	YvBgPm8atMAF2SFjAC8MaOiBXyOl99RxIhsRfKDs+4A9unKivIAttUeS5ZBpxVB3
	2rphVMQL0ahKdbnYXA0MpUuG9jpdyYBo73hSgbbZw4hc7VBgz0UZl7F/ML0PlMuy
	bOCptRX/GlkCMradLGPhDicQPnfVO2dJh2GGvbv9kmddMStkO8TYr2mPe5nygFfk
	FECA/vTiJTJ7MshvSisaBixph3F2kc9N1DDZDM/YAVh0NRywSCgO3F3sZ8HySIEJ
	sQCUOXnc+y6iqOTE7I5XhKwIjeWaDIJl9/EVD+zAIr1p2pjeV+AiFKi+hKH4fq6C
	5xpc5xVQskwoCayI6DtCaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742246008; x=1742332408; bh=c
	sQL3jgaHqAa0cerUaY+ms6uzsjDBQaO5zpY9KxUV1k=; b=VC3oWJl84/YL/xcgF
	D89ia5ggLY5bbm/WCxrQlQntKtEwPHlFuwowku/i9OqDVT0T9Nnv4yRh6sQbZlO8
	IvV4obaXfYlz18kNr1PLRwS/8rCWThbdYX6FVIgvBPd9v4abQSLhqYRCB8iMPY6W
	ZOzV9O3A3wKUJG17dh53rF383QxVeRXozrlAv1EUxVePlrda+6CS4XL5MoteGSvy
	oVHkWdfwDq0sm2mK2G0RYT3QgodULFWeZMIRsXFU9ZvVMrj1wTcmkyLNcFqCztOW
	/F7M1riwcgTyRHh+TrHuVEKKjB4m+dH5wkctNOA7B3m7QGEcJ2l6VKrh0YH0+37M
	oBzCg==
X-ME-Sender: <xms:eJDYZ1QVqaNepJ1B77Br42ie11iYONF-jRA6FeTy9qIPDikZXlKwYA>
    <xme:eJDYZ-yojWEPZTUzqMFG-DZNOGuO1IweLSP-mqnXv4qVf1yW382-bx2x2yuDhz_4S
    y34QzFRLFHPwbDTqc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhkeeltdfffefhgffhteetheeuhffgteeghfdt
    ueefudeuleetgfehtdejieffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesrghmugdrtghomhdprh
    gtphhtthhopehnrghvrgdrkhhishhhohhrvgdrmhgrnhhnvgesrghmugdrtghomhdprhgt
    phhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehhrg
    hordifuhesihhnthgvlhdrtghomhdprhgtphhtthhopeihihhluhhnrdiguhesihhnthgv
    lhdrtghomhdprhgtphhtthhopehmughfsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrihigsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:eJDYZ61MBShKX2Iv-ezs1q8gd8IxzWSTK7jwk40j5meGeoPlffuUbA>
    <xmx:eJDYZ9B_hMc-2x3cktxAsp8T0C8bXo1-7u2SGOSzJ9wQFu9dk8ccqw>
    <xmx:eJDYZ-gPQ26HVxKbIZ5y0xBS-p0EhNvegAxg3frAhzQmBBlvYLjAvw>
    <xmx:eJDYZxrSno14T-SlBEklpuubFC4n5QdWx86pOPmN1GE914Jq4IcHpA>
    <xmx:eJDYZzZsrUolXAqhUDIqZE4gAToEKkk5e_Cnyp2H0vsc6FmGsCDH49WV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 557B72220072; Mon, 17 Mar 2025 17:13:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Mar 2025 22:12:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nava kishore Manne" <nava.kishore.manne@amd.com>, git@amd.com,
 mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
 "Tom Rix" <trix@redhat.com>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Message-Id: <7f818704-d40c-42da-b2c5-942d31e1d9dc@app.fastmail.com>
In-Reply-To: <20241029091734.3288005-2-nava.kishore.manne@amd.com>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for runtime FPGA
 programming
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> + * FPGA Region Control IOCTLs.
> + */
> +#define FPGA_REGION_MAGIC	'f'
> +#define FPGA_IOW(num, dtype)	_IOW(FPGA_REGION_MAGIC, num, dtype)
> +#define FPGA_IOR(num, dtype)	_IOR(FPGA_REGION_MAGIC, num, dtype)
> +
> +#define FPGA_REGION_IOCTL_LOAD		FPGA_IOW(0, __u32)
> +#define FPGA_REGION_IOCTL_REMOVE        FPGA_IOW(1, __u32)
> +#define FPGA_REGION_IOCTL_STATUS        FPGA_IOR(2, __u32)

The definition does not appear to match the usage in the driver,
since you don't pass a __u32 structure but instead a 
fpga_region_config_info.

Please also remove the extra FPGA_IOW/FPGA_IOR macros and just use
_IOW/IOR directly so it is possible to process the headers when
identifying ioctl command codes.

The 'f' range seems to be rather overloaded already with filesystem
ioctls:

'f'   00-1F  linux/ext2_fs.h                                         conflict!
'f'   00-1F  linux/ext3_fs.h                                         conflict!
'f'   00-0F  fs/jfs/jfs_dinode.h                                     conflict!
'f'   00-0F  fs/ext4/ext4.h                                          conflict!
'f'   00-0F  linux/fs.h                                              conflict!
'f'   00-0F  fs/ocfs2/ocfs2_fs.h                                     conflict!

In particular, the numbers you have defined are very similar to these:
some of these:

#define FS_IOC_GETFLAGS                 _IOR('f', 1, long)
#define FS_IOC_SETFLAGS                 _IOW('f', 2, long)

      Arnd

